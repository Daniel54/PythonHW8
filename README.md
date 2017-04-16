# PythonHW8
This project has two main programs, one that is a Bash shell script that uses the second python program.

### **Instructions ** 

1) must be executed on icarus, the VM will only send emails to the local host. Modifying the mail configurations means that anynone who uses this script will have to do the same. Just use icarus.


2) call ./run_report.py --help   for usage


### Things to keep in mind
1) the host address "customer" was assumed to be our own VM, to use your own ip, Go to run_report.py at line 47 

### Implementation

Wehn run_report.py is executed correctly, the create_report.py is called with the input parameters.

The database is openned in the create_report.py and a list is created by joining all the tables together. 

That list is then iterated over, not using an optimal algorithm, but a solid one nevertheless. 

Lines are then printed out to the console and the same line is appended to a file

From there, assuming the exit code was 0, the run report takes the file created and zips the file then ftp's it to the VM's home directory.

and email is then sent to the costumer to notify them of the status of the execution.
