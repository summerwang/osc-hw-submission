# Account Preparation

Create three OSC user accounts with the following setups:
1. Two user accounts under the same group (the same classroom project account) but belong to different contact IDs with different email address. For example: `prof` as professor, `st` as student
2. The third user account belongs to different group of `prof` and `st`. For example: `other` as another user who should not have permission to submit homework to `prof` 

# Tests as `prof` (login as `prof`)
## Test1: basic functions
### Inputs: 
1. [Enter]
2. cse01
3. hw1
4. [Enter]
5. [Enter]
### Results:
1. `CSE01` is created with `drwx--xt`
2. `CSE01/Submissions` is created with `drwx--x--t`
3. `CSE01/submit` is created with `-rwxr-x---`
4. `CSE01/Submissions/hw1` is created with `drwx-wx--t`
5. `CSE01/Submissions/submit.sh` is created with `-rwxr-x---`

