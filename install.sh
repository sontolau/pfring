#!/bin/sh

INST_DIR=$1/pfring

if [ "$UID" -ne 0 ]; then
    exit 1
fi

if [ ! -d "src" ]; then
    mkdir src
fi

if ! ( cd src && \
       tar xvf ../PF_RING*.gz && \
       cd PF_RING* && \
       ./installer.sh $INST_DIR ) > /dev/null 2>&1; then
    echo "Can' install PF_RING core."
    exit 1
fi

rm -rf src

install -m 0755 bin/* $1/pfring/bin

cp -rf etc $1/pfring/etc > /dev/null 2>&1

export PFRING_HOME=$1/pfring
export PATH=$PATH:$PFRING_HOME/bin

sed -i '/PFRING/d' $HOME/.bashrc

echo "export PFRING_HOME=$1/pfring" >> $HOME/.bashrc
echo "export PATH=\$PATH:\$PFRING_HOME/bin" >> $HOME/.bashrc
