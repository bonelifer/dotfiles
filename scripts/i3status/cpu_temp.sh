#!/bin/bash

sensors | grep 'CPU:' | awk '{print $2}' | head -n 1


