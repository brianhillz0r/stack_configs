#!/bin/sh
if [ "$1" == "--help" ]
	then
		echo "./run.sh chef-config.rb roles/chef-role.rb [loglevel]"
		exit 0
fi
echo "checking which chef..."
CHEF=$(which chef-solo)
_RET=$?
echo "checking return code"
if [ $_RET -ne 0 ]
	then
		exit $?
fi
echo "checking variables passed..."

CHEF_CONFIG="$1"
CHEF_ROLE=$2
DEBUG=$3

echo "$PWD/$CHEF_CONFIG"

echo "checking chef config..."
if [ ! -f $CHEF_CONFIG ]
	then
		CHEF_CONFIG="$PWD/config.rb"
		echo "setting.."
fi
echo "$CHEF_CONFIG"
echo "checking chef role..."
if [ -z $CHEF_ROLE ]
	then
		CHEF_ROLE="$PWD/roles/minimal.json"
fi
echo "$CHEF_ROLE"
echo "checking debug..."
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

echo $LOG_LEVEL

if [ -x $CHEF ]
	then
		$CHEF -c $CHEF_CONFIG -j $CHEF_ROLE $LOG_LEVEL
	else
		exit $?
fi
