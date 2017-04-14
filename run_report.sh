#!/bin/bash

#pars user option
#using a loop to pick up flags like -a or -w (flaps)
#loop and when when it finds a certain flag then it stores that

usage(){
	echo "Invalid options"
	echo "Usage ./$0 -f <BegDate> -t <EndDate> -e<Email> -u <User> -p<Pass>"
	exit 1
}

#check for help arg

if [[ $1 == "--help" ]]
then
	usage
fi

#Make a funciton that that uses BegDate and EndDate 
#passes it to python script

while getopts ":f:t:e:u:p:" opt #once it finds it, it is stored in opt
do 
	case $opt in 
		f) BegDate=$OPTARG 
        	;;
		t) EndDate=$OPTARG
			;;
		e) email=$OPTARG
			;;
		u) user=$OPTARG
			;;
		p) passwd=$OPTARG
			;;
		\?)#anything else is invalid option
			usage
			;;
	esac

done

echo "Testing: [$BegDate] [$EndDate] [$email] [$user] [$passwd]"
./test.py >> test4.dat #running py script
################ENTER vm ip in var host####################################
code=$?              #Capturing exit code from create_report.py
host="137.190.19.97" #Capturing host variable will need to change.
curDir=$PWD			 #Captur present working dir
log=./ftplog.log     #ftp log file to check
outFile="hw8Out"     #creating out file var






if [[ $code == 0 ]]
then
    #############################################################
    # zip portion
	fileName=`find . -name '*.dat'` #getting file name
	zipCall=`zip -v $outFile $fileName`

	#Checking zip
	if [[ $? -eq 1 ]]
	then
    	echo "zip failed"
    	exit 1
	else
    	echo "good zip"
	fi
	#############################################################
	#Ftp portion:

	ftpFile=`find . -name '*.zip'`
	
	echo "Connecting to $user"
    ftp -nv $host <<END_SCRIPT >$log
	quote USER $user
	quote PASS $passwd
	put $ftpFile
	quit
END_SCRIPT
	############################################################
	#chekcing ftp
	
	echo "Disconnecting from $user"
	echo "Emailing report to $email"

	grep "226 Transfer complete" $log
	if [[ $? == "1" ]]
	then
		echo "ftp failed"
		exit 1
	else
		echo "ftp is complete"
	fi
elif [[ $code == 254 ]] #exit(-2)
then
	echo "Empty transaction: Send email"
elif [[ $code == 255 ]] #exit(-1)
then 
	echo "Invalid input parameters."

fi

exit 0
