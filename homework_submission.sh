#!/bin/bash
################################################################################
# Author:       Summer Wang <xwang@osc.edu>
# Date:         08/10/2017

# This script is used by PI of classroom project to 
# 1. Generate "submit" which is used by students to submit homework
# 2. Create a designated directory where students submit their homework 
###############################################################################

#Get name of email of the PI
PROF=`finger $USER |grep Name | awk '{$1=$2=$3="";print}'`
EMAIL=`finger $USER |grep Mail | awk '{print $4}'`
# Default size limit of one homework submitted by each student, 1000 MB
SIZE_DEFAULT=1000
#Default path where submission directory is created. For now, use the current directory where the script runs. 
PATH_DEFAULT=`pwd`


# Functions

# This function is to create a directory where students submit their homework
# File permissions of this directory is set at 1731
create_directory()
{
DESTINATION="$path/$course/Submissions/$assignment"
SUBMISSION_FOLDER="$path/$course/Submissions"
COURSE_FOLDER="$path/$course" 
if [ -d "$DESTINATION" ]; then
 echo "****************************************************************************************"
 echo "$DESTINATION exists. Please provide a different assignment name or delete the current directory. Exit"
 echo ""
 exit
else
 mkdir -p $DESTINATION
   if [ -d "$DESTINATION" ]; then
     chmod 1711 $COURSE_FOLDER
     chmod 1711 $SUBMISSION_FOLDER 
     chmod 1731 $DESTINATION
     if [[ $ta_account != $PROF ]]; then
      setfacl -R -m u:$ta_account:rx $DESTINATION
     fi
     while [[ $SUBMISSION_FOLDER != "/" ]] 
     do
       check_p=`ls -ld $SUBMISSION_FOLDER | awk '{print $3}'`
       if [[ ($check_p = $USER) ]]; then
        chmod g+x $SUBMISSION_FOLDER
       fi
       SUBMISSION_FOLDER=$(dirname $SUBMISSION_FOLDER)
     done
     echo "****************************************************************************************"
     echo "$DESTINATION is created successfully."
     echo "Your students can submit assignment to $DESTINATION"
     echo " "
   else 
     echo "****************************************************************************************"
     echo "$DESTINATION is not created. Please check error message or contact oschelp@osc.edu for assistance. Exit"
     echo " "
     exit
   fi
fi
}

create_submit()
{
SUBMISSION_FOLDER="$path/$course/Submissions"

cd $SUBMISSION_FOLDER

if [[ -f "submit.sh" ]]; then
 echo "****************************************************************************************"
 echo "submit.sh has been created before with the following options:"
 cat submit.sh | sed -n '4p'
 echo " "
 echo "Do you want to delete the current submit.sh and create a new one? Enter [y/n]. The submit.sh will be re-created if you simply press [ENTER]"
 read reply_delete
 if [[ !($reply_delete = 'n') ]]; then
 reply_delete=y
 fi 
fi

if [[ (-f "submit.sh") && ($reply_delete = 'n') ]]; then
 exit
else  
cat << EOF >submit.sh
#Submits a student's assignment into a designated submission directory
#Every use by the student deletes any previous submissions
#Use: $path/$course/submit
#The size limit of one assignment submitted by each student is $size MB

submit_homework()
{
DESTINATION="$path/$course/Submissions/\$assignment_s"
CLONE="\$DESTINATION/\$USER"
EMAIL_S="\$(finger \$USER |grep Mail | awk '{print \$4}')"
Permission="\$(ls -ld \$DESTINATION | awk '{print \$1}')"

if [[ \$Permission = 'drwx-wx--t' ]] || [[ \$Permission = 'drwxrwx--t+' ]]; then
 if [[ !( -f "\$DESTINATION/submit_log_\$USER.txt") ]]; then
 touch \$DESTINATION/submit_log_\$USER.txt
 fi
 chmod 750 \$DESTINATION/submit_log_\$USER.txt

 if [ -d "\$CLONE" ]; then
     rm -R "\$CLONE"
 fi
 cp -R "\$submit_path" "\$CLONE"
 chmod -R 770 \$CLONE
 chmod -R 700 \$submit_path
 Submit_time=\$(date)
  if [ -d "\$CLONE" ]; then 
   echo "Your assignment \$assignment_s is submitted succesfully. Thank you!"
   echo "\$USER submitted assignment \$assignment_s in \$submit_path at \$Submit_time" >>\$DESTINATION/submit_log_\$USER.txt
    if [[ $reply_email = 'y' ]]; then
       echo "\$USER submitted assignment \$assignment_s in \$submit_path at \$Submit_time" | mail -s "\$assignment_s from \$USER is submitted succesfully" -c $EMAIL \$EMAIL_S
    else
       echo "\$USER submitted assignment \$assignment_s in \$submit_path at \$Submit_time" | mail -s "\$assignment_s from \$USER is submitted succesfully" \$EMAIL_S
    fi
  else
   echo "Your assignment \$assignment_s is NOT submitted. Please check with your professor"
   echo "Your assignment \$assignment_s is NOT submitted at \$Submit_time" >>\$DESTINATION/submit_log_\$USER.txt
  fi
 cp \$DESTINATION/submit_log_\$USER.txt \$submit_path
 chmod u-w \$DESTINATION/submit_log_\$USER.txt  
else
  echo "You may pass the deadline and can't submit your assignment \$assignment_s. Please check with your professor"
  exit
fi   
}


### Main script starts here
echo "*********************************************************************************************"
echo "Hello. This script will submit your assignment assigned by $PROF to OSC"
echo "Note:"
echo "Before you run this script, please create one directory which includes all the files you want to submit"
echo "The previous submission of the same assignment from you will be replaced by the new submission"
echo ""

PATH_SDEFAULT="\$(pwd)"
echo "Enter the name of assignment and press [ENTER]"
read -p ">>>" assignment_input
if [[ -z "\$assignment_input" ]]; then
 echo "Assignment name is empty. Exit"
 exit
fi
assignment_s="\$(echo \$assignment_input | tr [A-Z] [a-z])"
DESTINATION="$path/$course/Submissions/\$assignment_s"
CLONE="\$DESTINATION/\$USER"
while [[ !(-d "\$DESTINATION") ]]
 do
  echo "****************************************************************************************"
  echo "This assignment submission directory does not exist. Please submit a different assignment or check with your professor." 
  echo "Enter \"quit\" if you want to quit"
  read -p ">>>" assignment_input
  if [[ \$assignment_input == "quit" ]]; then
     exit
  fi
 assignment_s="\$(echo \$assignment_input | tr [A-Z] [a-z])" 
 DESTINATION="$path/$course/Submissions/\$assignment_s"
 CLONE="\$DESTINATION/\$USER"
done


if [[ -d "\$CLONE" ]]; then
  echo "You have submitted your assignment \$assignment_s before."
  echo "Enter \"quit\" if you want to quit."
  echo "Otherwise enter the absolute path of the directory which includes all the files of your assignment \$assignment_s."
  echo "The previous submission of your assignment \$assignment_s will be replaced by the new submission."
else 
 echo "Enter the absolute path of the directory which includes all the files of your assignment \$assignment_s and press [ENTER]"
fi

echo "You will submit the current directory if you simply press [ENTER]"

read -p ">>>" submit_path
if [[ \$submit_path == "quit" ]]; then
  exit
elif [[ -z "\$submit_path" ]]; then
 submit_path=\$PATH_SDEFAULT
fi

if [ -d "\$submit_path" ]; then
submission_size="\$(du -m -s \$submit_path | awk '{print \$1}')"
 if [[ \$submission_size -gt $size ]]; then
   echo "The size of your directory is over $size MB. Please compress the files to be less than $size MB and resubmit. Exit"
   exit 
 fi
else
  echo "\$submit_path does not exist. Please enter a valid path. Exit"
  exit
fi

submit_homework \$assignment_s \$submit_path
EOF
fi
chmod 750 submit.sh
cp /fs/scratch/xwang/bin/submit.C $path/$course/Submissions
newline=system\(\"$path/$course/Submissions/submit.sh\"\)\;
sed -i "/system/c $newline" submit.C
gcc -o submit submit.C
chmod 750 submit
rm submit.C
mv submit $path/$course
echo "submit has been generated successfully"
echo "Your students can submit homework using the command: $path/$course/submit"
echo "** Note:"
echo "** Do not share $path/$course/Submissions/submit.sh with your students!"
}


### Main script starts here
echo "********************************************************************"
echo "Hello, "$PROF".  This script will
1. Generate submit which is used by students to submit assignment
2. Create a designated directory where students submit their assignment"
echo " "

echo "Enter the absolute path in /fs/project where the submission direcotry will be created. 
The submission direcotry will be created within the directory $PATH_DEFAULT if you simply press [ENTER]"
read -p ">>>" path
if [[ -z "$path" ]]; then
 path=$PATH_DEFAULT
fi
if [[ !(-d "$path") ]]; then
 echo "$path does not exist. Please enter a valid path. Exit"
 exit 
fi
if [[ $path != *"/fs/project"* ]]; then
 echo "$path is not in /fs/project.Please use the project space allocated to your classroom project. Exit"
 exit
fi
echo " "

echo "Enter the course number."
read -p ">>>" course_input
if [[ -z "$course_input" ]]; then
 echo "Course number is empty. Exit"
 exit
fi
course=`echo $course_input | tr [a-z] [A-Z]`

echo "Enter the name of assignment and press [ENTER]"
read -p ">>>" assignment_input
if [[ -z "$assignment_input" ]]; then
 echo "Assignment name is empty. Exit"
 exit
fi
assignment=`echo $assignment_input | tr [A-Z] [a-z]`
DESTINATION="$path/$course/Submissions/$assignment"
while [ -d "$DESTINATION" ]
 do
  echo "****************************************************************************************"
  echo "This assignment submission directory exists. Please provide a different assignment name or delete the current directory." 
  echo "Enter \"quit\" if you want to quit"
  read -p ">>>" assignment_input
  if [[ $assignment_input == "quit" ]]; then
     exit
  fi
  assignment=`echo $assignment_input | tr [A-Z] [a-z]`
  DESTINATION="$path/$course/Submissions/$assignment"
done

echo "Do you have a TA and want to provide your TA the access to the files, too [y/n]?"
read -p ">>>" reply_ta
if [[ $reply_ta = 'y' ]]; then
 echo "Please provide your TA's OSC HPC account"
 read -p ">>>" ta_account
else
 ta_account=$PROF
fi
echo ""


echo "Enter the size limit of one assignment submitted by each student, in MB (megabyte). Integer only.
The size limit of one assignment submitted by each student is $SIZE_DEFAULT MB if you simply press [ENTER]"
read -p ">>>" size
if [[ -z "$size" ]]; then
 size=$SIZE_DEFAULT
fi
re='^[0-9]+$'
while [[ !($size =~ $re) ]]  
 do
  echo "Not a valid value. Enter the size limit, in MB (megabyte)
        For example, if you want to limit the size to 40MB, enter 40 and press [ENTER]" 
 read -p ">>>" size
 done
echo ""

echo "The student will receive an email notification after he/she submits the homework. Do you want to get email notification, too [y/n]?"
read -p ">>>" reply_email
if [[ $reply_email = 'y' ]]; then
 echo "An email notification will be sent to both the student and your email ($EMAIL) after his/her homework has been submitted"
else 
 reply_email='n'
 echo "An email notification will be sent to the student after his/her homework has been submitted"
fi
echo ""

create_directory $path $assignment $ta_account
create_submit $path $course $assignment $size $reply_email 
