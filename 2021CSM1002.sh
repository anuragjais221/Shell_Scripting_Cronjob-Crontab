#!/bin/sh
# * * * * * /usr/bin/sh /home/anurag/Documents/cs509Assignment05/2021CSM1002.sh
# 2021CSM1002 Anurag Jaiswal

if test ! -f /home/anurag/Documents/cs509Assignment05/count.txt; #check count.txt file exist for counter purpose
then echo 1 > /home/anurag/Documents/cs509Assignment05/count.txt # if count.txt file does not exist then create count.txt and write 1 into it
else
    read counter < /home/anurag/Documents/cs509Assignment05/count.txt # read counter from count.txt file
    echo $counter # echo counter
    if test $counter -eq 1 # compare counter with 1
    then
        # echo "Inside counter 1"
        ps aux --sort +rss | tail -5 > /home/anurag/Documents/cs509Assignment05/file1.txt # write five processes of high memory consumtion in file 1
        echo $(((counter+1)%4)) > /home/anurag/Documents/cs509Assignment05/count.txt # update the counter in count.txt
    elif test $counter -eq 2 # compare counter with 2
    then
        # echo "Inside counter 2"
        ps aux --sort +rss | tail -5 > /home/anurag/Documents/cs509Assignment05/file2.txt  # write five processes of high memory consumtion in file 2
        echo $(((counter+1)%4)) > /home/anurag/Documents/cs509Assignment05/count.txt # update the counter in count.txt
    elif test $counter -eq 3 # comapre counter with 3
    then
        # echo "Inside counter 3"
        ps aux --sort +rss | tail -5 > /home/anurag/Documents/cs509Assignment05/file3.txt  # write five processes of high memory consumtion in file 3
        echo $(((counter+1)%4)) > /home/anurag/Documents/cs509Assignment05/count.txt # update the counter in count.txt
    else
        # echo "Inside counter 0"
        # echo "find max"
        # 4th minute
        if test ! -f /home/anurag/Documents/cs509Assignment05/memory_log.txt; # check memory_log file exist or not
        then echo "Current Timestamp            Process Name            Process Id        Memory Usage" > /home/anurag/Documents/cs509Assignment05/memory_log.txt # if memory_log.txt file does not exist then create memory_log.txt and add heading columns
        fi
        echo $(((counter+1)%4)) > /home/anurag/Documents/cs509Assignment05/count.txt # update the counter in count.txt for next minute
        tag1=$( tail -n 1 /home/anurag/Documents/cs509Assignment05/file1.txt ) # fetching the last row in file1.txt
        m1=$( echo $tag1 | cut -d " " -f4) # fetch memory consumtion ( 4th column value )
        tag2=$( tail -n 1 /home/anurag/Documents/cs509Assignment05/file2.txt ) # fetching the last row in file2.txt
        m2=$( echo $tag2 | cut -d " " -f4) # fetch memory consumtion ( 4th column value )
        tag3=$( tail -n 1 /home/anurag/Documents/cs509Assignment05/file3.txt )  # fetching the last row in file2.txt
        m3=$( echo $tag3 | cut -d " " -f4) # fetch memory consumtion ( 4th column value )
        # echo "m1 = " $m1
        # echo "m2 = " $m2
        # echo "m3 = " $m3
        # echo $(date +%T)
        # find max between the last row of memory consumtion of file1 file2 and file3
        if test $m1 -gt $m2  && test $m1 -gt $m3
        then
            c2=$(echo $tag1 | cut -d " " -f11) # fetching process name and store in c2
            # echo "c2 = " $c2
            c3=$(echo $tag1 | cut -d " " -f2) # fetching process id and store in c3
            echo $(date +"%m-%d-%Y") $(date +%T) "      "$c2 "    " $c3 "    " $m3 >> /home/anurag/Documents/cs509Assignment05/memory_log.txt
        elif [ $m2 -gt $num1 ] && [ $m2 -gt $m3 ]
        then
            c2=$(echo $tag2 | cut -d " " -f11)  # fetching process name and store in c2
            # echo "c2 = " $c2
            c3=$(echo $tag2 | cut -d " " -f2) # fetching process id and store in c3
            echo $(date +"%m-%d-%Y") $(date +%T) "      " $c2 "    "  $c3 "    "  $m3 >> /home/anurag/Documents/cs509Assignment05/memory_log.txt
            # echo $tag2 >> /home/anurag/Documents/cs509Assignment05/memory_log.txt
        else
            c2=$(echo $tag3 | cut -d " " -f11)  # fetching process name and store in c2
            # echo "c2 = " $c2
            c3=$(echo $tag3 | cut -d " " -f2) # fetching process id and store in c3
            echo $(date +"%m-%d-%Y") $(date +%T) "      " $c2 "    "  $c3 "    "  $m3 >> /home/anurag/Documents/cs509Assignment05/memory_log.txt
            # echo $tag3  >> /home/anurag/Documents/cs509Assignment05/memory_log.txt
        fi
    fi
fi
echo "Ending script"

