# Account Preparation

Create three OSC user accounts with the following setups:
1. Two user accounts under the same group (the same classroom project account) but belong to different contact IDs with different email address. For example: `prof` as professor, `st` as student
2. The third user account belongs to different group of `prof` and `st`. For example: `other` as another user who should not have permission to submit homework to `prof`

# login as `prof`
## Inputs:
1. [Enter]
2. cse01
3. hw1
4. 2
5. [Enter]

# login as `st`
Prepare two directories: one is of size of 1MB, and the other is of size of 18MB

## Test: size is not beyond the limit
cd to the directory of which the size is 1MB
1. hw1
2. [Enter]

### Results seen by student:
Your assignment hw1 is submitted succesfully. Thank you!

## Test: size is over the limit
cd to the directory of which the size is 18MB
### Inputs:
1. hw1
2. [Enter]

### Results seen by student:
Size of your directory is over 2 MB. Please compress the files to be less than 2 MB and resubmit. Exit



