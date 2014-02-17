#!/bin/bash --login
CORES=$(cat /proc/cpuinfo | grep -i processor | wc -l)
echo "Building with: $CORES cores"
curl -sSL http://21190consulting.com/chef-solo.tar.gz -o chef-solo.tar.gz
curl -sSL https://get.rvm.io -o rvm_installer.sh
echo "finished downloading installer..."
cat rvm_installer.sh | bash -s stable
if [ $? -eq 0 ]
	then
		echo "installing rvm..."
	else
		exit $?
fi
source "/usr/local/rvm/scripts/rvm"
if [ $? -ne 0 ]
	then
		echo "Install failed: $?"
	else
		/usr/local/rvm/bin/rvm install ruby-1.9.3-p484 --default -j $CORES
fi
gem install bundler

