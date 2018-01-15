Installation
============
Install Cuis Smalltalk, Ultibo, and Git for your platform.

Installing Cuis: replacing "MyProject" with "Cuis" use the "for all systems" and then the "Windows" installation instructions at https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev/blob/master/Documentation/GettingStarted.md

To install the pilot code, in a bash console:

    cd Cuis
    git clone https:github.com/markfirmware/Cuis-Smalltalk-Ultibo-Pilot

Operation
=========

In a bash console:

    cd Cuis
    cd Cuis-Smalltalk-Ultibo-Pilot
    ./run-kernel.sh

which will build Ultibo Example 04 - KeyboardInput and run it in QEMU. It will remain running in this console.

In a new bash console, start cuis:

    cd Cuis
    cd Cuis-Smalltalk-Dev
    ./cogspur/squeak.exe Cuis-Smalltalk-Dev/Cuis5.0-3245.image
    
From the cuis world menu open a workspace, and in it do:

    Feature require: #'Ultibo-Pilot'.

From the world menu, open Ultibo Pilot.

In the pilot, you can connect/disconnect to/from the kernel.
While connected, the "Character" variable will be polled and displayed.
Type into the ultibo kernel (make sure qemu has focus) and you will see the polled value change.
