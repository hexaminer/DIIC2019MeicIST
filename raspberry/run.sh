#!/bin/sh

if [ "$#" != "1" ]
then
	echo "Usage: $0 <ip>";
	exit;
fi

pidof pigpiod || sudo pigpiod;
./project.py $1;
