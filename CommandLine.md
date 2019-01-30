# Command Line Introduction

## How to Get Help with a Command

- `man` Will open the manual page for a command. For example: `man cat`
- `apropos` or `man -k` will find a man page for a specific topic. For example, 
`apropos copy`

## How to Operate the Terminal

### Terminal Navigation

- The up and down arrows can be used to cycle through recent commands.
- The tab key will complete a command
- `history` will show the most recent commands
- Ctrl-r will search through the history
- The current directory can be referred to as `.` and the parent directory can 
be referred to as `..`
- The home directory can be referred to as `~`
- The last command can be referred to with `!!`, which is especially useful if 
  you forget to add `sudo` in front of a command that needs priveledge elevation.

### Clearing the Screen

- `clear` is used to clear the terminal screen
- `reset` will reinitialize the terminal

### File Navigation

- `pwd` displays the full path for the current directory
- `cd` change directory
  - `cd some/file/path` will change the working directory to the specified
 directory.
  - `cd` with no arguments, as well as `cd ~` will change to your home directory
  - `cd /` change to the root directory
  - `cd ..` change to the parent directory
  - `cd -` change to the previous working directory
- `ls` lists files
  - `-a` include hidden files (those that start with a `.`)
  - `-l` list in a long format
  - `-t` sort by time last modified, newest first
  - `-r` reverse sorting
  - `-R` recursively include the contents of directories
  - `-h` human-readable size units when used with `-l`
  - `-U` don't sort (useful for large directories)
- `touch` create a new empty file if the file has not been created, update the 
timestamp if it has been created
- `nano`, `vi` open a file in a text editor
- `mkdir` create a directory
  - `-p` create parent directories if needed
- `rm` remove a file or directory
  - `-rf` is used to delete directories and their contents
- `rmdir` remove a directory if it is empty

### Helpful (or not) Tools

- `less` is a nice way to view long files
- `bc` is a calculator language
- `date` shows the date
- `cal` shows a calendar

### Wildcards

We have two main wildcard characters that we can use. `?` is a one character, 
and `*` can match any number of characters. It's worth noting that `*` excludes 
files and directories beginning with a `.`

## Input/Ouput

### Standard Streams

Normally, every program has three streams; input, output, and error.

#### Standard In

Standard in, sometimes shortened to stdin, is usually the keyboard, but 
sometimes it can be a file. To see this, if you just type `cat` it will simply 
return any input that you give it. In this mode, standard in is the keyboard. If 
you give cat a filename, like `cat /etc/passwd` or `cat < /etc/passwd` the file 
specified is the standard in. Note that angle brackets `< >` can be used to 
redirect input and output. Also note that cat is short for "concatenate", 
because you can specify multiple files and it will concatenate them.

#### Standard Out

Standard out, shortened to stdout, is sometimes the terminal window, but it 
can also be a file. If you type `echo "test"`, the output will be sent to the
terminal window. `echo "test" > test.txt` will output to the specified file. If 
you'd like to append a file rather than overwriting it, try `echo "test" >> 
test.txt"

#### Standard Error

The output of a file could be valid output or it could be an error message.
Standard error, shortened to stderr, is where these error messages are sent.
`find / -iname '*stuff*'` will result in many error messages unless we redirect 
standard error. That can be done with `find / -iname '*stuff*' 2> /dev/null`

### Piping and the UNIX Philosophy

Pipes allow you to use the output of one program as the input for another.
This allows for the stringing together of many commands. 

The pipe is the very thing that shaped the UNIX philosophy, which is best summarized as 
1. Write programs that do one thing and do it well
2. Write programs so that they can work together
3. Write programs that handle text streams, because they are a universal 
interface

The best illustration of the UNIX philosophy is Jon Bentley's challenge. He
challenged Donald Knuth and Doug McIlroy to write a program that reads a file of 
text, determine the n most frequently used words, and print out a sorted list of 
those words along with their frequencies.

Don Knuth's solution was over 10 pages of Pascal, but McIlroy's solution can be
written as one simple line.

`tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -c | sort -rn | sed ${1}q`

This can also be extended to the most occurences of multiple words in sequence.

[Bigrams](https://davidxmoody.com/2015/word-frequency-analysis-with-command-line-tools/)
`cat shakespeare.txt | tr -cs A-Za-z '\n' | tr A-Z a-z | awk -- 'prev!="" { print prev,$0; } { prev=$0; }' | sort | uniq -c | sort -rn | sed 1q`

[Trigrams](https://davidxmoody.com/2015/word-frequency-analysis-with-command-line-tools/)
`cat shakespeare.txt | tr -cs A-Za-z '\n' | tr A-Z a-z | awk -- 'first!=""&&second!="" { print first,second,$0; } { first=second; second=$0; }' | sort | uniq -c | sort -rn | sed 1q`

## Scripting

If we'd like to write longer programs, it's useful to make scripts so we can
take advantage of conditional statements, loops, and arguments. 

A shell script should be started with a `#!` and then the path to the scripting
interpreter's binary file. If there's no "shebang line" the sh interpreter will
be used. Also be sure to set the execute bit on your scripts so
they are executable. `chmod +x script.sh`

### Variables

Just like any programming language, you can use variables. There aren't any
variable types, and there's no need to declare a variable before you assign it.

```bash
#!/bin/bash

$STR="Hello, world!"
echo "$STR"
```

### Arguments

Arguments in bash are referred to as `$1` as the first argument, `$2` as the 
second argument, and so on. `$*` and `$@` both refer to all elements, but when 
double quoted, `$*` places all arguments in a single string, whereas `$@` gives 
each element its own string.. `$#` is the number of arguments.

```bash
#!/bin/bash

echo $(($1 * 2))
```

### Conditionals

If statements are done in the format

```bash
if condition; then
  # do something
elif condition; then
  # do something else
else
  # do another thing
done
```

The `elif` and `else` are not required, but `done` is necessary to end conditional statements. An example of this would be

```bash
#!/bin/bash

if (( $1 % 2 == 0 )); then
  echo "even"
elif (( $1 % 3 == 0 )); then
  echo "divisible by 3 but not even"
else echo "neither divisible by three nor two"
fi
```

### Loops

There are two options for loops; for and while. The syntax of for loops is

```bash
for i in some set of things; do
  # do something
done
```

The syntax of while loops is 

```bash
while condition; do
  # do something
done
```

## Grand Finale

```bash
#!/bin/bash

parse_args() {
  while [ "$#" -gt 0 ]; do
  case "$1" in
    -o|--oof) print_oof=1; shift 1;;
    -b|--bentley) bentley_challenge=1; bentley_file="$2"; shift 2;;
    -t) print_if_true=1: shift 1;;

    *) exit 1;;
  esac
  done
}

bentley() {
  curl -o /tmp/shakespeare.txt "$1"

  cat /tmp/shakespeare.txt | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -c \
        | sort -rn | sed 1q
}

main() {
  print_oof=0
  bentley_challenge=0
  print_if_true=0

  parse_args "$@"
  if [ "$print_oof" -eq 1 ]; then
    echo "oof"
  fi

  if [ "$bentley_challenge" -eq 1 ]; then
    bentley "$bentley_file"
  fi

  if [ "$print_if_true" -eq 1 ]; then
    echo "Big if true!"
  fi
}

main "$@"
```