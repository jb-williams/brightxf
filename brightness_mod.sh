#!/bin/bash

basedir="/sys/class/backlight/"
handler=$basedir$(ls $basedir)"/"

sudo chmod 666 $handler"brightness"
