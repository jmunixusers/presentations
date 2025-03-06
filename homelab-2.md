---
marp: true
theme: default
class: invert
footer: Slides written by Connor Sample - https://tabulate.tech
---

# Homelabbing (part 2)

## The Demo

---

<!-- footer: "" -->

## CasaOS

---

## Supported Platforms

<!-- footer: "<https://wiki.casaos.io/en/get-started>" -->

| Official Support (Tested) | Community Support (Tested) | Community Support (Untested) |
| ------------------------- | -------------------------- | ---------------------------- |
| Debian 12                 | Elementary 6.1             | Alpine                       |
| Ubuntu Server 20.04       | Armbian 22.04              | OpenWrt                      |
| Raspberry Pi OS           |                            |                              |

---

<!-- footer: "" -->

## Logging in to your VM

- Windows: Open command prompt or PowerShell
- Mac: Open Terminal
- Linux: You know

```bash
ssh user@xxx.xxx.xxx.xxx
```

<!--Password: `UUGdukes-demo`-->

<!--TODO: individual user logins-->

---

## Installing CasaOS

```bash
curl -fsSL https://get.casaos.io | sudo bash
```

---

## User Setup

- Account Creation
- Settings
  - Note on "Merge storage"
- Account Settings

---

## Installing Portainer

- BigBear vs Official repos

---

## Installing (and uninstalling) a simple application

- Mealie application (un)installation
- Portainer demo
- Userdata config folder

---

## CasaOS Container Management

---

## Installing NextCloud

- Custom app install
- BigBear vs LS vs official
- Environment variables

---

## NextCloud Trusted Domains Fix

```bash
/DATA/AppData/big-bear-nextcloud/html/config/config.php
```

---

## Updating Containers

---

## Custom App Repositories

<https://github.com/WisdomSky/CasaOS-LinuxServer-AppStore>

---

## Custom App Installation

<https://github.com/sysadminsmedia/homebox>

- <https://github.com/homarr-labs/dashboard-icons>

<!-- https://github.com/homarr-labs/dashboard-icons/blob/main/png/homebox.png?raw=true -->

---

## Questions?
