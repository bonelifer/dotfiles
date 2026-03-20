#!/bin/bash

mpstat 2 1 | awk '/^Average/ {print $3}'

