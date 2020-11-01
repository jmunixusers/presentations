# Installing EHCI/xHCI controllers

For some courses, particularly CS 354, the VirtualBox Extension Pack will be
necessary in order to get controllers for USB 2.0 and/or USB 3.0. By default
the VM only includes USB 1.1 controllers.

The VirtualBox Extension Pack is licensed under the [VirtualBox Personal Use
and Evaluation License (PUEL)](https://www.virtualbox.org/wiki/VirtualBox_PUEL).
This license is not necessarily
[free](https://www.gnu.org/philosophy/free-sw.en.html) and it does not allow
redistribution, so it is not included with the VM by default.

## Steps to install

1. Download the VirtualBox Extension Pack from the
[VirtualBox website](http://download.virtualbox.org/virtualbox/5.2.4/Oracle_VM_VirtualBox_Extension_Pack-5.2.4-119785.vbox-extpack)
from your computer (the host), not from within the VM
1. Open the download
1. Press the Install button when VirtualBox prompts
1. Read and agree to the license (you have to scroll to the bottom before you
can agree)
1. You will be prompted for the password for your user on the host.
1. Once the extension pack as been installed, a dialog will come up informing
you. Press "OK".
1. Ensure that the virtual machine has been shut down completely
1. Open the settings for the virtual machine by right-clicking on it in the
VirtualBox window.
1. Click USB on the left side of the window
1. Choose either the USB 2.0 (EHCI) or USB 3.0 (xHCI) controller and press OK.

When you boot your VM for the next time, you should have the correct USB
controllers installed.
