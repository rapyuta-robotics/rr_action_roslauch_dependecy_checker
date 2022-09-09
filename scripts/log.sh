#!/bin/bash

RED='\033[0;31m'
GRN='\033[1;32m'
CYN='\033[1;36m'
NCL='\033[0m'

fatal() {
    echo -e "${RED}${1}$NCL"
}

info() {
    echo -e "${CYN}${1}$NCL"
}

success() {
    echo -e "${GRN}${1}$NCL"
}
