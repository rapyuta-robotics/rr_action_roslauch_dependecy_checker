#!/bin/bash

RED='\033[0;31m'
GRN='\033[1;32m'
CYN='\033[1;36m'
NCL='\033[0m'

print_usage() {
    echo -e "${CYN}Usage: check-launch-deps.sh SETUP_FILE_PATH PATH_TO_VALIDATE [EXCLUDES]$NCL"
}

fatal() {
    echo -e "${RED}${1}$NCL"
}

info() {
    echo -e "${CYN}${1}$NCL"
}

success() {
    echo -e "${GRN}${1}$NCL"
}