# Account Preparation

Create three OSC user accounts with the following setups:
1. Two user accounts under the same group (the same classroom project account) but belong to different contact IDs with different email address. For example: `prof` as professor, `st` as student
2. The third user account belongs to different group of `prof` and `st`. For example: `other` as another user who should not have permission to submit homework to `prof` 

# Tests as `prof` (login as `prof`)
## Test: basic functions
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
## Test: create directory in home directory with specified path
### Inputs:
1. /users/PZS0701/osc1028
2. cse02
3. lab2
4. [Enter]
5. [Enter]
### Results:
1. `$HOME/CSE02` is created with `drwx--xt`
2. `$HOME/CSE02/Submissions` is created with `drwx--x--t`
3. `$HOME/CSE02/submit` is created with `-rwxr-x---`
4. `$HOME/CSE02/Submissions/lab2` is created with `drwx-wx--t`
5. `$HOME/CSE02/Submissions/submit.sh` is created with `-rwxr-x---`
## Test: create directory in /fs/scratch
### Inputs:
1. /fs/scratch/osc1028
2. cse01
3. hw1
4. [Enter]
5. [Enter]
### Results:
1. `/fs/scratch/osc1028/CSE01` is created with `drwx--xt`
2. `/fs/scratch/osc1028/CSE01/Submissions` is created with `drwx--x--t`
3. `/fs/scratch/osc1028/CSE01/submit` is created with `-rwxr-x---`
4. `/fs/scratch/osc1028/CSE01/Submissions/hw1` is created with `drwx-wx--t`
5. `/fs/scratch/osc1028/CSE01/Submissions/submit.sh` is created with `-rwxr-x---`
## Test: create directory in project (to do)
## Test: create directory where path does not exist
### Inputs:
1. new
### Results:
No directory is created. Return error message: new does not exist. Please enter a valid path. Exit
## Test: create directory under the directory with wrong permission
### Inputs:
1. /users/oscgen/xwang
2. cse01
3. hw1
4. [Enter]
5. [Enter]
### Results:
No directory is created. Return error message: /users/oscgen/xwang/CSE01/Submissions/hw1 is not created. Please check error message or contact oschelp@osc.edu for assistance. Exit
## Test: create assignment directory of which the assignment directory has been created already
### Test a: provide different assignment name
### Inputs:
1. [Enter]
2. cse01
3. hw1
### Results:
Message: This assignment submission directory exists. Please provide a different assignment name or delete the current directory.Enter "quit" if you want to quit

### Inputs:
3. hw2
4. [Enter]
5. [Enter]
### Results:
Message: submit.sh has been created before with the following options:
#The size limit of one assignment submitted by each student is 1000 MB

### Inputs:
6. [Enter]

### Results:
1. `CSE01` is created with `drwx--xt`
2. `CSE01/Submissions` is created with `drwx--x--t`
3. `CSE01/submit` is created with `-rwxr-x---`
4. `CSE01/Submissions/hw2` is created with `drwx-wx--t`
5. `CSE01/Submissions/submit.sh` is created with `-rwxr-x---`

### Test b: quit
### Inputs:
1. [Enter]
2. cse01
3. hw1
### Results:
Message: This assignment submission directory exists. Please provide a different assignment name or delete the current directory.Enter "quit" if you want to quit

### Inputs:
3. quit

### Results:
No new directory is created. The program quits

## Test: no course number is provided
### Inputs:
1. [Enter]
2. [Enter]
### Results:
No new directory is created. The program quits with the message: Course number is empty. Exit

## Test: no assignment name is provided
### Inputs:
1. [Enter]
2. cse01
3. [Enter]
###
### Results:
No new directory is created. The program quits with the message: Assignment name is empty. Exit


