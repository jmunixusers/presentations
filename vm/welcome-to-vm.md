# JMU CS Virtual Machine

Now that you have successfully installed the virtual machine, it will need to
be configured for the courses that you are taking. We use a tool called
[Ansible](https://ansible.com) to assist in the configuration process.

If you want to see the details of how this is implemented, you can view the
[GitHub project](https://github.com/jmunixusers/cs-vm-build) maintained by the
Unix Users Group.

## Configuring the VM for your class

The easiest way to configure your virtual machine is to use the provided
program. On your desktop, there is a shortcut called "JMU CS VM Configuration."
Open this tool and check the boxes for each course that you will need to have
your virtual machine set up for. Once you have selected the necessary courses,
click "Run." You can watch the status in the black terminal window within the
program and you will receive a notification when the configuration is complete.

## Installing and removing software

Though all software you should need will be installed when you configure the
virtual machine for your classes, you may want to install more software for
your own use.

### Using the Software Manager GUI

In the Menu, search for the Software Manager application. You can use this to
search for software to install. Much like the App Store or Play Store, once you
find what you're looking for, click the "Install" button.

### Using the `apt` tool on the command line

`apt` is a tool used by several variants of Linux to install software. The
term generally used to describe the software that you install with `apt` is a
**package**. For detailed information about how to use `apt`, you can either run
`man apt` or `apt --help` in your terminal; however, a basic primer is
included below.

To install a particular package, run

```
sudo apt update
sudo apt install PACKAGE
```

where `PACKAGE` is the name of the package you want to install.

To remove a particular package, run

```
sudo apt remove PACKAGE
```

To find package that corresponds to the software you want, run

```
apt search KEYWORD
```

where `KEYWORD` is the software to search for.A

To update all software on your system, run

```
sudo apt update
sudo apt upgrade
```

Linux Mint provides a [list](http://packages.linuxmint.com/list.php?release=Tara)
of all available packages.

## Shutting down and snapshotting the virtual machine

To shut down the virtual machine, you have a few options. You can either:

- Open the Mint menu that's in the lower-left of the VM, choose Quit (the
  red power icon), then choose "Shut Down" in the dialog that comes up.
- Click the Machine menu in VirtualBox and choose the ACPI Shutdown option. In
  the dialog that comes up, choose "Shut Down."
- To absolutely force the machine to power off (analogous to holding the power
  button on a physical machine), click the File menu in VirtualBox,
  click Close, and then "Power off the machine."

These options will completely shut down your virtual machine; however, you can
simply save the machine's state until the next time you're ready to use it by
just pausing the VM. VirtualBox automatically pauses the virtual machine if you
close the window the machine is running in.

There may be times where you will want to preserve a copy of the virtual
machine's state, such as before making a major change. To do this, you can go
to the Machine menu, click "Take snapshot," and then name the snapshot
something meaningful and press "Ok." Snapshots should not be used as a
long-term backup solution. Over time, the cumulative size of the snapshots
can grow quickly, taking up a large amount of disk space. In general, it
is best to keep a few snapshots and to mostly focus on taking snapshots before
making major changes to your virutal machine

## Connecting to stu easily

`stu.cs.jmu.edu` is a server managed by the department that you will need to
use throughout your courses.

### Using FileZilla

If you only need to access stu for to copy files to or from your VM, then you
can use FileZilla. In the Mint menu, search for FileZilla and open it. In the
top-left corner of the FileZilla window, click the black arrow. In the menu
that comes up, select the "JMU CS Student server (stu)" option. You will
then be prompted for your JMU e-ID password. After entering that, you will
be prompted to accept a key, you can click "Ok" on that prompt. You will then
be connected to stu and will be able to copy files.

### Using the command line

If you need to run commands on stu or ortherwise interact with it directly,
you can use `ssh`.

To connect to stu, open up a terminal window and type

```
ssh EID@stu.cs.jmu.edu
```

where `EID` is your JMU e-ID.

This will prompt you for your e-ID password and after entering it, you will
be connected to stu.

Eventually you may find it exhausting to type your password in every time
that you need to connect to stu. You can use an SSH key to sign in to stu so
that you don't need to use your password.

To generate a key, run

```
ssh-keygen -t rsa
```

Follow the prompts, using the default location, and choose a password
(preferably one that's different from your JMU e-ID password).

Then run

```
ssh-add
```

to add the key to your SSH agent.

Finally, copy the key to stu using the following command:

```
ssh-copy-id EID@stu.cs.jmu.edu
```

again replacing EID with your JMU e-ID.

Now you can use your key to connect to stu instead of your password.

## Reporting problems with the VM

Should you encounter any issues with your virtual machine or if you notice
there is software that you wish was installed by default,
[open an issue](https://github.com/jmunixusers/cs-vm-build/issues/new) on the
GitHub project. You can use this same form to request software be added for a
particular course. If you get an error while configuring the virtual machine,
try to have any files in `/opt/vmtools/logs` on your VM ready if possible when
creating an issue.


## Getting involved with the UUG


To learn more about how to use your new VM or being a part of a community of
users of open-source software, come to a meeting of the Unix Users Group on
Wednesday nights at 6:30PM in ISAT 246.

Follow us on Twitter [@jmunixusers](https://twitter.com/jmunixusers) or see
upcoming events on [BeInvolved](https://beinvolved.jmu.edu/organization/uug).

