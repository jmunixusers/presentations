# Vim and Markdown

## Vim

Vim is described as a 'highly configurable text editor for efficiently creating
and changing any kind of text'

Vim is included under the alias vi on most UNIX systems, as well as OS X

Vim is designed with the intent to have functions easily accessible and to never
require the user to remove their hands from the home row.

### Getting started with Vim

To start vim without opening a specific file simply type `vim` on the terminal.
To open a file, write `vim filename`, in the case of this file, one would type
`vim vim.md`, like you likely already have.

to quit vim, simply hit `esc` a couple of times, then type `:q` and hit enter.
Hitting escape ensures that you are not in insert mode. if this gives you an
error, typing `:q!` will force exit, but will discard all changes.

to save a file in vim, go to normal mode and type `:w` this will save the file
directly back to the same filename. this can be combined with the `q` command
with `:wq`, saving and quitting at the same time.

#### Modes of Vim

Before we jump into movement, we should quickly go over 3 modes of vim; 
normal, insert and visual. You can enter these modes at any time while not in
another mode, and can get out of them by hitting the `esc` key.

##### Normal

Normal mode is the default mode of vim, and the mode vim goes to when the
escape key is pressed. In this mode, you can freely move the cursor, do some 
limited text manipulation, enter commands, search, and enter the other two modes.

Any vim command that is not a simple keypress will start with a `:` and is
written to the bottom of the terminal.

##### Insert

While in insert mode, vim acts as a basic text editor, type on the keyboard and
text appears in the file. Cursor movement can be achived with the arrow keys.
insert mode can be accessed with the `i` key, and will start the insertion at
the exact character that the cursor is on. if you wish to start at the character
after, use the `a` key instead
- `i` enter insert mode at current character
- `a` enter insert mode after current character

##### Visual

Visual mode is akin to selecting text in a graphical editor, though with some
more features. For now, Enter visual mode with `v` selecting the current
character, and move the cursor to select more text.
- `v` enter visual mode on a character-by-character basis
- `V` enter visual mode on a line-by-line basis

This mode acts like the copy-paste mode of vim.

Some commands from normal mode can actually be done in visual mode, and if
those commands take a selection of text as an argument, the selection will
automatically be whatever is selected. This allows for a simple	'replace in
selection function.'

#### Basic movement

Moving vim's cursor can be accomplished with the arrow keys, in a way similar to
that of 'normal' text editors, or with the use of the `h` `j` `k` and `l` keys
- `h` moves the cursor left
- `j` moves the cursor down
- `k` moves the cursor up
- `l` moves the cursor right

some more complicated movement can be achieved with other keys
- `w` jump one word ahead
- `b` jump one word backwards
- `0` start of line
- `^` first non-blank character of line
- `$` end of line
- `ctrl+d` move one-half page down
- `ctrl+u` move one-half page up
- `gg` top of page
- `G` bottom of page

many of these advanced options can be combined with the `v` visual mode to
select quicker, such as `v$` selects all text from the current character to the
end of the line.

Advanced movement will be described more later.

### Getting more advanced
Something to remember while using vim, if you want to do some simple changes 
to text or movement in vim, theres a good chance that it exists, and you should
check online to see what the command is.

I'll also point to [my vimrc](https://www.github.com/Advill/Dotfiles/blob/master/vimrc)
Where I have a fairly barebones config that makes the most of default vim
options. Most everything is commented and if you can't figure something out
feel free to ask me.

#### Simple macros
The `c` key while in normal mode will allow you to delete a selection and
immediately start inserting text, c stands for change after all. Though c on its
own will wait for a secondary input to tell it what it is removing. Using keys
from the more complicated movement section we can do commands like:
- `cw` change word: delete until the next space character, and insert
- `c$` delete until the end of the line, and begin inserting

A similar command is the `d` key, for delete. This, like change, will wait
for a secondary command before doing anything, though this has one useful
combination specifically for deleting: `dd` which will delete an entire line.

both of these commands can be issued in visual mode, and will do with one
keystroke the action it intended to do, such as selecting a couple of words and
hitting `c` will immediately take you to insert where that text was.

undo and redo in vim are used by `u` and `ctrl+r` respectively, and `.` can
repeat the last used command.

#### Cut/paste
The visual mode is mostly used for cutting and pasting, however **vim does not
share the same clipboard as the rest of the system.** (at least by default)

In visual mode, when you have a selection of text, these are the commands:
- `d` cuts the selection of text. Note that this has the same behavior whenever
text is mass-deleted even while not in visual mode, it is saved to the text
buffer.
- `y` is copy, or *yank* in vim's case.
- `p` is paste. This can be done over a selection of text in the same way as
anywhere else in the system.

note that p can be used anytime not in insert mode.

#### Find
The last part of vim I will go over in  this document is the find tool, it works
like it does in any other text editor but it is accessed with a simple `/`
this is then followed by any text you want to search for. You can then page
through all results using `n` and `N` to go forwards and backwards respectively.

### Finally
Vim is a very powerful text editing tool, and if you get used to it you will
never want to go back to anything less. there are great resources out there for
commands and shortcuts, the one I've been using for writing this guide is 
[vimsheet.com](www.vimsheet.com). There are many plugins for vim but I wouldn't
reccommend getting any until you are more comfortable with vim.

## Markdown

before this starts, if you are on a Linux/Mac distribution and you want to
see this code update live you can go install
[grip](https://github.com/joeyespo/grip) to view this markdown file on your
system.

*From here out, I'll be leaving everything improperly formatted for markdown as
practice using both it and vim.*

--- Basics of markdown ---

Markdown is described on the wiki page as a 'lightweight markup language with
plain text formatting syntax.' As far as we're concerned, markdown is a useful
tool for quickly writing code documentation, readmes for github, and converting
to HTML.

a lot of markdown's features are above, so we will touch base on a lot of those
things but mostly go over things I haven't used yet.

Headers use the # to denote the level of header. the more # the smaller the
header.
header 1
header 2
header 3

Paragraphs are unformatted, but to start a new paragraph, two newlines are
required (you can also use two spaces at the end of the line, but this is less
readable).
Links can be internal and external, and are created with brackets of the text
to be displayed followed by parenthesis of the link. Images can be linked in
same way with an explination point in front. something like

![asdf](./sample.jpg)

When documenting code, it's very useful to have examples in the documentation.
Thankfully, showing code is very simple;

Characters that markdown would normally read as syntax must be escaped with the
\ character, but the \ character itself need not be.

inline code is denoted by surrounding it with \` characters (the one below the
escape key)

block code is denoted by three \` characters, and syntax highlighting works by
putting the code type on the first line.

//code//java
if(bool.toString().equals("true")) {
    return 1 == 1;
}
//code//

The last few things that markdown does are numbered and bulleted lists
1 numbered lists start with 1. but any number after doesn't matter
2 this will show up as 2
2 this will show up as 3
8325 this will show up as 4

bulleted lists can start with a -
or a *

