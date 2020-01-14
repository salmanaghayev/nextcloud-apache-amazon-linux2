#!/bin/bash -uxe
#
# Prepare system for nextcloud devel
#

install_pip () {
        curl https://bootstrap.pypa.io/get-pip.py | $SUDO $PYTHON_BIN
        $SUDO pip install setuptools -U
        $SUDO pip install ansible -U
        $SUDO pip install netaddr -U
        $SUDO pip install dnspython -U
        $SUDO pip install passlib -U
        $SUDO pip install bcrypt -U
}

prepare_amzn() {
        $SUDO amazon-linux-extras install epel -y
        $SUDO yum install git vim mc curl facter libselinux-python python -y
        $SUDO yum update -y

        PYTHON_BIN=/usr/bin/python
        install_pip

        set +x
        echo
        echo "   Amazon Linux 2 ready for nextcloud."
        echo
        ansible --version
}

# root or not
if [[ $EUID -ne 0 ]]; then
  SUDO='sudo -H'
else
  SUDO=''
fi

prepare_amzn