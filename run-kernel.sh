#/bin/bash

set -e

export PATH=/c/ultibo/core/qemu:/c/ultibo/core/fpc/3.1.1/bin/i386-win32:$PATH
fpc -al -s -B -O2 -Tultibo -Parm -CpARMV7a -WpQEMUVPB @/c/ultibo/core/fpc/3.1.1/bin/i386-win32/QEMUVPB.CFG -Fi/c/ultibo/core/fpc/source/rtl/ultibo/core KeyboardInput.lpr
chmod u+x ppas.bat
./ppas.bat
qemu-system-arm -M versatilepb -cpu cortex-a8 -m 256M -kernel kernel.bin -monitor tcp::12000,server,nowait
