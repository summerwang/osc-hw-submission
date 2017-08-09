#!/bin/bash

#path=`pwd`
#newline=system\(\"$path/homework_submission.sh\"\)\;
#sed -i "/system/c $newline" homework_submission.C

if [[ -f /fs/scratch/xwang/bin/submit_prepare ]]; then
 rm /fs/scratch/xwang/bin/submit_prepare
fi

if [[ -f /fs/scratch/xwang/bin/submit.C ]]; then
 rm /fs/scratch/xwang/bin/submit.C
fi

cd /fs/scratch/xwang/submit_hw
gcc -o submit_prepare homework_submission.C
mv submit_prepare /fs/scratch/xwang/bin
cp submit.C /fs/scratch/xwang/bin

