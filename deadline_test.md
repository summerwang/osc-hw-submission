# Account Preparation

Create three OSC user accounts with the following setups:
1. Two user accounts under the same group (the same classroom project account) but belong to different contact IDs with different email address. For example: `prof` as professor, `st` as student
2. The third user account belongs to different group of `prof` and `st`. For example: `other` as another user who should not have permission to submit homework to `prof`

# Test: at command

login as `prof` at 1:21PM August 10, 2017 on Owens
## Inputs:
1. [Enter]
2. cse01
3. hw1
4. [Enter]
5. [Enter]
6. at 1:30PM 8/10/2017
at> chmod 700 /users/PZS0701/osc1028/CSE01/Submissions/hw1

at> <EOT>

job 1 at Thu Aug 10 13:30:00 2017

## Test: before deadline 
login as `st` at 1:25PM August 10, 2017
### Inputs:
1. hw1
2. [Enter]

### Results seen by student:
Your assignment hw1 is submitted succesfully. Thank you!

### Results seen by professor:
drwx-wx--t 2 osc1028 PZS0701 4096 Aug 10 13:21 hw1

-bash-4.2$ cd hw1

-bash-4.2$ ll

total 8

drwxrwx--- 2 osc1029 PZS0701 4096 Aug 10 13:25 osc1029

-r-xr-x--- 1 osc1029 PZS0701   99 Aug 10 13:25 submit_log_osc1029.txt

## Test: deadline passed

login as `st` at 1:32PM August 10, 2017
### Inputs:
1. hw1
2. [Enter]

### Results seen by student:
You may pass the deadline and cant submit your assignment hw1. Please check with your professor

### Results seen by professor:
drwx------ 3 osc1028 PZS0701 4096 Aug 10 13:25 hw1

-bash-4.2$ cd hw1

-bash-4.2$ ll

total 8

drwxrwx--- 2 osc1029 PZS0701 4096 Aug 10 13:25 osc1029

-r-xr-x--- 1 osc1029 PZS0701   99 Aug 10 13:25 submit_log_osc1029.txt




