#!/bin/bash

#THIS PROGRAM CONTAINS ONLY EMAIL RELATED SCRIPTS
#ALL CODE NEEDS TO BE MANUALLY INTEGRATED WITH THE MAIN SCRIPT 

#This code relies on having sendmail installed. 
#sudo apt-get install sendmail

./create_report.py $1 $2
EXITCODE=$?	#grabs the exit code of the last run script
HEADER="Error"
BODY="Error"

if [ $EXITCODE = 0 ]
	then
	zip report *.dat
	
	#Need to finish the code to FTP the zip file to a server
	#HOST=
	#ftp -inv $HOST << EOF
	#user $user $passwd
	#cd /	#where do we actually put the file?
	#put report.zip
	#bye
	#EOF


	HEADER="Succesfully transfer file (FTP Address)" 
	#don't forget to make it actually put the server name in

	BODY="Succesfully created a transaction report from $1 to $2"
	


elif [ $EXITCODE = 255 ] #A returned -1 is seen as 255
	then
	HEADER="The create_report program exit with code -1"
	BODY="Bad input parameters $1 $2"
	#don't forget to make it acutally put in the beg/end date

elif [ $EXITCODE = 254 ] #A returned -2 is seen as 254
	then
	HEADER="The create_report program exit with code -2"
	BODY="No transactions available from $1 to $2"
	#don't forget to make it acutally put in the beg/end date

else
	echo "Check the exit codes of create_report.py"
fi


echo "Subject: $HEADER" >> email.txt
echo "$BODY" >> email.txt

echo "Sending email, please wait..."
sendmail chrislangan@mail.weber.edu < ./email.txt #Used my email for testing purposes. Replace it
rm email.txt
echo "Email sent"

exit 0
