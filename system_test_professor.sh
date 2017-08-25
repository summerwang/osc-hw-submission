#!/bin/bash
################################################################################
# Author:       Summer Wang <xwang@osc.edu>
# Date:         08/23/2017
###############################################################################

#Test: basic functions using Home directory
# 1. Directories and submit can be created
# 2. All within the right permissions 

cd $HOME
professor=`mktemp -d professor.XXXXXXXX`

cd $professor
/fs/scratch/xwang/bin/submit_prepare << _P_EOF_

cse01
hw1


_P_EOF_
#
if [ $? -ne 0 ]; then
   echo "ERROR: submit_prepare failed with $?"
   exit $?
fi
#
if [ ! -f "$HOME/$professor/CSE01/submit" ]; then
   echo "ERROR: No submit executable using [Enter] in home directory"
   exit 1
fi
if [ ! -d "$HOME/$professor/CSE01/Submissions/hw1" ]; then
   echo "ERROR: No Submissions directory using [Enter] in home directory"
   exit 1
fi
Permission="$(ls -ld $HOME/$professor/CSE01 | awk '{print $1}')"
if [[ "$Permission" = 'drwx--x--t' ]]; then
 Permission="$(ls -ld $HOME/$professor/CSE01/Submissions | awk '{print $1}')" 
 if [[ "$Permission" = 'drwx--x--t' ]]; then 
  Permission="$(ls -ld $HOME/$professor/CSE01/Submissions/hw1 | awk '{print $1}')"
  if [[ "$Permission" = 'drwx-wx--t' ]]; then
   echo "  "
  else
   echo "Error with Permissions on directory hw1"
   exit 1
  fi
 else
   echo "Error with Permissions on directory Submissions"
   exit 1
 fi 
else
 echo "Error with Permissions on directory CSE01"
 exit 1
fi  
  
Permission="$(ls -l $HOME/$professor/CSE01/submit | awk '{print $1}')"
if [[ "$Permission" = '-rwxr-x---' ]]; then
 Permission="$(ls -l $HOME/$professor/CSE01/Submissions/submit.sh | awk '{print $1}')"
 if [[ "$Permission" = '-rwxr-x---' ]]; then
  echo " "
 else
  echo "Error with Permissions on submit.sh"
  exit 1
 fi
else
  echo "Error with Permissions on submit"
  exit 1
fi
#
#Test: create directory in home directory with specified path
/fs/scratch/xwang/bin/submit_prepare << _P_EOF_
$HOME/$professor
cse02
lab2


_P_EOF_
#
if [ $? -ne 0 ]; then
   echo "ERROR: submit_prepare failed with $?"
   exit $?
fi
#
if [ ! -f "$HOME/$professor/CSE02/submit" ]; then
   echo "ERROR: No submit executable specifying path in home directory"
   exit 1
fi
if [ ! -d "$HOME/$professor/CSE02/Submissions/lab2" ]; then
   echo "ERROR: No Submissions directory specifyiing path in home directory"
   exit 1
fi

rm -fr $HOME/$professor

#Test: create directory in scratch with right permission 

if [[ ! -d /fs/scratch/$USER ]]; then
 mkdir /fs/scratch/$USER
fi

cd /fs/scratch/$USER
professor=`mktemp -d professor.XXXXXXXX`
cd $professor
/fs/scratch/xwang/bin/submit_prepare << _P_EOF_

cse01
hw1


_P_EOF_
#
if [ $? -ne 0 ]; then
   echo "ERROR: submit_prepare failed with $?"
   exit $?
fi
#
if [ ! -f "/fs/scratch/$USER/$professor/CSE01/submit" ]; then
   echo "ERROR: No submit executable specifying path in scratch directory"
   exit 1
fi
if [ ! -d "/fs/scratch/$USER/$professor/CSE01/Submissions/hw1" ]; then
   echo "ERROR: No Submissions directory specifyiing path in scratch directory"
   exit 1
fi

Permission="$(ls -ld /fs/scratch/$USER/$professor/CSE01 | awk '{print $1}')"
if [[ "$Permission" = 'drwx--x--t' ]]; then
 Permission="$(ls -ld /fs/scratch/$USER/$professor/CSE01/Submissions | awk '{print $1}')"
 if [[ "$Permission" = 'drwx--x--t' ]]; then
  Permission="$(ls -ld /fs/scratch/$USER/$professor/CSE01/Submissions/hw1 | awk '{print $1}')"
  if [[ "$Permission" = 'drwx-wx--t' ]]; then
   echo "  "
  else
   echo "Error with Permissions on directory hw1 on scratch"
   exit 1
  fi
 else
   echo "Error with Permissions on directory Submissions on scratch"
   exit 1
 fi
else
 echo "Error with Permissions on directory CSE01 on scratch"
 exit 1
fi

Permission="$(ls -l /fs/scratch/$USER/$professor/CSE01/submit | awk '{print $1}')"
if [[ "$Permission" = '-rwxr-x---' ]]; then
 Permission="$(ls -l /fs/scratch/$USER/$professor/CSE01/Submissions/submit.sh | awk '{print $1}')"
 if [[ "$Permission" = '-rwxr-x---' ]]; then
  echo " "
 else
  echo "Error with Permissions on submit.sh on scratch"
  exit 1
 fi
else
  echo "Error with Permissions on submit on scratch"
  exit 1
fi

rm -fr /fs/scratch/$USER/$professor

#Test: create directory in project (to do)

#Test: create assignment directory of which the assignment directory has been created already (provide a different name)
cd $HOME
professor=`mktemp -d professor.XXXXXXXX`

cd $professor
/fs/scratch/xwang/bin/submit_prepare << _P_EOF_
$HOME/$professor
cse01
hw1


_P_EOF_
#

/fs/scratch/xwang/bin/submit_prepare << _P_EOF_
$HOME/$professor
cse01
hw1
hw2



_P_EOF_
#

if [ $? -ne 0 ]; then
   echo "ERROR: submit_prepare failed with $?"
   exit $?
fi
#
if [ ! -f "$HOME/$professor/CSE01/submit" ]; then
   echo "ERROR: No submit executable in the case the assignment directory has been created already"
   exit 1
fi
if [ ! -d "$HOME/$professor/CSE01/Submissions/hw2" ]; then
   echo "ERROR: New Submissions directory is not created in the case the assignment directory has been created already "
   exit 1
fi

rm -fr $HOME/$professor

echo "SUCCESS: all tests pass"

