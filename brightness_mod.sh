#!/bin/bash

basedir="/sys/class/backlight/"
handler=$basedir$(ls $basedir | grep -v 'acpi')"/"

sudo chmod 666 $handler"brightness"
