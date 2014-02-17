#!/bin/sh
CHEF=$(which chef-solo 2>/dev/null)
_RET=$?
if [ $_RET -ne 0 ]
	then
		echo "Did you remember to install chef-solo?"
		exit 1
fi

CHEF_CONFIG=$1
CHEF_ROLE=$2
DEBUG=$3

if [ -z $CHEF_CONFIG ]
	then
		CHEF_CONFIG="$PWD/config.rb"
	else
		echo "Chef config file not found in: $CHEF_CONFIG"
		exit 1
fi

if [ -z $CHEF_ROLE ]
	then
		CHEF_ROLE="$PWD/roles/minimal.json"
	else
		echo "Chef JSON attributes not found in: $CHEF_ROLE"
		exit 1
fi	

if [ -n $DEBUG ]
	then
		case "$DEBUG" in
			debug)
				LOG_LEVEL="-ldebug"
				;;
		
			info)
				LOG_LEVEL="-linfo"
				;;

			warn)
				LOG_LEVEL="-lwarn"
				;;

			error)
				LOG_LEVEL="-lerror"
				;;

			fatal)
				LOG_LEVEL="-lfatal"
				;;
			esac
	else
		LOG_LEVEL="-linfo"
fi			

if [ -x $CHEF ]
	then
		$CHEF -c $CHEF_CONFIG -j $CHEF_ROLE $LOG_LEVEL
	else
		echo "Chef exists, but isn't executable. Fix your Chef installation."
		exit 1
fi
