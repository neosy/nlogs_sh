#!/bin/bash
# Version 0.2
    # Change "cp -Rpu ...." on "cp -Ru ...."
# Version 0.1

FREQ=2m # frequency in sec

LOG_PATH="/home/neosy/log"
LOG_SERVER_PATH="/media/logs/ncLogs"

PARM_1=$1

function logs_copy
{
    mount_fs=`df ${LOG_SERVER_PATH}/ -TP | tail -n -1 | awk '{print $2}'`

    if [[ ${mount_fs} == "nfs"* ]]; then
        cp -Ru ${LOG_PATH}/* ${LOG_SERVER_PATH}
    fi
}

function main
{
    local daemon=false

    if [[ $PARM_1 == "-d" ]]; then
        daemon=true
    fi

    if [[ $daemon = true ]]; then
        while :
        do
            logs_copy

            sleep $FREQ
        done
    else
        logs_copy
    fi
}

main

exit 0
