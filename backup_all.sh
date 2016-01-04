#!/bin/bash
# Dante
# File Backup Entire File Structure


#############BEGIN EDIT AREA######################
# BELOW ARE SOME REQUIRED SETTINGS. CONFIGURE THEM PROPERLY BEFORE USING
# THE SCRIPT

# Path of the folder where backups will be stored. $HOME/html will
# automatically put you in the hosting accounts root folder. GoDaddy MySQL 
# databases are normally stored in the _db_backups folder within your base 
# hosting folder. If the folder does not exist create it before running the 
# script. You can also create a subfolder within _db_backups folder if you 
# would like to backup the database to a separate folder. Alternatively, 
# you can backup to an entirely different folder of your choice. Whatever 
# you choose to do, ensure that the path is correctly specified below. 
BACKUPFOLDER="$HOME/cron/backups/all"

# Should the script delete older files based on the conditions you set 
# below (Y or N - uppercase letters only). Choosing Y will maintain only
# recent backups based on your settings below. Choosing N will keep all
# the backups from the past. 
DELETEFILES="Y"

# Do daily backups Y or N? (one uppercase letter only)
DAILYBACKUP="N"

# Number of recent daily backups to keep. The default is 6 (Sun-Fri) with 
# Weekly backup on Sat.All previous backups will be deleted. This is 
# meaningless unless DAILYBACKUP is set to Y.
NUMDAILYBACKUPS="0"

# Do weekly backups Y or N? (one uppercase letter only). Weekly backups
# are done on Saturdays.
WEEKLYBACKUP="N"

# Number of recent weekly backups to keep. The default is 4. All previous 
# weekly backups will be deleted. This is meaningless unless WEEKLYBACKUP 
# is set to Y.
NUMWEEKLYBACKUPS="0"

# Do monthly backups Y or N? (one uppercase letter only). Monthly backups
# are done on the last day of the month.
MONTHLYBACKUP="Y"

# Number of recent monthly backups to keep. The default is 2. All previous 
# monthly backups will be deleted. This is meaningless unless 
# MONTHLYBACKUP is set to Y.
NUMMONTHLYBACKUPS="1"

#############END EDIT AREA######################
#
# DO NOT EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING. 
# WHILE YOU CAN EDIT IT TO CUSTOMIZE HOW THE SCRIPT WORKS, DOING SO CAN 
# BREAK THE FUNCTIONING OF THIS SCRIPT. 
#

TODATE=$(date +%d)
TOMORROW=`date +%d -d "1 day"`
TODAY=$(date +%a)
MONTH=$(date +%B)
WEEK=$(date +%U)

if [ $TODATE -gt $TOMORROW ] && [ "$MONTHLYBACKUP" == "Y" ]
then
zip -r9 $BACKUPFOLDER/'ALL_'`date '+%m-%d-%Y'`'_'$MONTH.zip /*
else
if [ "$TODAY" == "Sat" ] && [ "$WEEKLYBACKUP" == "Y" ]
then
zip -r9 $BACKUPFOLDER/'ALL_'`date '+%m-%d-%Y'`'_'$MONTH.zip /*
else 
if [ "$DAILYBACKUP" == "Y" ] 
then
zip -r9 $BACKUPFOLDER/'ALL_'`date '+%m-%d-%Y'`'_'$MONTH.zip /*
fi
fi
fi


if [ "$DELETEFILES" == "Y" ]
then
NUMWEEKLY=$[$NUMWEEKLYBACKUPS*7]
NUMMONTHLY=$[$NUMMONTHLYBACKUPS*31]
find $BACKUPFOLDER/*Sun.sql.gz -type f -mtime +$NUMDAILYBACKUPS -delete 2> /dev/null
find $BACKUPFOLDER/*Mon.sql.gz -type f -mtime +$NUMDAILYBACKUPS -delete 2> /dev/null
find $BACKUPFOLDER/*Tue.sql.gz -type f -mtime +$NUMDAILYBACKUPS -delete 2> /dev/null
find $BACKUPFOLDER/*Wed.sql.gz -type f -mtime +$NUMDAILYBACKUPS -delete 2> /dev/null
find $BACKUPFOLDER/*Thu.sql.gz -type f -mtime +$NUMDAILYBACKUPS -delete 2> /dev/null
find $BACKUPFOLDER/*Fri.sql.gz -type f -mtime +$NUMDAILYBACKUPS -delete 2> /dev/null
find $BACKUPFOLDER/*Sat.sql.gz -type f -mtime +$NUMDAILYBACKUPS -delete 2> /dev/null
find $BACKUPFOLDER/*Week*.sql.gz -type f -mtime +$NUMWEEKLY -delete 2> /dev/null
find $BACKUPFOLDER/*January.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*February.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*March.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*April.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*May.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*June.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*July.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*August.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*September.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*October.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*November.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
find $BACKUPFOLDER/*December.sql.gz -type f -mtime +$NUMMONTHLY -delete 2> /dev/null
fi
