#!/usr/bin/env bash

set -oue pipefail

dnf -y copr enable crashdummy/Displaylink
# dnf -y install eza

# - dkms
# - kernel-devel
# - kernel-headers
# - displaylink
# - libevdi
# depending on what's provided for your Fedora/kernel:
# - kmod-evdi

dnf5 repolist
dnf5 repoquery --available '*evdi*' '*displaylink*'

# Find the kernel version(s) installed in the image (not the host kernel)
KVER="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core | tail -n1)"
# Build kmods
akmods --force --kernels "$KVER"
# Generate module dependency info 
depmod -a "$KVER"
