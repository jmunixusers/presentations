# Tmux
## What is Tmux?

Tmux stands for terminal multiplexer. Anyone who has taken 261 might recognize
the word multiplexer, but just in case you dont; multiplexers take one thing and
split it into many. In 361 it's referring to circuits, here we're referring to
your terminal.

## Why should I use it?

Because it pains me physically:

* Every time I go into the lab and see tons of people with multiple terminal
windows open, wasting all the space the top bar takes up, and having to alt tab
through every one until they get to the exact window they want.
* Whenever my roommate groans about having to open a second ssh window to have
two files open at the same time.

Both of these problems are easily solved with Tmux, and they dont even require
much technical overhead.

## Using Tmux

To start Tmux, simply type `Tmux` on the command line.

Wow! A bottom bar!

What you have now is simply a regular terminal running inside what Tmux calls
a 'session'. sessions contian windows and windows contain terminals. None of
this is complicated in theory and Tmux doesn't complicate it in practice either.

## Splitting your veiw

We will start with the most useful part of Tmux, before we go into how it works.

To split your view horizontally, simply press `CTRL` + `b` followed by `%`.

BAM, 2 terminals!

### Why?

Note that you are not pressing `CTRL` + `b` + `%`. This is because Tmux works off
a 'prefix' hotkey system, where `CTRL` + `b` is the default 'prefix' input. This
simply means that (by default) Tmux wont pay attention to any keystroke not
preceded by the prefix.

So now that you are sitting there with two terminals, how do you get between
them?

Start with your prefix, and follow it with the left arrow key.

And like magic, your cursor moves to the left terminal. This works for all arrow
keys exactly like you would imagine.

To split your current terminal vertically, simply enter the prefix followed by
`"`. This makes it easy to remember which one splits which way because they
divide the keyboard in the direction they divide your terminal.

Try splitting the terminal a couple times and moving around with the arrow keys.

Now I'm sure you've opened an ungodly number of terminals and are wondering how
to close them, well prefix + `x` has you there, will close the current terminal
after a confirmation window pops up on the bottom in a different color. Type `y`
if you are sure you want your window closed. You can also type `exit` directly
into the terminal and Tmux will handle the pane closing perfectly.

Quick ref:

* prefix + `%` : split horizontally
* prefix + `"` : split vertically
* prefix + `x` : close terminal

## Opening new windows

To open a new window in Tmux, type prefix followed by `c`. You will be greeted
with a new terminal as well as a new entry in the bottom information bar.
this bar shows open windows and their names. By default the names are generated
from whatever the last active terminal in use was on that window, they can be
changed by entering prefix + `,`. This will prompt for a new name to call the
window.

This is not strictly neccessary, and may even be a waste of time unless you
have 6+ windows at a time you are continuously working out of, but it is an
option.

Moving between windows is as easy as prefix + `0-9`, selecting the number listed
next to the window you want to move to. By default this is indexed at 0 for
some reason, so for now just deal with that and we'll fix it later.

You can also create a new window using a terminal from another one with
prefix + `!`.

Closing windows is the same as closing terminals, using prefix + `&`

Quick ref:

* prefix + `c` : open new window
* prefix + `,` : rename window
* prefix + `0-9` : switch to numbered window
* prefix + `!` : open window and move current terminal to it
* prefix + `&` : close current window
* prefix + `n` : next window
* prefix + `p` : previous window

## Sessions

Sessions are a sometimes useful, sometimes frustrating part of Tmux that can be
very powerful if used correctly, and can bring your system to it's knees if used
incorrectly.

Sessions are basically how Tmux saves your current set of windows and allows you
to return to them later

To list all current sessions use prefix + `s`. If you have attempted to use Tmux
before you might even see a few sessions open! You can hit enter on the current
attatched one to re-enter where you left off.

If you do you can type prefix + `:`, which will open Tmux command entry, and
type `kill-session -a`. This will simply kill all sessions besides the current.

Let's detach from the current session. Enter the prefix followed by `d` to
manually detach from the current session, you will return to the command line
with a line of output from Tmux that we don't particularly care about.

Now open Tmux again. You will be greeted with a new Tmux session. To move to
a different session while already in a Tmux session you can do prefix + `s` and
move to the old one and hit enter to attach.

These sessions will stay open once detached until they are manually closed.
Every once in a while I hear there is a purge on stu, so be sure to save your
work even if you are using sessions.

* prefix + `:` : Tmux command
* prefix + `s` : list sessions
* `Tmux a` : open Tmux and attach to last session
* `:kill-session -a` : kill all other sessions besides the currently open one.

### When are they useful?

One last quick sidenote, sessions are automatically kept if a terminal is lost.
This is most useful when stu or your internet are being dumb, and you get
disconnected. Your session will be automatically kept and can be accessed by
ssh-ing again or on the lab computers.

### How can they hurt me?

Let's say you keep losing connection to stu, but never re-attach your session.
This means you will keep creating new Tmux sessions and slowly but surely load
stu with terminal sessions simply waiting for you to return.

So make sure to close sessions and periodically check for open ones.

## Configuration

Here are some quick options from my `~/.Tmux.conf` that I think are nice
QOL improvements over base functionality.

```conf
# set base index to 1 for windows
set -g base-index 1

# rebind prefix to ctrl+a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Switch panes using alt+arrow keys
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-UP select-pane -U
bind -n M-Down select-pane -D

# Allow mouse control
set -g mouse on

# Turn off audio bell
set -g bell-action none

# turn visual bell on
set -g visual-bell on

# when I had Tmux wrap any shell I used, this command was useful to attatch
# Tmux to my current directory
# Binds to prefix + p
bind p attach -c "#{pane_current_path}"
```
