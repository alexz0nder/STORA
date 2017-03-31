# STORA
This is my scripts for Netgear STORA MS2000

The first one is raid_check_and_restore.sh
it should check if one of the disks disappeared from the raid, reboot stora and then add it back to the raid.
Just put it to some folder in the system and add it to the crontab for check once a minute :)
* * * * * /sbin/raid_check_and_restore.sh
