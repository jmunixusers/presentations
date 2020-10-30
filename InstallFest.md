# InstallFest

The Unix Users Group provides an modified image of Linux Mint that is
intended to function like the Linux lab computers in ISAT. The image has
software recommended and requested by a variety of professors in the
department.

The image is provided as a virtual machine intended to be used with
VirtualBox, which allows you to install it on your computer with no
impact to your existing operating system.

In order to get the most use out of the image, it is important to follow
the steps in the "Configuring" section below when going through the
installer in the virtual machine. Additionally, some PCs with Windows
will need to modify BIOS settings to enable the virtualization features
necessary to run the virtual machine.

This guide will give you a brief overview of what is done at the
InstallFest and should allow you to install the image on your own if
necessary. Please consider reading through all the steps before
beginning.

## Getting Virtualbox

Go to the [VirtualBox
downloads](https://www.virtualbox.org/wiki/Downloads) page and get the
latest version of VirtualBox. Complete the installation. For the most
part, this will consist of agreeing to the license agreement and
pressing "Continue" or "Next" on all the prompts you are given.

## Getting the UUG image

Download the latest image from the [image
mirror](https://w3.cs.jmu.edu/uug/).

Versions are named for the year they were created and have a letter at
the end specifying the build within that year. Choose the highest year
and the highest letter (for example, attendees at the fall 2017
InstallFest will choose image2017e.ova).

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
VT-x  or AMD-V is not enabled. You will need to enable a BIOS feature to
enable virtualization.

To do this, open Settings and go to Updates and Security. On the left
side of the window, choose "Recovery". In the main portion of the window
(on the right), click "Restart now" under the Advanced Startup heading.

Once your computer reboots, click "Troubleshooting" and then "Advanced"
and then "Change UEFI Settings". Your computer may reboot again and you
may be prompted to press a key on your keyboard to enter BIOS settings.

Look for an option relating to virtualization and make sure that it is
enabled.

If you do not get an error when launching the virtual machine, you do
not need to complete these steps.

## Configuring the virtual machine

When the image boots up, it will walk you through an installer.
Configure the options as appropriate.

Recommended settings:

* Language: English
* Time Zone: New York
* Keyboard: English (US)

When it prompts you to choose a username, please enter your JMU e-ID. We
recommend **NOT** using your JMU password for the password. Do **NOT**
select "Encrypt home folder," but please select the option for automatic
sign on. You may enter whatever you would like for your full name or for
the computer name.

After that screen, the actual installation process will begin. Depending
on your host machine, this can take several minutes. Please be patient.
Once the installation is done, your virtual machine will reboot.

## Using the virtual machine

After your virtual machine finishes rebooting, you will either be signed
in and at your desktop or at a welcome screen (if you're at the welcome
screen, sign in with the username and password you chose during
configuration). You can click the "stu-home" link on the desktop to
automatically mount your home folder on stu within the virtual machine.
