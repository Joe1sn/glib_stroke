#!/bin/bash
if ! command -v wget &> /dev/null; then
    echo -e "\e[31m[!]Please install wget\e[0m"
    exit 1
fi

echo -e "\e[32m[*]\e[0mDowload libm-2.29.so"
wget https://joe1sn.top/libm-2.29.so
sudo ln -sf ./libm-2.29.so /lib/x86_64-linux-gnu/libm.so.6