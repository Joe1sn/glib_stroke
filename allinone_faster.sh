#!/bin/bash
echo -e "\e[32m[!]Using glibc-all-in-one method\e[0m"
echo -e "\e[33m[!]The project repostory is https://github.com/matrix1001/glibc-all-in-one \e[0m"
./download_old 2.29-0ubuntu2_amd64
cd ./libs/2.29-0ubuntu2_amd64
sudo ln -sf ./libm-2.29.so /lib/x86_64-linux-gnu/libm.so.6