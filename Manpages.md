# Manpages

## What are they?

Manpages are *reference documentation* intended to give short but full
descriptions of command-line programs. Manpages give formatting for command
line inputs, and flags, as well as examples for each. Manpages are formatted
with `Troff` by default on UNIX systems, and the GNU fork `Groff` on Linux 
systems.

Generally designed for C programs, though since they dont actually interface
with the code at all, they can be used for any program.

### Where are they?

Manpages are kept in `/usr/share/man` and are generally filed under one of 8
sections:

1. User Commands * - Described as user commands and tools such as file 
manipulation programs, shells, compilers, web browsers, editors, etc.
2. System Calls - An entry point into the Linux kernal, contains tools such as 
*kill*, *mkdir*, and so on.
3. Library Functions - Contains all library functions excluding library
functions that wrap system calls, which are stored in man2. Contains functions
from the Standard C Library like *libc*, or other libraries like *libm*, where
the man page will alslo describe the linker option needed to link it.
4. Device Files - Manual files for devices on /dev/: *intel*, *sd*, *vmware*
5. File Formats - Formats, protocols, and corresponding C structures. *elf*, 
*time*, *motd*...
6. Games - Games and fun programs on the system, programs such as *fortune*,
*cowsay*, and a host of GNOME programs
7. Conventions and Miscellany - Overviews on varios topics, describes
conventions and protocols, character set standards, etc. Contains the Man page
for Man!
8. Administration and Privileged Commands * - Commands that are used by the 
superuser; System administration controls, daemons, and hardware-releated
commands.

Two other sections exist; L, which contains math library functions, and N,
which contains tcl functions.

## Where did they come from?

 - No documentation existed for UNIX for the first two years of it's existence

 - 'The Unix Programmers Manual' was the first manual published for unix,
published November 3rd, 1971.

 - At first, the manual fit into a standard binder, but by the 7th edition was
split into 2 seperate pages.

 - The manual also included some tutorials (mostly for general UNIX usage, the
C compiler, and tools that came with the system)

 - Manpages began using the `Troff`/`Groff` (`GNU Troff`) typesetting package 
at the 4th edition, and has continued to use it since.

 - At first, manpages were seen as a great advance, but today they have become 
a neccessity for command line applications

## Why do we use them?

Manpages are the most complete and accepted documentation for programs on the
command line.

### Are there any replacements?

What do you have against manpages? Anyways, There are a few, but none as
popular as man.

#### Sphynx

## How do I make one?

### Great question!
