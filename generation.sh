#!/bin/bash
gcc genTick.c -o genTick;
./genTick $1 | python3 genSensorData.py
