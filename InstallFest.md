# InstallFest

## Getting Virtualbox

Go to the [VirtualBox
downloads](https://www.virtualbox.org/wiki/Downloads) page and get the
latest version of VirtualBox. Complete the installation.

## Getting the UUG image

Download the latest image from the [image
mirror](https://w3.cs.jmu.edu/uug/).

Versions are named for the year they were created and have a letter at
the end specifying the build within that year. Choose the highest year
and the highest letter.

## Importing the image to VirtualBox

Once the image has downloaded completely, you will need to import it to
VirtualBox. To do this, double-click the downloaded file. This should
open the VirtualBox program. Import the virtual machine with the default
settings.

## Launching the virtual machine

If you double-click "JMU Linux Mint 2017" within VirtualBox, it will
launch the virtual machine.

### Special instructions for Windows Users

For people with a device running Windows, you *may* get an error that
VT-x is not enabled. You will need to enable a BIOS feature to enable
virtualization.

To do this, open Settings and go to Updates and Recovery. On the left
side of the window, choose "Recovery". In the main portion of the window
(on the right), click "Restart now" under the Advanced Startup heading.

Once your computer reboots, click "Troubleshooting" and then "Advanced"
and then "Change UEFI Settings". Your computer may reboot again and you
may be prompted to press a key on your keyboard to enter BIOS settings.

Look for an option relating to virtualization and make sure that it is
enabled.

## Configuring the virtual machine

When the image boots up, it will walk you through an installer.
Configure the options as appropriate.

When it prompts you to choose a username, please enter your JMU e-ID. We
recommend **NOT** using your JMU password for the password. Do **NOT**
select "Encrypt home folder," but please select the option for automatic
sign on.

## Using the virtual machine

Once you have completed installation, you should be signed into your
account within the virtual machine. You can click the "stu-home" link on
the desktop to automatically mount your home folder on stu within the
virtual machine.

