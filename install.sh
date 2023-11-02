#!/bin/bash

#RETURN 0-SUCESS  1-FAIL

SCRIPT_PATH=$(dirname $(readlink -e $0))

source $SCRIPT_PATH/lib/nmpackage_lib.sh
source $SCRIPT_PATH/lib/ninstall_lib.sh

check_root

source_lib_path-set $SCRIPT_PATH/lib
source_bin_path-set $SCRIPT_PATH
source_etc_path-set $SCRIPT_PATH
source_service_path-set $SCRIPT_PATH

#******************************* Custom functions ********************************

function install_depends
{
    echo "Installing the required packages..."
    app_install showmount nfs-common
    echo "Package installation is complete"
}

function install_app
{
    copy_bin nlogs.sh 755
}

function install_service
{
    copy_service nlogs.service 644
    if [ $? == 0 ]; then
        sed -i -E "s/(  User=.*)/  User=$USER/g" $SERVICE_PATH/nlogs.service
        sed -i -E "s/(  Group=.*)/  Group=$GROUP/g" $SERVICE_PATH/nlogs.service
    fi
}

function main
{
    user_read

    install_depends
    install_app
    install_service
}

main

exit 0