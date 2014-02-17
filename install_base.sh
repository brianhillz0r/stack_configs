#!/bin/sh

curl -sSL https://get.rvm.io -o rvm_installer.sh
chmod +x rvm_installer.sh
./rvm_installer.sh -- --version ruby-1.9.3p394
