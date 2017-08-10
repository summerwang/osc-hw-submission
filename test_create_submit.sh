#!/bin/bash

professor=`mktemp -d professor.XXXXXXXX`
student=`mktemp -d student.XXXXXXXX`

mkdir $student/HW1
touch $student/HW1/file1.txt
#
/fs/scratch/xwang/bin/submit_prepare << _P_EOF_
$PWD/$professor
cse01
lab1
1
n
_P_EOF_
#
if [ $? -ne 0 ]; then
   echo "ERROR: submit_prepare failed with $?"
   exit $?
fi
#
if [ ! -f "$professor/CSE01/submit" ]; then
   echo "ERROR: No submit executable"
   exit 1
fi
if [ ! -d "$professor/CSE01/Submissions/lab1" ]; then
   echo "ERROR: No Submissions directory"
   exit 1
fi
#
$professor/CSE01/submit << _S_EOF_
lab1
$PWD/$student/HW1
_S_EOF_
#
if [ $? -ne 0 ]; then
   echo "ERROR: submit failed with $?"
   exit 1
fi
#
if [ ! -f "$professor/CSE01/Submissions/lab1/$USER/file1.txt" ]; then
   echo "ERROR: Submission not copied"
   exit 1
fi
#
rm -fr $professor
rm -fr $student
echo "SUCCESS: all tests pass"

