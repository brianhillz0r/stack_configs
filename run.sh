#!/bin/sh
CHEF=$(which chef-solo)
_RET=$?
if [ $_RET -ne 0 ]
	then
		echo "Did you remember to install chef-solo?"
fi

CHEF_CONFIG=$1
CHEF_ROLE=$2
DEBUG=$3

if [ -z $CHEF_CONFIG ]
	then
		CHEF_CONFIG="$PWD/config.rb"
	else
		exit $?
fi

if [ -z $CHEF_ROLE ]
	then
		CHEF_ROLE="$PWD/roles/minimal.json"
	else
		exit $?
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
		exit $?
fi
