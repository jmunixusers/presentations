# JMU CS Virtual Machine

Now that you have installed the virtual machine and set it up, you will configure
it for your class using a software called [Ansible](https://ansible.com).
We use Ansible to download and install software and files needed for your various
classes. To see the details of how this is implemented, you can view the
[GitHub project](https://github.com/jmunixusers/cs-vm-build) hosted by the
Unix Users Group.

## Configuring the VM for your class

You can configure the virtual machine for the various classes you're in using
one of two methods: typing commands on the command-line or using the provided
scripts on your machine.

The way that Ansible knows how to configure your
computer is by reading a set of files, called **playboosk**.
The playbooks are resumable, which means that if for any reason you need to cancel
the playbook while it's running, you can do so (press Ctrl + C), and then you can
run it again whenver it is convenient.

### Configuring using the provided scripts

On your desktop, there are a few files with the names of various CS courses.
One-by-one, double-click the name of each course you're in, wait for it to
complete, and then double-click the name of another course you're taking.

### Configuring using the command line

To configure using the command line, you will need to open a terminal and run
the following command, using the substitutions that are provided after.

```
ansible-pull -U https://github.com/jmunixusers/cs-vm-build -i hosts -K -t TAGS
```

When you run this command, replace `TAGS` with a comma-separated list of classes
that you are taking. Valid values are:

- cs101
- cs149
- cs159
- cs261
- cs354

For example, if you needed your computer to be set up with the correct tools for
CS101, CS159, and CS261, you would run the following command:

```
ansible-pull -U https://github.com/jmunixusers/cs-vm-build -i hosts -K -t cs101,cs159,cs261
```

## Installing and removing software

### Using the Software Manager GUI

In the Menu, search for the Software Manager application. You can use this to
search for software to install. Much like the App Store or Windows Store, once
you find what you're looking for, click the "Install" button.

### Using the `apt` tool on the command line

While the virtual machine, after running the Ansible playbooks, should contain
all of the software and files needed for the courses you're taking, you may want
to install more software for your own use. On Mint, the best way to install
software is by using the command line and utility called `apt`. The term that
is used to describe the software you install with `apt` is a **package**.

For detailed information about how to use the `apt` tool, you can either run
`man apt` or `apt --help` in your terminal; however a basic primer is included
below.

To install a particular package, run

```
sudo apt update
sudo apt install PACKAGE
```

where PACKAGE is the name of the package you want to install.

To remove a particular package, run

```
sudo apt remove PACKAGE
```

To update all software on your system, run

```
sudo apt update
sudo apt upgrade
```

Linux Mint provides a [list](http://packages.linuxmint.com/list.php?release=Sylvia)
of all available packages.

## Shutting down and snapshotting the virtual machine

To shut down the virtual machine, you have a few options. You can either:

- Click the Mint menu in the lower-left of the VM, choose Quit in the lower-left
of the menu, then choose Shut Down in the dialog that comes up
- Click the Machine menu in VirtualBox and choose the ACPI Shutdown option. In
the dialog that comes up in virtual machine, choose Shutdown.
- To absolutely force the machine to power off (analogous to holding the power
button on a physical machine), click the File menu in VirtualBox, cick Close,
and then Power off the machine.

This will perform a full shutdown of the system. To save the machines state until
the next time you're ready to use it, you can pause the VM.

There are times where you may want to preserve a copy of the virtual machine's
state, such as before making a major change. To do this, go to the Machine menu,
click Take snapshot, and then name the snapshot something meaningful and press Ok.
Snapshots should not be used as a long-term retention policy. Over time, the
cumulative size of the snapshots can grow quickly, taking up a large amount of
disk space. In general, it is best to keep the last couple of snapshots and to
mostly focus on taking snapshots before making major changes to your virtual
machine.

## Connecting to stu easily

There will be times in your courses where you need to connect to stu (or other
systems). To do this, open a terminal window and type

```
ssh EID@stu.cs.jmu.edu
```

where EID is your JMU e-ID.

This will prompt for your e-ID password and you will then be signed into stu.
Similar instructions will allow you to connect to any remote system that allows
you to sign in using SSH. The general usage of the SSH command is:

```
ssh USERNAME@HOST
```

Eventually it will be exhausting to type your password in every time that you
need to connect to stu. You can use an SSH key to sign in to to stu.

To generate a key, run

```
ssh-keygen -t rsa
```

Follow the prompts, using the default location and setting a password of your
choosing (preferably one that's different from your e-ID password).

Then run

```
ssh-add
```

to add the key to your SSH agent.

Finally, copy the key to stu using the following command

```
ssh-copy-id EID@stu.cs.jmu.edu
```

Again, replacing EID with your JMU e-ID.

Now you can use your key to more securely connect to stu.

## Reporting problems with the VM

Should you encounter any issues with your virtual machine or if you notice
there is software that you wish was installed by default,
[open an issue](https://github.com/jmunixusers/cs-vm-build/issues/new) on the
GitHub project. You can use this same form to request software be added for a
particular course.

## Getting involved with the UUG

To learn more about how to use your new VM or being a part of a community of
users of open-source software, come to a meeting of the Unix Users Group on
Wednesday nights at 6:30PM in ISAT 246.

Follow us on Twitter [@jmunixusers](https://twitter.com/jmunixusers) or see
upcoming events on [BeInvolved](https://beinvolved.jmu.edu/organization/uug).

