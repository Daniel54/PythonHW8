#!/bin/bash

#THIS PROGRAM CONTAINS ONLY EMAIL RELATED SCRIPTS
#ALL CODE NEEDS TO BE MANUALLY INTEGRATED WITH THE MAIN SCRIPT 

./test.py #This needs to be changed to './create_report.py <args>' 
ExitCode=$?	#grabs the exit code of the last run script

if [ $ExitCode = 0 ]
	then
	echo "Exit code 0 returned"
elif [ $ExitCode = 255 ] #A returned -1 is seen as 255
	then
	echo "Exit code -1 returned"
elif [ $ExitCode = 254 ] #A returned -2 is seen as 254
	then
	echo "Exit code -2 returned"
else
	echo "Check the exit codes of create_report.py"
fi

exit 0