---
marp: true
---
# systemd-analyze security

---
# Introduction

- systemd is a large suite of utilities for booting systems and maintaining services
- At some point, the ability to report and score security for each service was added
- The kernel has a lot of facilities to restrict process's permissions, but many are difficult and poorly understood. systemd now allows you to declaratively apply those options on a per-service basis.

---
# Say what?

Let's take three major ideas:

- Capabilities
- Namespaces
- Syscalls

---
# Capabilities

- Traditional Unix(-like) systems have a root user who can perform any action and bypass most security
- Starting in Linux 2.2 (1999-ish), Linux started breaking root's powers into multiple "capabilities"
- Permissions can be applied to an executable with `setcap`
- systemd can either inject permissions at runtime or enforce a "bounding set" of capabilities that cannot be acquired
- Runtime injection is helpful when the binary serves many uses, like Java or Python

---
# Example capabilities

- CAP_CHOWN - modify file permissions
- CAP_KILL - kill any process
- CAP_NET_ADMIN - change IP addresses, routes, or firewall policy
- CAP_NET_BIND_SERVICE - bind to ports below 1024
- CAP_SYS_ADMIN - "root", a superset of all other capabilities
- CAP_SYS_TIME - change the system clock

---
# Namespaces

- Linux has the ability to create alternate views of the filesystem, process table, and network
- This is the basis of containers like Docker
- systemd can also use namespaces to create restricted views of devices and folders, and prevent an application from modifying other areas of the system

---
# Syscalls

- System calls are the means for programs to request kernel services, like launching programs, opening/reading/writing files, allocating memory, or connecting to the network
- Almost 300 calls for each of 32 and 64 bit Intel architectures
- Any particular application rarely needs a majority of the calls, and even less often needs to call across 32/64 bit architectures
- Filtering reduces the chance of an application exploiting a bug in an unusual or obsolete syscall

---
# The mostly complete list

- AmbientCapabilities, CapabilityBoundingSet
- DeviceAllow, ProcSubset
- IPAddressDeny, RestrictAddressFamilies
- NoNewPrivileges
- PrivateDevices, PrivateMounts, PrivateNetwork, PrivateTmp, PrivateUsers
- ProtectClock, ProtectControlGroups, ProtectHome, ProtectHostname, ProtectKernelLogs, ProtectKernelModules, ProtectKernelTunables, ProtectProc, ProtectSystem
- RestrictNamespaces, RestrictRealtime, RestrictSUIDSGID
- MemoryDenyWriteExecute, LockPersonality, SystemCallArchitectures, SystemCallFilter
- User, UMask, DynamicUser, SupplementaryGroups

---
# Further reading

- capabilities(7)
- syscalls(2)
- systemd.exec(5)
