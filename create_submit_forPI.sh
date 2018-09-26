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

if [[ ! -d /fs/scratch/xwang/bin ]]; then
 mkdir /fs/scratch/xwang/bin
fi

chmod -R 755 /fs/scratch/xwang/bin
cd /fs/scratch/xwang/osc-hw-submission
gcc -o submit_prepare homework_submission.C
mv submit_prepare /fs/scratch/xwang/bin
cp submit.C /fs/scratch/xwang/bin
chmod 755 /fs/scratch/xwang/bin/submit_prepare
chmod 644 /fs/scratch/xwang/bin/submit.C

