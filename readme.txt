PG Lab Assignment 05
Shell Scripting
#2021CSM1002

##########################################################################
Implementation of creating memory log file which contains the highest memory consumption process in last three minutes

2021CSM1002.sh script basically took the last line of each file and print the max of
them in memory log file.
2021CSM1002_2.sh script basically merge the content of all three files into a temp file and checking the duplicate row values based on column no two and adding
content of the column no four for the same duplicate rows and store them into a another file. After that temp2 file is sorted and fetch the last row.



Go the home directory type sudo -u anurag crontab -e // it will open the nano editor and print the command for scheduling the cronj job mention in the second line of script
Step 1: First copy the second line of the file and schedule the
cron job in the cron tab.

Step 2: Then the after first minute File1 will be created and
after second minute file2 will be created and in the third minute
file3 will be created. At last in the fourth minute memory_log.txt
file will be created and this will continue.

Step 3: In the memory log file we can see the current time
value , then process name , process id and total memory consumed
in last three minutes.

##########################################################################
