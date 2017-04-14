#!/bin/bash

#THIS PROGRAM CONTAINS ONLY EMAIL RELATED SCRIPTS
#ALL CODE NEEDS TO BE MANUALLY INTEGRATED WITH THE MAIN SCRIPT 

#This code relies on having sendmail installed. 
#sudo apt-get install sendmail

./test.py #This needs to be changed to './create_report.py <args>' 
ExitCode=$?	#grabs the exit code of the last run script
Header="Error"
Body="Error"

if [ $ExitCode = 0 ]
	then
	zip report *.dat
	
	#Need to add in code to FTP the zip file to a server

	Header="Succesfully transfer file (FTP Address)" 
	#don't forget to make it actually put the server name in

	Body="Succesfully created a transaction report from (BegDate) to (EndDate)"
	#don't forget to make it actually put in the beg/end


elif [ $ExitCode = 255 ] #A returned -1 is seen as 255
	then
	Header="The create_report program exit with code -1"
	Body="Bad input parameters (BegDate) (EndDate)"
	#don't forget to make it acutally put in the beg/end date

elif [ $ExitCode = 254 ] #A returned -2 is seen as 254
	then
	Header="The create_report program exit with code -2"
	Body="No transactions available from (BegDate) to (EndDate)"
	#don't forget to make it acutally put in the beg/end date

else
	echo "Check the exit codes of create_report.py"
fi

touch email.txt
echo "Subject: $Header" >> email.txt
echo "$Body" >> email.txt

sendmail chrislangan@mail.weber.edu < ./email.txt #Used my email for testing purposes. Replace it
rm email.txt

exit 0