#!/bin/bash

basedir="/sys/class/backlight/"
handler=$basedir$(ls $basedir)"/"

sudo chmod 555 $handler"brightness"
