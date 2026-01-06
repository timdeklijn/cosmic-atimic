#!/usr/bin/env bash

set -oue pipefail

# Find the kernel version(s) installed in the image (not the host kernel)
KVER="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core | tail -n1)"
# Build kmods
akmods --force --kernels "$KVER"
# Generate module dependency info 
depmod -a "$KVER"
