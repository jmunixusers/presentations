# systemd

[systemd](https://www.freedesktop.org/wiki/Software/systemd/) is an init daemon for Linux that is
used on many distributions (such as Arch Linux, Debian, and RHEL). It significantly changes the
way that daemons have been started in the past. systemd introduces the concept of "unit files,"
which are declarative configurations with a standard syntax that are a significant departure from
the previous practice of using arbitrary shell scripts to start daemons. It incorporates easy ways
to do things like specifying the environment for a service or limiting the syscalls that can be
made by processes started by the service. systemd also provides a ton of helpful CLI commands to
analyze the state of your system.

## CLI commands

| Command                          | Short Description                                                       |
|----------------------------------|-------------------------------------------------------------------------|
| `systemctl status [unit]`        | Show the current status of all units or a single unit                   |
| `systemctl restart unit`         | Restart the unit                                                        |
| `systemctl stop unit`            | Stop the unit                                                           |
| `systemctl start unit`           | Start the unit                                                          |
| `systemctl enable unit [--now]`  | Enable the unit (run it on boot), and optionally start it now           |
| `systemctl disable unit [--now]` | Disable the unit, and optionally stop it now                            |
| `systemctl cat unit`             | Print the configuration for the unit                                    |
| `systemctl edit unit [--full]`   | Create an override config for the unit, or just override the whole file |
| `systemctl daemon-reload`        | Load all the changes made to the unit files on disk                     |
| `systemctl reboot`               | Reboot the computer                                                     |
| `systemctl poweroff`             | Turn off the computer                                                   |
| `systemctl suspend`              | Put the computer to sleep                                               |

## Service unit files

Service unit files end with `.service` and specify a service (or daemon) to run. Service files
look something like the following:

```ini
[Unit]
Description=Do the Foo
Requires=network.target
After=network.target

[Service]
# Service doesn't double fork or use systemd integration
Type=simple
ExecStart=/usr/bin/foo
# Always re-run ExecStart if the command exits (can also be on-failure)
Restart=always

# Make it so we can enable and not just start the service
[Install]
# Ensure the service runs before the system boot is considered completed
WantedBy=multi-user.target
```

Documentation for all options can be found with `man 5 systemd.service`

## Timer unit files

Timer unit files are a replacement for traditional `crontab` entries. They can be a dependency of
services or can depend on services (or actually any type of `unit` files).

An example Timer unit file from Arch Linux is:

```ini
[Unit]
Description=Daily rotation of log files
Documentation=man:logrotate(8) man:logrotate.conf(5)

[Timer]
OnCalendar=daily
AccuracySec=1h
Persistent=true

[Install]
WantedBy=timers.target
```

This timer will run every day. If the system isn't on at exactly one day since the previous run,
it will run as soon as possible. It will run within 23-25 hours (daily + AccuracySec=1h) of the
last time it ran.

## Mount unit files

Instead of specifying entries in `fstab(5)`, you can instruct systemd to mount different
filesystems.
(*Note: A well-configured systemd will automatically turn fstab entries into .mount units*).
These can be great when a service or timer depends on a particular file system to be mounted,
including an NFS share. You can also declaratively state that your mount file depends on NFS and
networking being ready! The automatically-generated mount unit for a `/boot` or EFI partition
might look something like:

```ini
[Unit]
Description=EFI System Partition Automount
Documentation=man:systemd-gpt-auto-generator(8)
Requires=systemd-fsck@dev-nvme0n1p1.service
After=systemd-fsck@dev-nvme0n1p1.service

[Mount]
What=/dev/nvme0n1p1
Where=/boot
Type=vfat
Options=umask=0077,noauto,rw
```

Note that systemd will ensure that the file system is `fsck(8)`'d before it is mounted.

## Other Unit Files

There are all kinds of other unit files far too complicated to start describing here. Some really
interesting ones include:

- slices
- targets
- devices
- sockets
