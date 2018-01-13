Install Cuis Smalltalk and Ultibo for your platform.

In a command shell, run:

./run-kernel.sh

which will build and run Ultibo Example 04 - KeyboardInput in QEMU

In a cuis workspace, do:

Feature require: #'Ultibo-Pilot'.

From the world menu, open Ultibo Pilot.

In the pilot, you can connect/disconnect to/from the kernel.
While connected, the "Character" variable will be polled and displayed.
Type into the ultibo kernel (make sure qemu has focus) and you will see the polled value change.
