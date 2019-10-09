# Vim and Markdown

## Vim

Vim is described as a 'highly configurable text editor for efficiently creating
and changing any kind of text'

Vim is included under the alias vi on most UNIX systems, as well as OS X

Vim is designed with the intent to have functions easily accessible and to never
require the user to remove their hands from the home row.

### Getting started with Vim

To start Vim without opening a specific file simply type `vim` on the terminal.
To open a file, write `vim filename`, in the case of this file, one would type
`vim Vim.md`, like you likely already have.

To quit Vim, simply hit `esc` a couple of times, then type `:q` and hit enter.
Hitting escape ensures that you are not in insert mode. If this gives you an
error, typing `:q!` will force exit, but will discard all changes.

To save a file in Vim, hit escape and type `:w` this will save the file
directly back to the same filename. This can be combined with the `q` command
with `:wq`, saving and quitting at the same time.

#### Modes of Vim

Before we jump into movement, we should quickly go over 3 modes of Vim; 
normal, insert and visual. You can enter these modes at any time while not in
another mode, and can get out of them by hitting the `esc` key.

##### Normal

Normal mode is the default mode of Vim, and the mode Vim goes to when the
escape key is pressed. In this mode, you can freely move the cursor, do some 
limited text manipulation, enter commands, search, and enter the other two modes.

Any Vim command that is not a simple keypress will start with a `:` and is
written to the bottom of the terminal.

##### Insert

While in insert mode, Vim acts as a basic text editor, type on the keyboard and
text appears in the file. Cursor movement can be achived with the arrow keys.
Insert mode can be accessed with the `i` key, and will start the insertion at
the exact character that the cursor is on. If you wish to start at the character
after, use the `a` key instead
- `i` enter insert mode at current character
- `a` enter insert mode after current character

##### Visual

Visual mode is akin to selecting text in a graphical editor, though with some
more features. For now, Enter visual mode with `v` selecting the current
character, and move the cursor to select more text.
- `v` enter visual mode on a character-by-character basis
- `V` enter visual mode on a line-by-line basis

This mode acts like the copy-paste mode of Vim.

Some commands from normal mode can actually be done in visual mode, and if
those commands take a selection of text as an argument, the selection will
automatically be whatever is selected. This allows for a simple	'replace in
selection function.'

#### Basic movement

Moving Vim's cursor can be accomplished with the arrow keys, in a way similar to
that of 'normal' text editors, or with the use of the `h` `j` `k` and `l` keys
- `h` moves the cursor left
- `j` moves the cursor down
- `k` moves the cursor up
- `l` moves the cursor right

Some more complicated movement can be achieved with other keys
- `w` jump one word ahead
- `b` jump one word backwards
- `0` start of line
- `^` first non-blank character of line
- `$` end of line
- `ctrl+d` move one-half page down
- `ctrl+u` move one-half page up
- `gg` top of page
- `G` bottom of page

Many of these advanced options can be combined with the `v` visual mode to
select quicker, such as `v$` selects all text from the current character to the
end of the line.

Advanced movement will be described more later.

### Getting more advanced
Something to remember while using Vim, if you want to do some simple changes 
to text or movement in Vim, theres a good chance that it exists, and you should
check online to see what the command is.

I'll also point to [my vimrc](https://github.com/Advill/Dotfiles/blob/master/config/nvim/init.vim)
~~where I have a fairly barebones config that makes the most of default Vim
options.~~ I have added quite a bit to my Vim config over the past year. However
Most things that are not basic Vim functions look more complicated, and should
be fairly simple to breeze over. Most everything is commented and if you can't
figure something out feel free to ask me.

A vimrc is basically a configuration file for Vim. It contains basic Vim
functions that are called every time Vim is started, instead of needing to run
them all manually.

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

Both of these commands can be issued in visual mode, and will do with one
keystroke the action it intended to do, such as selecting a couple of words and
hitting `c` will immediately take you to insert where that text was.

Undo and redo in Vim are used by `u` and `ctrl+r` respectively, and `.` can
repeat the last used command.

#### Cut/paste
The visual mode is mostly used for cutting and pasting, however **Vim does not
share the same clipboard as the rest of the system.** (at least by default)

In visual mode, when you have a selection of text, these are the commands:
- `d` cuts the selection of text. Note that this has the same behavior whenever
text is mass-deleted even while not in visual mode, it is saved to the text
buffer.
- `y` is copy, or *yank* in Vim's case.
- `p` is paste. This can be done over a selection of text in the same way as
anywhere else in the system.

Note that p can be used anytime not in insert mode.

#### Find
The last part of Vim I will go over in  this document is the find tool, it works
like it does in any other text editor but it is accessed with a simple `/`
this is then followed by any text you want to search for. You can then page
through all results using `n` and `N` to go forwards and backwards respectively.

##### Find/replace
Vim's substitute command isn't as easy as some other text editors, but with some
practice it isn't that bad.

The basic syntax is `:s/<find>/<replace>`. Writing the command like this will
only replace the first instance of `<find>` on the current line your cursor is
on though. Hardly useful. Lets take a look at a few expansions, replacing foo
and bar:
```vim
:s%/foo/bar " replace the first instance of foo on each line with bar
:s%/foo/bar/g " replace every instance of foo with bar
:5, 12s/foo/bar/g " replace every foo with bar in lines 5-12
```

This is another one of those commands that can be used with the visual tool,
so if you enter visual mode and begin selecting, then type `:`, you will notice
that `:'<,'>` is populated automatically, this means that Vim is going to use
the text selected already for the range of the next action. We can then use
`:'<,'>s/foo/bar/g` to do a find and replace in selection.

See? Not so bad.

### Visual block
One thing I want to mention but don't have a good place to is the visual block
mode. It is useful sometimes and something you might not find out about for a
while unless someone tells you so I'll just bring it up here.

Say, for instance you have a couple of lines with similar text and you want to
do a bulk insert in the middle of the line. While you could do a small vimscript
to do this, I don't know how to write vimscript. So the solution I use is the
visual block mode.

Hitting `ctrl+v` whisks you away to the strange world of visual block mode. In
this mode you can do what it sounds like: select blocks of text instead of
lines.

Visual block mode works basically like regular visual mode with some minute
differences:
- You can simply enter insert mode from this mode, but you must use `I` or
similar instead of regular `i`. I have no clue why.
- Any action you do on one line will be replicated across all selected ones.
- Text won't look like it's being inserted on every line, but it will be when
you exit insert mode.

### Finally
Vim is a very powerful text editing tool, and if you get used to it you will
never want to go back to anything less. There are great resources out there for
commands and shortcuts, the one I've been using for writing this guide is 
[Vimsheet.com](www.Vimsheet.com). There are many plugins for Vim but I wouldn't
really recommend any until you are comfortable with the basic features of Vim
and understand what you need.

## Markdown

Before this starts, if you are on a Linux/Mac distribution and you want to
see this code update live you can go install
[grip](https://github.com/joeyespo/grip) to view this markdown file on your
system.

*From here out, I'll be leaving everything improperly formatted for markdown as
practice using both it and Vim.*

--- Basics of markdown ---

Markdown is described on the wiki page as a 'lightweight markup language with
plain text formatting syntax.' As far as we're concerned, markdown is a useful
tool for quickly writing code documentation, readmes for github, and converting
to HTML.

A lot of markdown's features are above, so we will touch base on a lot of those
things but mostly go over things I haven't used yet.

Headers use the # to denote the level of header. The more #s the smaller the
header.
header 1
header 2
header 3

Paragraphs are unformatted, but to start a new paragraph, two newlines are
required (you can also use two spaces at the end of the line, but this is less
readable).
Links can be internal and external, and are created with brackets of the text
to be displayed followed by parenthesis of the link. Images can be linked in
same way with an explination point in front. Something like

![asdf](./sample.jpg)

When documenting code, it's very useful to have examples in the documentation.
Thankfully, showing code is very simple;

Characters that markdown would normally read as syntax must be escaped with the
\ character, but the \ character itself need not be.

inline code is denoted by surrounding it with \` characters (the one below the
escape key)

Block code is denoted by three \` characters, and syntax highlighting works by
putting the code type on the first line.

//code//java
if(bool.toString().equals("true")) {
    return 1 == 1;
}
//code//

The last few things that markdown does are numbered and bulleted lists
1 numbered lists start with 1. But any number after doesn't matter
2 this will show up as 2
2 this will show up as 3
8325 this will show up as 4

Bulleted lists can start with a -
or a *

## Extra Vim stuff
Just some nice plugins that I have started using. None of these change Vim's
behavior by very much, just add some nice features:

[Vim-gitgutter](https://github.com/airblade/vim-gitgutter) is basically a column
that tells you what has been added, removed, or modified in the current git
tree. Nothing game-changing, but can be nice.

[Vim-closer](https://github.com/rstacruz/vim-closer) is a simple plugin to
automagically close your brackets, parenthesis, and similar characters when you
might forget. **Very** useful for javascript.

[NERDTree](https://github.com/scrooloose/nerdtree) is a replacement for the 
default Vim directory navigation, with some added niceties. The major ones are
color coding of files based on type, option to pop-out NERDTree to the side of
your current window, and git integration with
[nerdtree-git](https://github.com/Xuyuanp/nerdtree-git-plugin)

Again, would hold off on these until you are used to Vim's basic functionality.
