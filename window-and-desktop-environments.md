# WM/DEs
*By Michael McGloin*
## Introduction
Coming from Windows/OSX, the idea of being able to change the default system
user interface can be a strange one. Both systems go to great lengths to make
their user experience acceptable for all users, but because of this it lacks
in some things that power users might want.

Linux, on the other hand, allows users to not only choose what type of
environment they want, but allows them to customize and even create their own
environments altogether, if they have the know-how. These evironments are
made up of **window managers** and **desktop environments**.

## The Basics
### Window Managers
Window managers (WM) are (generally) X-based clients that control the appearance
and behavior of frames (windows) where various graphical applications are drawn.
The manager determines the border, titlebar, size, and ability to resize
windows. Many window mangers are bundled with simple utilities like menus to
start applications or configure the WM itself.

For this presentation, we will talk about window managers as standalone, even
though all desktop environments include a window manager, just for ease of
distinction. Many window managers are not bundled with a desktop environment and
give the user complete freedom over teh choice of other applications to be used.
This allows the user to create a more customized environment, tailored to their
own specific needs. When using a standalone window manager, 'extras' like
desktop icons, toolbars, wallpapers, or widgets must be added with additional
dedicated applications.

The benefits of using a window manager and seperate applications to add what you
need are obviously that you get a more streamlined and customized experience,
where you can add what you want and ignore what you dont, while also providing
more customizability to your setup. The downside is everything is left up to
you. Nothing comes set up  or is even garenteed to work out of the box on your
machine. Configuration is also generally through the use of config files that
can be scattered throughout the system and have all sorts of different syntax.

### Desktop Environments
A desktop environment (DE) bundles together a variety of components to provide
a common graphical user interface that includes all the usual trappings of a
regular user expeirence. These generally include a window manager, desktop
background, icons, toolbar, and perhaps even desktop widgets. 

From here, the user is free to customize their GUI environment in many ways.
Desktop environments generally provide nicer and more easy to use configurations
for their apps, as they will generally be more integrated into graphical
elements instead of configuration files and the like.

The benefits to Destkop environments are that they have a much more unified
interface and generally work right after install, or take very few steps to get
to a working state. Many times, parts of destkop environments can be swapped
out, such as window managers or toolbars. The downsides are that a full desktop
environment is normally a heavier load on the system, as well as not being
as streamlined for each individual user's needs.

## WM types
Window managers generally fall into one of three types based on how they manage
windows by default. Those three types are Stacking, Tiling, and Dynamic:

### Stacking
Also referred to as floating windows, this is the type of environment many
people will be used to from windows or OSX. Stacking environments make heavy use
of the mouse to move and resize windows, and generally have very little in the
way of keyboard bindings for those who want them. 

The benefit of stacking window managers generally the shallow learning curve,
and user-friendlyness of their controls and operations. Though for users who
want more advanced operations and views, they tend to fall short.

### Tiling
Tiling window managers generally work like [Tmux](tmux.md) for your whole
system. They are designed so that no window overlaps another, and any new
window subdivides the available space to keep it that way.

This is a far offshoot from stacking window managers, as the mouse becomes near
useless for general navagation of a system, as much work is offloaded to
keyboard shortcuts instead. This means that tiling window managers have a far
steeper learning curve than stacking managers, but (should) require less hand
movement and can be faster to navagate as a result.

### Dynamic
Dynamic window managers are simply window managers with the functionality of
both previous types of managers. This allows for, say, windows to be tiled in
the background, and floated in front.

To be honest, I've never really given a dynamic WM a try, I had awesome
installed once upon a time but wasn't smart enough to figure it out all those
years ago. From what I can tell from screenshots and the like, it is very easy
to make them look good with a background and colorscheme, as seen by WMs like
[awesome](https://awesomewm.org) and their prevalence on
[linux theming subreddits](https://www.reddit.com/r/unixporn), but seem to
make actual data on screen hard to read compared to tiling managers.

## Backends
### X
Window managers and desktop environments historically have run on the X server,
a basic framework for a GUI environment. X doesn't define any visual styling,
but simply gives the tools required to create visuals. The current version of X,
X11, has been in use since september 1987. It was developed by the Massachusetts
Institute of Technology and has been taken over by the X.Org Foundation, who
maintains the X.Org Server as FOSS under the MIT License.

X was specifically designed with the ability to be used over network connections
using X forwarding. This means that a full desktop can be accessed by someone
not physically in front of the computer running the X server. The downside of
this approach is that no data can be sent from the X client to the X server,
as the client is assumed to only keyboard, mouse, and display as input/ouput.

Sadly, X is beginning to become a monolithic project to maintain and change,
and with it's growing age, some are looking for a replacement.

### Wayland
Arguably the biggest competitor to X, Wayland is being developed by the authors
of X, but under a different name as to not create expectations of values carried
over from X.

Wayland seeks to throw out many of the functionality requirements of X, as well
as to streamline and improve the experience for a modern compositor. Wayland can
be made compatible with X, through the use of XWayland which is just an X server
running as a Wayland client.

The main functionality that Wayland lacks is the ability to be used in the same
way as X over network connections. There have been attempts to get this working
in Wayland, but has yet to be implemented in any meaningful way.

## Examples
For some visuals as well as some reccomendations, I've included some good and
perhaps some strange examples of each type of WM/DE below.
### Window Managers
#### X Server
##### Stacking
[2bwm](https://github.com/venam/2bwm) (External)
- 2 border window manager

##### Tiling

#### Wayland
##### Stacking
[KWin](https://techbase.kde,org/Projects/KWin) (External)
- Standard KDE window manager since KDE 4.0
