---
marp: true
---
# How to build a CS VM

---

# Follow along

## <https://github.com/jmunixusers/cs-vm-build>

---

# History and Early Encounters

- In the early 2000’s, students were primarily using desktops with big CRT (tube) monitors
- Virtualization barely existed
- InstallFests were all day ordeals
- Repartitioning and dual-booting was the only option
- Only about six people would show up
  - Two left with two operating systems
  - Two left with one operating system
  - Two left with no operating system

---

# History and Early Encounters

- Windows XP lacked the ability to resize partitions or dual-boot
- The arrival of laptops brought an explosion of uncooperative hardware
- WiFi and graphics drivers have always struggled on Linux
- No one could casually try Linux
- Removing Linux after trying an InstallFest was as risky as installing it with XP’s deficiencies
- CS labs were Windows and Mac at this point, giving students little incentive to match the classroom experience

---

# The move to virtualization

- The first Intel virtualization support arrived in 2005, with refinements in 2008
- The nice features take a few years to appear in mobile CPUs, and a few more years for widespread adoption
- VMware Workstation has always been expensive, and VirtualBox first appeared in 2007 (likely wasn’t given away free until it was bought by Sun Microsystems)

---

# Early VMs

- InstallFest attendees in the early VM days got a copy of VirtualBox and an install disk/ISO
- Got to run through the VM creation and installation themselves
- Much harder to keep a group working together than it is today
- Realized after a while that taking an hour of people’s time just to tell them to keep clicking “Next” wasn’t useful
- No time during an InstallFest to teach what’s going on during OS installation, and still get the installation done

---

# Approaching today

- Around 2015, the UUG starting building a VM appliance
- Figured if there was no value in watching the installer, we should just skip it
- Everything was set up manually from a few rough notes
- VM snapshots kept the whole project from collapsing
- The VM was upgraded and dragged forward semester to semester
- CS labs started replacing RedHat with Linux Mint

---

# The modern era

- In 2017, Dr. Mayfield approached the UUG about bringing together our VM and the CS101 class
- Software required for 101 grew the VM from ~2GB to 3GB+
- Shortly after, there was talk of adding another GB of CS354 robotics content
- We wanted to keep everybody working together, but…
  - Couldn’t sustain the size growth of the VM
  - Tracking all the setup notes was more difficult
  - Only one person could work on the VM at a time
- Ansible-powered VM was invented in fall of 2017
- Multiple contributors can add additional classes without inconveniencing other users

---

# Design considerations

- Make it your own workspace, users configure their own preferences on first boot, give it their own name, and set their own password
- Least surprise
  - Never modify preferences like appearance, fonts, colors, etc
  - Never remove programs, which is why we don’t offer a class "uninstall" option
  - Never modify something during packaging that removes a typical ability of Mint/Ubuntu
- Keep it lightweight for fast downloads, fits on a flash drive, and doesn’t fill laptop hard drives
- Prefer JMU mirror and faster downloads from mirror.cs.jmu.edu
- Try to keep our setup working between the VM and laptops

---

# VM Skeleton - too many buttons to get right

![](image01.png)

---

# Script it!

```batch
VBoxManage createvm --name "%VM%" --ostype Ubuntu_64 --register
VBoxManage modifyvm "%VM%" --cpus 2 --memory 2048 --vram 64
VBoxManage storagectl "%VM%" --name "SATA Controller" --add sata --bootable on --portcount=4
VBoxManage createhd --filename "%VMDISK%" --size 20480 --variant Standard
VBoxManage storageattach "%VM%" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "%VMDISK%"
VBoxManage storageattach "%VM%" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "%VMINSTALLDISK%"
VBoxManage modifyvm "%VM%" --audioout on
VBoxManage modifyvm "%VM%" --clipboard bidirectional
VBoxManage modifyvm "%VM%" --mouse usbtablet
VBoxManage modifyvm "%VM%" --usb on --usbehci off --usbxhci off
VBoxManage modifyvm "%VM%" --accelerate3d on
```

---

# Linux Mint OEM

Move quick, get the GRUB menu

![bg contain right](image02.png)

---

# Linux Mint OEM

![bg contain right](image03.png)

---

# Linux Mint OEM

![bg contain right](image04.png)

---

# The theory of Ansible

---

# Ansible key themes

- A Python script for turning YAML files into Python scripts
- Designed to efficiently manage thousands of machines
- Extensible interface and community (Ansible Galaxy) hub to extend its capabilities in limitless ways
- Acquired by RedHat and developed as open-source core with commercial support
- MTBIAGSD - "Mean time between idea and getting shit done"
- Project founders believe that you should be able to start getting real work done within an hour of encountering Ansible

---

# I·dem·po·tent - /ˌīdemˈpōt(ə)nt,ˈēdemˌpōt(ə)nt/

- "Idempotence is the property of certain operations in mathematics and computer science whereby they can be applied multiple times without changing the result beyond the initial application." -- Wikipedia
- Ansible configuration describes the desired end state, not the steps to get there
- Allows playbooks to be repeated, and steps will be quickly completed as they’re found to be already correct
- Watch an Ansible run and you’ll notice steps displayed as "Changed"
- A correct playbook should report no changes when run twice back-to-back

---

# Building Ansible

- A role contains tasks, handlers, files, templates, and variables
- A playbook is a series of tasks
- A handler is a step that only runs if a designated tasks reports that it "changed"
  - Example - restart a service only if you modify its configuration
- Tasks, handlers, and variables use YAML syntax
- Templates and variable interpolation use Jinja2 syntax
- A task can be given a list of items to bulk process, using a YAML array

---

# Our misuse of Ansible

Quick reminder: <https://github.com/jmunixusers/cs-vm-build>

---

# Misusing Ansible

- We only modify one host at a time - your laptop
- We use the "local" connection type, not SSH or WinRM
- Roles encapsulate one of:
  - Multi-step installations for applications used across multiple classes - Eclipse, jGRASP
  - An assortment of simple steps unique to one class - basic-prog-pkgs
- The "oem" role runs before packaging the VM
- The "common" role always runs
- Course tags determine which roles run for each class - cs101, cs149

---

# Role overview

```yml
- roles:
  - { role: common, tags: always, icon_mode: user }
  - { role: user, tags: always }
  - { role: wireless-printing, tags: always }
  - { role: filezilla, tags: always }
  - { role: basic-prog-pkgs, tags: ["cs101"] }
  - { role: adv-prog-pkgs, tags: ["cs261", "cs361"] }
  - { role: robot-pkgs, tags: ["cs354"] }
  - { role: eclipse, tags: ["cs101", "cs149", "cs159"] }
  - { role: jgrasp, tags: ["cs149"] }
  - { role: finch, tags: ["cs101"] }
  - { role: y86, tags: ["cs261"] }
  - { role: programming-langs, tags: ["cs430"] }
  - { role: vscode, tags: ["cs149"] }
```

---

# Step-by-step playbooks - roles/jgrasp/tasks/main.yml

```yml
- name: Install jGRASP dependencies
  apt:
    name: lsb-core
    state: latest
- name: Check jGRASP
  stat:
    path: '{{ jgrasp.zip }}'
  register: st
```

---

# Step-by-step playbooks - roles/jgrasp/tasks/main.yml continued

```yml
- block:
    - name: Fetch jGRASP zip
      get_url:
        url: '{{ jgrasp.url }}'
        dest: '{{ jgrasp.zip }}'
        checksum: 'sha1:{{ jgrasp.hash }}'
        force: yes
    - name: Remove old jGRASP directory
      file:
        path: '{{ jgrasp.install_path }}'
        state: absent
    - name: Unpack jGRASP zip
      unarchive:
        dest: '{{ global_base_path }}'
        src: '{{ jgrasp.zip }}'
  when: st.stat.checksum|default("") != jgrasp.hash
```

---

# Step-by-step playbooks - roles/jgrasp/tasks/main.yml continued

```yml
- name: Install jGRASP desktop icon
  template:
    src: jgrasp.desktop.j2
    dest: /usr/local/share/applications/jgrasp.desktop
    mode: 0644
  notify:
    - Update desktop menu
```

---

# Playbook variables - roles/jgrasp/vars/main.yml

```yml
jgrasp:
  url: 'https://www.jgrasp.org/dl4g/jgrasp/jgrasp206_02.zip'
  hash: '9b636f5b1c7687ad8dc4207ff2ad1723fd00c501'
  zip: '{{ global_base_path }}/jgrasp.zip'
  install_path: '{{ global_base_path }}/jgrasp'
```

---

# Playbooks with lists - roles/basic-prog-pkgs/tasks/main.yml

```yml
- name: Install introductory development packages
  apt:
    name: '{{ basic_prog_pkgs_intro_development }}'
    state: latest
```

---

# Making it usable

`$ ansible-pull -U https://github.com/jmunixusers/cs-vm-build -C master -t common local.yml`

- We’re targeting first-week CS students
- CLIs are hard/scary/intimidating/new
- GUIs are safe/happy/familiar

---

![bg contain](image05.png)

![bg contain](image06.png)

---

# The magic

- Checks the OS (Mint, other)
- Checks the version (Sylvia, Tara, Tessa, etc.)
- Sets the branch and repo to pull from
- Checks user configuration
- Calls pkexec and ansible-pull
- Displays output in mini-terminal
- Checks that Ansible succeeded
- Logs additional information

---

# Testing

- Pull requests are now automatically linted by GitHub Actions
- All pull requests require an independent review, helping spot errors early on
- A lot of QA still relies on manual testing
- Full CI/CD remains a goal, but would be expensive or abusive of free-tier services

---

# SHIP IT! Lots and lots of flash drives

![bg contain](image07a.jpg)
![bg contain right](image07b.jpg)

---

# On-going projects

- GUI tool improvements
  - Automagic PR testing
  - Button for opening log directories
  - Button for reporting issues
  - Codebase modernization
- Telemetry (opt-in)
  - Statistics reporting on class role usage would help guide future development

---

# Contributing to the project

![](image08.png)