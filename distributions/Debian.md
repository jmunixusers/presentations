---
marp: true

---
# Debian
The godfather of Linux distros

---
# Debian History

- Almost the oldest continuous Linux distribution - first release in September 1993
  - Slackware is slightly older with a first release in July 1993
  - Linux kernel was only introduced in 1991
- Named after founder Ian Murdock and his wife Debra (Deb-Ian)
- Current version is only 11.2, due to Debian's slow and steady release cadence
- Very opinionated about software freedoms
- Basis for other well-known distros

---
# Debian Toy Story Version Naming

- Debian 1.x - Buzz, Rex, Bo
- Debian 2.x - Hamm, Slink, Potato
- Debian 3.x - Woody, Sarge
- Debian 4.0 - Etch
- Debian 5.0 - Lenny
- Debian 6.0 - Squeeze
- Debian 7 - Wheezy
- Debian 8 - Jessie
- Debian 9 - Stretch
- Debian 10 - Buster
- Debian 11 - Bullseye

---
# Debian Architectures

- armel / armhf / arm64
- i386 / amd64
- mips / mipsel / mips64el
- ppc64el / s390x

---
# Debian Software Packaging (by license)

- Repositories have grown from 500 packages in 1.x era to over 51,000 now
- Packages organized by three primary licensing schemes:
  - `main` - completely free software according to Debian guidelines
  - `contrib` - still free software, but has dependencies outside the Debian repos
  - `non-free` - software that is not under a free license

---
# Debian Software Packaging (by release cadence)

- Packages are part of several release streams
  - `old stable` - packages from the previous stable release
  - `stable` - packages from the current stable release
  - `testing` - packages that have sat in unstable for weeks with no major bugs filed
  - `unstable` - package updates that have just been submitted, and are believed to be ready for use
  - `experimental` - package version that are still incubating, and might require major changes, and coordination across maintainers
- `unstable` and `testing` are under increasing strict rules for new versions as the 2-3 year stable release cadence progresses

---
# Debian Software Packaging (tools)

- `dpkg` tool at the heart of everything
  - In its 3rd rewrite, shell -> Perl -> C
  - You're probably having a weird day if using this is necessary
- `apt-get`, `apt`, `aptitude`, or `Synaptic` are more common front-ends to the `dpkg` tool
  - Package browsing and searching
  - Automated downloads
  - Dependency resolution

---
# Debian Software Packaging (frustrations)

- Strict adherence to licensing freedoms
- Separate package for each library
- Packages must be able to update themselves
- Often a maddening array of "supported" configurations
  - systemd vs sysvinit
  - kFreeBSD vs Linux
  - Desktop environments
- Very long release cycles

---
# Desktop Environments

Debian doesn't like doing per-DE installers, and most notable desktop environments are packaged and selectable from a common installer:

- GNOME
- KDE
- Xfce
- LXDE
- MATE

Others packaged for later installation:

- Cinnamon, LXQt, Budgie, Enlightenment, FVWM-Crystal, GNUstep/Window Maker, Sugar Notion WM

---
# Derivatives

- Ubuntu
  - Clones Debian `unstable` at the start of every release cycle
  - Six month release cadence, long-term support edition every two years
  - Separate installers for different desktop environments
- Mint
  - Six month releases of their own packages, new Ubuntu core with each LTS
  - Only Cinnamon and MATE desktops supported
- Raspbian
  - Modified kernel/boot, and minimal desktop environment
- Kali, Tails, Pop!_OS, many, many others
