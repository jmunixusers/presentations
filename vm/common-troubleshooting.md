# Troubleshooting Common VM Problems

There are a few things that come up regularly during InstallFests. Ways to work around them
are documented here.

## Mac Unable to Install VirtualBox

On newer versions of macOS, additional protections have been put in place to prevent applications
from installing kernel extensions; however, that is exactly how VirtualBox has to function.

When running the initial installation of VirtualBox, you will receive an error message. Close out
of the Installer and open System Preferences. Go to Security & Privacy. Click "Allow" next to
"System software from 'Oracle America, Inc.' was blocked from loading." Close System Preferences.
Re-run the installer and it should complete successfully.

## Error message when starting the VM saying 'VT-x' or 'AMD-V'

You need to enable the virtualization features of your CPU. If you are a Windows 10 user, open
the Settings program. Choose Update & Security. On the left of the window, select Recovery. In the
middle of the screen under Advanced Startup, choose Restart Now. After you restart, choose
Troubleshoot, then Advanced Options, followed by UEFI Firmware Settings. In that menu, find options
relating to Virtualization and enable them. Choose the option to Save and Exit (often either this
can be clicked, or chosen by pressing F10).

When your computer boots, open VirtualBox and double-click the JMU CS VM again.

## Error message when starting the VM saying VERR\_NEM\_VM\_CREATE\_FAILED

This message is due to an issue with Hyper-V being in use on a Windows computer. Usually this
will be due to WSL2 being enabled. The easiest solution would be to convert all WSL2 installs
to WSL1 and disable WSL2. To do this, you will need to run Powershell as an Administrator.

For each installed Distro, run

```
wsl --set-version <Distro> 1
```

replace `<Distro>` with the name of the distro, such as 'Ubuntu' or 'Debian'. For a list of all
installed distros and the version of WSL they use, run `wsl --list --verbose`.

Then you need to disable the VirtualMachinePlatform for WSL2 by running

```
Disable-WindowsOption -Feature VirtualMachinePlatform
```

When prompted, choose to reboot. When your computer reboots, open VirtualBox and double-click the
JMU CS VM again.
