#!/bin/bash

log_file="/opt/var/log/raid_check.log"        # where to write a log
disks_in_raid=$(cat /proc/mdstat | grep md0)	# get mdstat status with numb of disks in the raid
#disks_in_raid="md0 : active raid1 sdb1[1]"   # just for check how it works :)
disks_in_raid_array=( $disks_in_raid )		    # split the string to an array

timestamp() {
  date +"%T"
}

if [ ${#disks_in_raid_array[@]} -lt 6 ]; then	# if the string has less than 6 arguments then there are not all disks in the raid
    if [ ${disks_in_raid_array[4]} = "sdb1[1]" ]; then
        if [ ! -b /dev/sda1 ]; then 
            timestamp  >> $log_file
            echo "reboot because there is no sda1 disk in the system" >> $log_file
            reboot
        else
            timestamp  >> $log_file
            echo "sda1 disk already in the system so add it back to the raid" >> $log_file
            mdadm --manage /dev/md0 --add /dev/sda1
        fi
    else
        if [ ! -b /dev/sdb1 ]; then 
            timestamp  >> $log_file
            echo "reboot because there is no sdb1 disk in the system" >> $log_file
            reboot
        else
            timestamp  >> $log_file
            echo "sdb1 disk already in the system so add it back to the raid" >> $log_file
            mdadm --manage /dev/md0 --add /dev/sdb1
        fi
    fi

else 						# we have all disks
    echo "all disks are in the raid md0, so exit"
fi
