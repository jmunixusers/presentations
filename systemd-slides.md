---
marp: true

---
# systemd

---
# History

- All Unix-like systems require process/PID 1, where the kernel hands control to userland
- Historically, system startup was handled by a long series of shell scripts
  - All services were started alphabetically and sequentially, with games played with naming scripts `00-` through `99-`
  - Each service had written it's own script, potentially modified by each distro, and a mystery to the end-user
  - Responsible for starting, stopping, reporting status, and reloading configuration
  - Potential customization if the author had written hooks to a configuration file
  - Any changes overwritten by updates

---
# More History

- Outside Linux, Sun Solaris Service Management Framework and MacOS launchd started to take a more active role in managing services
- runit and Ubuntu upstart started a similar effort within Linux
- Neither gained much traction or had a grand vision of reforming Linux
- systemd started in 2010 with strong opinions about parallelizing operations, configuration over code, and adding their own utilities to streamline management
- Distro reactions to this have been.... very polarizing

---
# systemd utilities (pt1)

- systemd-analyze
- systemd-boot
- systemd-creds
- systemd-cryptenroll
- systemd-firstboot
- systemd-homed
- systemd-logind
- systemd-networkd

---
# systemd utilities (pt2)

- systemd-nspawn
- systemd-repart
- systemd-resolved
- systemd-run / run0
- systemd-stub
- systemd-sysusers
- systemd-timesyncd

---
# Unit types

- service
- socket
- device
- mount/automount
- swap
- target
- path
- timer
- slice
- scope

---
# Take a look

- Run `systemctl` and `systemctl status` to see how many things are launched by default

---
# systemd generators

- systemd realized early on they couldn't change the world all at once
- generator programs all systemd services to be created on-the-fly early in the boot process. Big two:
  - Legacy init scripts created as services
  - Lines in fstab created as mounts
- Allows for a gradual transition, but support for this is starting to wrap-up after 15 years

---
# systemd cgroup integration

- init scripts struggled to keep track of child processes, and cleanly shut down services
- systemd integrates with cgroup containers, so each service is confined
- This allows easy queries for running processes
- Kernel notifies when a group becomes empty
- `systemd-cgtop` allows viewing resource usage by service

---
# systemd security integration

- systemd can launch services as unprivileged users, instead of relying on scripts
- Capabilities and syscalls can also be removed, again using only configuration

---
# A note about targets

- init scripts historically used "runlevels" for the state of the system, with 3 for multi-user text and 5 for graphical interface
- systemd target units define a chain of dependencies and an ultimate goal
- systemd defines `multi-user.target` and `graphical.target`
- `systemctl get-default` to show your configured target
- `systemctl isolate name.target` to switch targets

---
# About parallelization

- While init scripts ran sequentially, systemd will launch anything in parallel that satisfies declared dependencies
- Yes, anything! Be careful about filesystems being mounted, network being online, etc
- There are pre-defined targets like `network-online.target` to help
- Try `systemctl list-dependencies ssh.service` to show a sample dependency tree

---
# About the boot process

- Both these will help you understand the boot order, and where delays happen
  - `systemd-analyze blame`
  - `systemd-analyze critical-chain`

---
# Find help

- `systemd(1)` man page is the homepage for systemd docs
- Dozens of others linked from there
- Pages are by concept, not by command line

---
# Starting a simple service

- `apt-get update` to download the current package list
- `apt-get install apache2` to install a simple web server
- `systemctl status apache2` to show the service status
- Browse `http://demo#.jmunixusers.org`
- `systemctl stop apache2` stop the service and browse again. Fail!

---
# Let's create a service

---
# Service types

- `simple` - start a binary in the background
- `forking` - start a binary that will launch child processes
- `oneshot` - start a binary and wait for completion
- ... and others

---
# A very simple service

```text
# cat /etc/systemd/system/speedtest.service
[Unit]
Description=Run openssl speed test

[Service]
ExecStart=/usr/bin/openssl speed -multi 4

[Install]
WantedBy=multi-user.target
```

---
# Activate, inspect, kill

- `systemctl daemon-reload` will re-read unit files
- `systemctl status speedtest` will show that the service exists, but currently idle
- `systemctl start speedtest` will launch our service
- `top` should show a lot of activity
- `journalctl -fu speedtest` will follow a unit's logs
- `systemctl stop speedtest` to kill the service

---
# Tame that service

- `systemctl edit speedtest.service` this will automatically create /etc/systemd/system/speedtest.service.d/override.conf

```text
[Service]
Restart=no
RuntimeMaxSec=30
AllowedCPUs=0
```

- `systemctl status speedtest` and see the drop-in config
- `systemctl start speedtest` watch `top` to see the service die at 30 seconds
- `systemctl status speedtest` and see the current status

---
# systemd timers vs cron

- cron is the traditional way to run tasks on a schedule
- Very simple to configure, very reliable, doesn't offer much else
- minute hour day-of-month month day-of-week command
  - `15 7 1 * * uptime` run the uptime command at 7:15 every first day of the month

---
# systemd timers

- Timers allow scheduling and task definition to be separated
- Scheduled tasks maintain all the dependency checking of services
- Tasks can be run after a reboot/poweroff if they were missed
- Tasks can be run periodically instead of on a fixed scheduled, such as hourly after boot

---
# Create a very simple timer

```text
cat /etc/systemd/system/speedtest.timer
[Unit]
Description=Run speedtest every minute

[Timer]
OnCalendar=*-*-* *:*:00
Persistent=true

[Install]
WantedBy=timers.target
```

- `systemctl daemon-reload`
- `systemctl start speedtest.timer`
- `systemctl status speedtest.timer`

---
# Security bonus round

- `apt-get install tree`

```text
# cat /etc/systemd/system/tree.service
[Unit]
Description=Run tree

[Service]
ExecStart=/usr/bin/tree -L 2 /

[Install]
WantedBy=multi-user.target
```

- `systemctl daemon-reload`
- `systemctl start tree`
- `journalctl -u tree`

---
# Security fail

- `systemd-analyze security tree`
- See our numerous failures and dangers
- Way too much to cover tonight, but working through these is a great exercise in understanding Linux security features

---
# Minor lockdown

```text
# cat /etc/systemd/system/tree.service
[Unit]
Description=Run tree

[Service]
ExecStart=/usr/bin/tree -L 2 /
InaccessiblePaths=/etc /var

[Install]
WantedBy=multi-user.target
```

- `systemctl daemon-reload`
- `systemctl start tree`
- `journalctl -u tree` make sure you're looking at the current run
