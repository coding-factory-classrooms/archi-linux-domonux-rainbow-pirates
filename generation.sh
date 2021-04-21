#!/bin/bash
# $1: time in miliseconds between each info sent by the script
gcc genTick.c -o genTick;
./genTick $1 | python3 genSensorData.py
