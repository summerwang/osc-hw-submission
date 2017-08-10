# Account Preparation

Create three OSC user accounts with the following setups:
1. Two user accounts under the same group (the same classroom project account) but belong to different contact IDs with different email address. For example: `prof` as professor, `st` as student
2. The third user account belongs to different group of `prof` and `st`. For example: `other` as another user who should not have permission to submit homework to `prof`

# Test: no email notification
## login as `prof`
### Inputs:
1. [Enter]
2. cse01
3. hw1
4. [Enter]
5. [Enter]
## login as `st`
### Inputs:
1. hw1
2 [Enter]
### Results:
email notification is sent to student only


# Test: no email notification
## login as `prof`
### Inputs:
1. [Enter]
2. cse01
3. hw1
4. [Enter]
5. n/not
## login as `st`
### Inputs:
1. hw1
2 [Enter]
### Results:
email notification is sent to student only


# Test: with email notification
## login as `prof`
### Inputs:
1. [Enter]
2. cse01
3. hw1
4. [Enter]
5. y
## login as `st`
### Inputs:
1. hw1
2 [Enter]
### Results:
email notification is sent to student and professor




