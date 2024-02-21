#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
    echo -e "\e[31m[!]Need root access\e[0m"
    echo -e "\e[32m[+]\e[0mTry running in root"
    sudo "$0" "$@"
    exit $?
fi

echo -e "\e[32m[*]\e[0mNow running in root"

cd /usr/local
if ! command -v wget &> /dev/null; then
    echo -e "\e[31m[!]Please install wget\e[0m"
    exit 1
fi

file="glibc-2.29.tar.gz"

if [ -e "$file" ]; then
    echo -e "\e[33m[!]\e[0mFile $file already exists"
    echo -e "\e[32m[+]\e[0mOverwirte it? (y/n): "
    read  choice
    if [[ $choice == [Yy] ]]; then
        echo -e "\e[32m[*]\e[0mOverwirte file $file"
        echo -e "\e[32m[*]\e[0mDowload glibc-2.29"
        wget http://ftp.gnu.org/gnu/glibc/glibc-2.29.tar.gz
    else
        echo -e "\e[32m[*]\e[0mCanceled Downloading"
    fi
else
    echo -e "\e[32m[*]\e[0mDowload glibc-2.29"
    wget http://ftp.gnu.org/gnu/glibc/glibc-2.29.tar.gz
fi

extract_to="glibc-2.29"
archive_file=$file

if [ -d "$extract_to" ]; then
    echo -e "\e[33m[!]\e[0mFolder $extract_to already exists"
    echo -e "\e[32m[+]\e[0mOverwirte the Folder(y/n): "
    read  choice
    if [[ $choice == [Yy] ]]; then
        echo -e "\e[32m[*]\e[0mNow Backup $extract_to"
        mv "$extract_to" "$extract_to.backup"
        echo -e "\e[32m[*]\e[0mDecompress file"
        tar -zxvf "$archive_file" -C .
    else
        echo -e "\e[32m[*]\e[0mCancle decompress"
    fi
else
    echo -e "\e[32m[*]\e[0mDecompress file"
    tar -xzf "$archive_file" -C .
fi

cd glibc-2.29
mkdir build
cd build/
echo -e "\e[32m[*]\e[0mConfigure glibc-2.29"
chmod +x ../configure
../configure --prefix=/usr/local --disable-sanity-checks
echo -e "\e[32m[*]\e[0mCompile source code, wait patiently"
make -s -j 8
make install
cd /lib/x86_64-linux-gnu
cp /usr/local/lib/libm-2.29.so /lib/x86_64-linux-gnu/
ln -sf libm-2.29.so libm.so.6
echo -e "\e[32m[!]\e[0mGlibc-2.29 install complete!"
echo -e "\e[32m[!]\e[0mHack for fun!"