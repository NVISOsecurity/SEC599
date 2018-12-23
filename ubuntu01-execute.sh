#!/bin/bash
# SANS SEC599 Hot Fix Script
# Only to be used for quick fixes
# Author: Erik Van Buggenhout (evanbuggenhout@nviso.be)
# Last revision: 23 December 2018

ifconfig eth0 10.10.10.80
service networking restart
