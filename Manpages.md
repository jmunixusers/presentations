# Manpages

## What are they?

Manpages are *reference documentation* intended to give short but full
descriptions of command-line programs. Manpages give formatting for command
line inputs, and flags, as well as examples for each. Manpages are formatted
with `Troff` by default on UNIX systems, and the GNU fork `Groff` on Linux 
systems.

Generally designed for C programs, though since they don't actually interface
with the code at all, they can be used for any program.

### Where are they?

Manpages are kept in `/usr/share/man` and are generally filed under one of 8
sections:

1. User Commands * - Described as user commands and tools such as file 
manipulation programs, shells, compilers, web browsers, editors, etc.
2. System Calls - An entry point into the Linux kernel, contains tools such as
*kill*, *mkdir*, and so on.
3. Library Functions - Contains all library functions excluding library
functions that wrap system calls, which are stored in man2. Contains functions
from the Standard C Library like *libc*, or other libraries like *libm*, where
the man page will also describe the linker option needed to link it.
4. Device Files - Manual files for devices on /dev/: *intel*, *sd*, *vmware*
5. File Formats - Formats, protocols, and corresponding C structures. *elf*, 
*time*, *motd*...
6. Games - Games and fun programs on the system, programs such as *fortune*,
*cowsay*, and a host of GNOME programs
7. Conventions and Miscellany - Overviews on various topics, describes
conventions and protocols, character set standards, etc. Contains the Man page
for Man!
8. Administration and Privileged Commands * - Commands that are used by the 
superuser; System administration controls, daemons, and hardware-related
commands.

Two other sections exist; L, which contains math library functions, and N,
which contains tcl functions.

## Where did they come from?

 - No documentation existed for UNIX for the first two years of it's existence

 - 'The Unix Programmers Manual' was the first manual published for UNIX,
published November 3rd, 1971.

 - At first, the manual fit into a standard binder, but by the 7th edition was
split into 2 separate pages.

 - The manual also included some tutorials (mostly for general UNIX usage, the
C compiler, and tools that came with the system)

 - Manpages began using the `Troff`/`Groff` (`GNU Troff`) typesetting package 
at the 4th edition, and has continued to use it since.

 - At first, manpages were seen as a great advance, but today they have become 
a necessity for command line applications

## Why do we use them?

Manpages are the most complete and accepted documentation for programs on the
command line. 

### Are there any replacements?

What do you have against manpages? Anyways, There are a few, but none as
popular as man.

#### Sphynx

As Manpages were originally created for C, Sphynx was originally created for
Python. It uses `reStructuredText` as it's markup language, and has a few
benefits over man. There also appears to be a program somewhere out there that
converts rST to Groff, called `rst2man`.

[Sphynx](http://sphinx-doc.org) (External)

### ManOpen

Less of a replacement, more of a refresh. A utility to view manpages in a
graphical environment instead of a terminal emulator.

[ManOpen](www.clindberg.org/projects/ManOpen.html) (Extermal)

### Other Converters

There are plenty of converters from man to whatever arbitrary file type you
could ever want, but with most of these comes the drawback of not just being on
man, which is standard anyways.

## How do I make one?

Remember: Manpages are **reference documentation**, not code documentation,
and is meant to quickly answer questions about commands.

First, see if you can find a program you want to include documentation for. A C
program that takes flags is preferred, but since the documentation isn't
directly linked, anything will do. If you want you can simply practice the
formatting of a manpage.

If you are in CS261, I will use our current project as an example.

Before we start, think about what section of the manpages your program would
fit into, In my case, since the program is a user command to be run from the
command line.

First I will make a new file called `y86.l`, because my program is called y86.
If we were going all the way with this, we would also put the file in man/man1,
and as a `.gz` file, but we won't worry about this for now.

At the top of the file, we will put `.TH Y86 1`, this sets the header/footer of
our manpage to read Y86 1, something like this should be included in every man
page. 

From there we will describe our first Section Header as NAME with 
`.SH NAME` Lines with headers like these simply end on the next new line, so
we can start writing the name of our manpage on the next line. Dashes require
escaping. This section is the source for `man -k` searches, so make sure your
explanation is useful.

`y86 \- y86 mini-elf file interactions`

Now is a good a time as any to talk about fonts, so here we go. Fonts can be
done in two ways, with dot-commands at the beginning of a line, such as `.B`
for bold, or with the escaped `\f` sequence, so that `\fI` creates italics 
(underlines in the terminal). but before you start styling-up your text with 
*crazy* underlines and italics, know that they each have a specific purpose in
man pages. From man's manpage:

 - Bold text is meant to typed exactly as shown
 - Italic text is to be replaced with appropriate arguments
 - any and all arguments within [] are optional
 - options separated by a \| cannot be used together
 - ... means that whatever precedes it is repeatable

Keep this in mind for the next section.

Continuing on from here, we get the Synopsis section header, which describes
the command line options required to run the program. From here out, I'm just
going to refer to the completed section of text at the bottom of this 
presentation. For our example file, we are bolding y86, because that is 
certainly needed to run the program. We then give italicized options within
brackets, as any options wanted can be called, and we don't want the user to
type OPTION. after that we give ellipses, showing that the user can type as many
flags as they want, followed by italicized file.

From then on, we get a Description section header, which is simply followed by
a description of the program's function. While there are no specific size
restrictions on this section, it is generally kept short. 

For our next section, Options, we describe the section header, but then have
an odd line marker in `.TP`. This command basically takes whats on the next
line, indents it once, then the line after that it indents further, giving a
well formatted option format.

After that you can add all the options you want, just format them the same way.

For this demo, we won't be going into any further options or headers, but they
can all easily be found on the man manpage(accessed by `man man`), or online.

to view your shiny new manpage type `man -l file` on the command line, where
file is the name of your page.

```
.TH Y86 1
.SH NAME
y86 \- y86 mini-elf file interactions
.SH SYNOPSIS
.B y86
[\fIOPTION\/\fR]... 
.IR file
.SH DESCRIPTION
.B y86
reads .o files made for the imaginary y86 processor architecture, and prints 
information based on flags given.
.SH OPTIONS
.TP 
.BR \-h \fR
display the flag options
.TP
.BR \-H \fR
display the elf header of the file
.TP
.BR \-m \fR
briefly display the virtual memory
.TP
.BR \-M \fR
display all contents of the virtual memory
.TP
.BR \-s \fR
show the program headers in the file
.TP 
.BR \-d \fR
display the assembly operations contained in all code segments of the file
.TP
.BR \-D \fR
display the data segments contained in any read only or read write segment in
the file.
```

## Sources
[liw](https://liw.fi/manpages) (External)
