#!/bin/bash

sensors | grep -e 'Tctl\|CPU:' | awk '{print $2}' | head -n 1
