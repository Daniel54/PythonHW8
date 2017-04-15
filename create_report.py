#!/usr/bin/env python3

"""
Creates the the output and prints it on the screen,
It can be redirected with the > operator to write it
to a file
"""

import sys
import sqlite3



def create(beg_date,end_date):
    """
    Creates the output using the begin and end dates as the range
    Args:
        beg_date
        end_date
    Return:
        None
    """

    if validate(beg_date) and validate(end_date):
        Bdate = beg_date[:4]+'-'+beg_date[4:6]+'-'+beg_date[6:]+' 00:00:00'
        Edate = end_date[:4]+'-'+end_date[4:6]+'-'+end_date[6:]+' 23:59:59'


        conn = sqlite3.connect('hw8SQLite.db')
        if conn:
            print("Getting transaction from "+Bdate+" to "+Edate)
            print("connected to the db")
        cur = conn.cursor()
        theSQL = conn.execute("SELECT t.trans_id, trans_date, card_num \
                               , qty, amt, prod_desc, total FROM trans t\
                               LEFT JOIN \
                               trans_line tl ON t.trans_id = tl.trans_id\
                               LEFT JOIN products p ON tl.prod_num =\
                               p.prod_num WHERE trans_date \
                               BETWEEN'"+Bdate+"' AND '"+Edate+"'")
        count = 0
        wString = '1'
        fileName = 'company_trans'+beg_date+'_'+end_date+'.dat'
        f = open(fileName,'w')
        print("Created file:",fileName)
        theData = list(theSQL)
        IDs = { x[0] for x in theData }

        for i in theData:

            if count == i[0]:

                if i[3] != None:
                    wString += '{:02}'.format(int(i[3]))
                else:
                    wString += '      00'
                if i[4] != None:
                    wString += '{:07.2f}'.format(i[4]).replace(".","")
                else:
                    wString += '{:>5d}'.format(0)
                if i[5] != None:
                    wString += '{:<10}'.format(i[5])


                count = i[0]
            #New transaction
            elif count <  i[0]:

                count = i[0]
                wString = '{:05}'.format(i[0])
                wString += i[1][:15].replace("-","").\
                    replace(" ","").replace(":","")
                wString += i[2][7:]
                if i[3] != None:
                    wString += '{:02}'.format(int(i[3]))
                else:
                    wString += '00'
                if i[4] != None:
                    wString += '{:07.2f}'.format(i[4]).replace(".","")
                else:
                    wString += '{:<6}'.format('000000')
                if i[5] != None:
                    wString += '{:<10}'.format(i[5])
                else:
                    wString += '{:<10}'.format('')


            if ((theData.index(i)+1) < len(theData) and \
                    (theData[theData.index(i)+1][0]) > \
                    theData[theData.index(i)][0]) or\
                    theData[theData.index(i)][0] == len(IDs):

                while len(wString) < 77:
                    wString += '{:<18}'.format('00000000')
                if i[-1] != None:
                    wString += '{:07.2f}'.format(i[-1]).replace('.','')
                print(wString)
                f.write(wString+'\n')
        f.close()



        if len(theData) == 0:
            exit(-2)

    else:
        exit(-1)






def validate(date_input):
    """
    Validates a date using the required criteria (length 8, all digits)
    days and months must be within the realistic range to return true
    Args:
        date_input => the input to be validated
    Return:
            True if the input is valid, False otherwise
    """

    if len(date_input) == 8 and date_input.isdigit():
        monthTest = ['{:02}'.format(x) for x in range(1,13)]
        DaysTest = ['{:02}'.format(x) for x in range(1,32)]
        if date_input[4:6] in monthTest and date_input[6:] in DaysTest:
            return True
        else:
            print("(Invalid) Date was unrealistic:",date_input)
    return False



def help():
    """
    Guide on how to use this script
    """
    print("Help:")
    print("./create_report <BEGINDATE> <ENDDATE>")
    print("both dates must be 8 digits long, and within valid range")



def main():
    """
    Main funcion
    """
    #test case
    if len(sys.argv) == 3:
        create(sys.argv[1],sys.argv[2])
    else:
        help()



if __name__== "__main__":
    main()
    exit(0)


#exit(0)

