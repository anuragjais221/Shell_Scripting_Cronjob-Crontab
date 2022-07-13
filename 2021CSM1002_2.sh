#!/bin/sh
# * * * * * /usr/bin/sh /home/anurag/Documents/cs509Assignment05/2021CSM1002_2.sh
# 2021CSM1002 Anurag Jaiswal

if test ! -f /home/anurag/Documents/cs509Assignment05/count.txt; #check count.txt file exist for counter purpose
then echo 0 > /home/anurag/Documents/cs509Assignment05/count.txt # if count.txt file does not exist then create count.txt and write 1 into it
else
    read counter < /home/anurag/Documents/cs509Assignment05/count.txt # read counter from count.txt file
    echo $counter # echo counter
    if test $counter -eq 1 # compare counter with 1
    then
        # echo "Inside counter 1"
        ps aux --sort +rss | tail -5 > /home/anurag/Documents/cs509Assignment05/file1.txt # write five processes of high memory consumtion in file 1
        echo $(((counter+1)%4)) > /home/anurag/Documents/cs509Assignment05/count.txt # update the counter in count.txt
    elif test $counter -eq 2
    then
        # echo "Inside counter 2"
        ps aux --sort +rss | tail -5 > /home/anurag/Documents/cs509Assignment05/file2.txt # write five processes of high memory consumtion in file 2
        echo $(((counter+1)%4)) > /home/anurag/Documents/cs509Assignment05/count.txt # update the counter in count.txt
    elif test $counter -eq 3
    then
        # echo "Inside counter 3"
        ps aux --sort +rss | tail -5 > /home/anurag/Documents/cs509Assignment05/file3.txt # write five processes of high memory consumtion in file 3
        echo $(((counter+1)%4)) > /home/anurag/Documents/cs509Assignment05/count.txt # update the counter in count.txt
    else
        # echo "Inside counter 0"
        # echo "find max"
        if test ! -f /home/anurag/Documents/cs509Assignment05/memory_log.txt;
        then echo "Current Timestamp            Process Name       Process Id       Memory Usage" > /home/anurag/Documents/cs509Assignment05/memory_log.txt # if memory_log.txt file does not exist then create memory_log.txt and add heading columns
        fi
        echo $(((counter+1)%4)) > /home/anurag/Documents/cs509Assignment05/count.txt # update the counter in count.txt for next minute

        # combining file1,file2 and file3 in temp file
        cat /home/anurag/Documents/cs509Assignment05/file1.txt /home/anurag/Documents/cs509Assignment05/file2.txt /home/anurag/Documents/cs509Assignment05/file3.txt > /home/anurag/Documents/cs509Assignment05/temp.txt

        # doing cummulative addition of processes which are common in accross the files and store process id and memoru consumtion
        awk '{a[$2]+=$4}END{for(i in a){print i, a[i]}}' /home/anurag/Documents/cs509Assignment05/temp.txt > /home/anurag/Documents/cs509Assignment05/temp2.txt
        sort -k 2 temp2.txt # sort the temp2 on the basis of second column ( total memoy consumtion column )
        tag=$(tail -n 1 /home/anurag/Documents/cs509Assignment05/temp2.txt ) # fetching last row of temp2 file
        process_id=$( echo $tag | cut -d " " -f1) # fetch first column of last row process_id
        tot_mem_consumtion=$( echo $tag | cut -d " " -f2) # fetch second column of last row total memory consumtion
        while IFS= read -r line; do # read the temp file line by line
            # echo "Text read from file: $line"
            pid=$( echo $line | cut -d " " -f2) # fetch processId from current line
            # echo "pid = " $pid
            if test $pid -eq $process_id # compare processId with maximum memory consumtion process id
            then
                process_name=$( echo $line | cut -d " " -f11) # fetching process name
                # echo "process name = " $process_name "process_id = " $pid
                # echo the current timestamp process name process id and total memory consumtion in memory log.txt file
                echo $(date +"%m-%d-%Y") $(date +%T) "      "$process_name "    " $process_id "    " $tot_mem_consumtion >> /home/anurag/Documents/cs509Assignment05/memory_log.txt
                break
            fi
        done < /home/anurag/Documents/cs509Assignment05/temp.txt
    fi
fi
echo "Ending script"

