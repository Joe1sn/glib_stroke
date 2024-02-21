#!/bin/bash
if ! command -v wget &> /dev/null; then
    echo -e "\e[31m[!]Please install wget\e[0m"
    exit 1
fi

echo -e "\e[32m[*]\e[0mDowload libm-2.29.so"
wget https://raw.githubusercontent.com/username/glib_stroke/main/libm-2.29.so
echo -e "\e[32m[*]\e[0mCreate soft link"
sudo ln -sf ./libm-2.29.so /lib/x86_64-linux-gnu/libm.so.6