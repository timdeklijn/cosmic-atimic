#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

dnf5 install -y \
    akmod-evdi \
    displaylink \
    dkms \
    kernel-devel \
    kernel-headers

# Find the kernel version(s) installed in the image (not the host kernel)
KVER="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core | tail -n1)"
# Build kmods
akmods --force --kernels "$KVER"
# Generate module dependency info 
depmod -a "$KVER"
