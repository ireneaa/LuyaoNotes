#!/bin/bash

function get_datetime()
{
    time=$(date "+%Y%m%d")
    echo $time
}

function backup_source()
{
    old_source=/etc/apt/sources.list
    time=$(get_datetime)
    backup_file=$old_source"_bak_"$time
    cp $old_source $backup_file
}

function change_aliyun_source()
{
    if grep -Eq "18.04" /etc/*-release; then
        cat ${PWD}/ubuntu18 > /etc/apt/sources.list
    elif grep -Eq "16.04" /etc/*-release; then
        cat ${PWD}/ubuntu18 > /etc/apt/sources.list
    fi
}

function main()
{
    backup_source
    change_aliyun_source
    apt-get update
    apt-get upgrade
    apt update
    apt upgrade
}

main
