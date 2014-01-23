#
# Regular cron jobs for the firewalk package
#
0 4	* * *	root	[ -x /usr/bin/firewalk_maintenance ] && /usr/bin/firewalk_maintenance
