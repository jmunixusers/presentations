# Bash scripting
### A little bit of background
A lot of the background for bash in general is given
[in the bash talk](CommandLine.md), so we won't retread all of that ground, but
forgive me if I repeat some things.

### Source-ing vs Executing
There are two ways to run a shell script. The easy way through `source` and the
slightly-more-work way of `chmod` and `./`. **There is a difference though!**

`source` simply takes every line of the input file and runs it as a command on
*your* shell. This means that all variables and side effects from the code
remain on your shell when the script finishes executing. This can be useful but
for most situations is not what you really want.

Making a file executable and using `./` executes the commands in a *subshell*,
meaning it's basically a different shell who's side effects do not carry back to
your main shell. This is most exemplified in the `cd` command. It is perfectly
reasonable to `cd` inside a script. If you call `source` on a script that uses
`cd` you will end up wherever the script `cd`'d to. Using `./` however will
not change your current working directory after returning.

Anyways it's generally good practice to use `./`. Here's how you do it if you
don't know:
```bash
chmod +x yourfile.sh
./yourfile.sh
```

## Syntax
#### Variables
Setting a variable is as easy as
```bash
VARIABLE="foo"
echo $VARIABLE
```

#### Variable replacements
Replacing values in strings in bash is very simple, just takes putting the
variable name in the string as long as you are surrounding your string with `"`.
`'` describes a literal string however, and will not replace variables or
expressions contained within.

```bash
echo "$VARIABLE bar"
# foo bar
echo '$VARIABLE bar'
# $VARIABLE bar
```

#### Expressions in strings
Putting an expression inside a string is similarly easy: simply surround the
expression with `$(expression)`, or `` `expression` ``
```bash
echo "I'm in $(pwd)"
echo "I'm still in `pwd`"
```

#### Brace expansion
Bash allows you to expand things inside braces pretty reasonably:
```bash
echo {A, B}     # A B
echo {A, B}.js  # A.js B.js
echo {1..5}     # 1 2 3 4 5
```

The last type allows step size with another `..` set:
```bash
echo {0..50..5}

#### eval

Brace expansions do not work directly in strings however, but we can use the
`eval` command to fix that:

```bash
echo "{1..5}.js"        # {1..5}.js
eval echo "{1..5}.js"   # 1.js 2.js 3.js 4.js 5.js
```

`eval` basically runs the command twice, first through the bash processor, and
second as the actual command. Here, bash expands the brace expansion syntax
before sending to echo.

#### Conditionals
The `[[ ... ]]` command is an alias for `test` and returns either 0 (true) or 1
(false), much of the description is listed in `man 1 test`. `[[ ... ]]` is
a superset of the `test` functionality, with a few added functions.

Some useful operators are: 
- `[[ -n STRING ]]`: String is nonzero
- `[[ -z STRING ]]`: String is zero
- `[[ STRING1 = STRING2 ]]`: Strings are equal
- `[[ STRING1 != STRING2 ]]`: Strings are not equal
- `[[ INT1 -eq INT2 ]]`: Integers are equal
  - Similarly `-ge` for >=, `-gt` >, `-le` <=, `-lt` <, `-ne` !=.
- `[[ FILE1 -ef FILE2 ]]`: Files have same device and inode numbers (*not
equality*)
- `[[ FILE1 -nt FILE2 ]]`: `FILE1` is newer than `FILE2`, includes `-ot` for
the reverse
- `[[ -e FILE1 ]]`: file exists

There are a ton of file-specific options, but I wont go through them all here.

Note we do not need to include the `$` when using a variable in a conditional.

There are also algebraic conditionals, defined with `(( ... ))`. An easy example
would be `(( NUM == 5 ))`, if `NUM` does equal 5, this "function" returns 0.

Writing an actual conditional statement is simple, but slightly different from
other languages you've likely used.

```bash
NUM=5
if (( NUM == 0 )); then
  echo "We have 0 problems! Good job!"
elif (( NUM == 1 )); then
  echo "We have 1 problem!"
else
  echo "We have $NUM problems!"
fi
```
Note the `fi` syntax, this will be a recurring theme in bash for other control
structures.

### Conditional execution
Remember how programming languages like java will lazily execute if statement
conditions, let's use the java example:
```java
if(foo() || bar())
  //code
if(func() && meth())
  //code
```
statements using `||` will stop executing as soon as a `true` value is found,
and conversely, `&&` stops as soon as a false is found. Bash has a similar
feature but does not require a surrounding if statement to work. (I guess java
doesn't technically either but it's bad practice to do that sort of thing)

```bash
git commit && git push
# if commit returns 0, push after. Don't push otherwise
git push || echo "Push failed!"
# if push returns 0, continue, otherwise print failure
```

#### Loops
Basic loops can be C style or more python-esque, with no change in
functionality:
```bash
# C like
for ((i = 0 ; i < 10 ; i++)); do
  echo $i
done

# Python like
for i in {1..10}; do
  echo $i
done
```
These two loops do not do the same thing however. The C-style iterator goes
0-9, and the other goes 1-10 inclusive. The second is also compatible with step
size in the same way as the first. This also iterates in a similar way to
python would, as the things in the bracket do not need to be numbers. It will
simply set i equal to each index in the array and iterate for that index. So
`for i in {a, b, c, d, e}; do` would work as expected.

While loops also exist and look like you'd expect:
```bash
while true; do
  ...
done
```

There is also an easy way to do text input from a file in a loop:
```bash
< file.txt | wile read line; do
  echo $line
done
```

#### Functions
Functions are pretty simple, defined with either just declaring `myfunc() { ...`
or with the `function` keyword.

```bash
func() {
  echo "bar"
}
```
Bash functions don't have returns in the normal sense. A function that prints to
stdout without being captured will simply print directly to stdout, however
calling the function as if it is a executable like we did above will print it
in the same way. The `return` keyword exists in bash, but it is used to define
the return value of the function. 0 is success and returned by default, and
any other number from 1-255 is valid but considered failure. This return value
can be accessed after the function finishes with the `$?` variable. 

Arguments in bash functions also don't work like other languages. You never
define parameters in the `()` part of a method declaration, this means you need
to check the number of paramaters passed to the function. This is done with
some more variables:
- `$0` the function's name
- `$#` the number of parameters passed
- `$1, $2, ...` the actual parameter values
- `$*` and `$@` hold all parameters passed to the function, but change when
double quoted
  - `"$*"` expands to a single string seperated by space (`"$1 $2 $n"`)
  - `"$@"` expands to seperate strings (`"$1" "$2" "$n"`)

This is the same syntax for command line arguments inside the script as a whole.
You need to pass any command line args into the function, but other global
variables without naming conflicts will stay in scope.

#### Data structures
These are fairly simple, albeit with strange definitions, so I'm just going to
write out how to use them.

```bash

##### Arrays
```bash
Arr=('one' 'two' 'three')

echo ${Arr[0]}      # "one"
echo ${Arr[1]}      # "two"
echo ${Arr[2]}      # "three"
echo ${Arr[@]}      # all elements, space-separated
echo ${#Arr[@]}     # all elements, space-separated
echo ${#Arr}        # String length of 1st element
echo ${#Arr[3]}     # String length of Nth element
echo ${Arr[@]:1:2}  # range from position 1, length 2

for i in "${arrayName[@]}"; do
  echo $i
done
```
##### Dictionaries
```bash
declare -A dict

dict[foo]="this"
dict[bar]="is"
dict[baz]="ez"

echo ${dict[foo]}   # this
echo ${dict[@]}     # all values
echo ${!dict[@]}    # all keys
echo ${#dict[@]}    # number of elements

unset dict[baz]     # delete baz

for val in "${dict[@]}"; do
  echo $val
done

for key in "${!dict[@]}"; do
  echo "${dict[$key]}"
done
```
## Examples

Lets do some quick examples to show some simple things you can do with bash.

### Dotfiles Installer
This is the first thing I wrote a bash script for and makes installing scripts
on a new install of linux super easy. This one specifically also keeps all your
dotfiles in your github repo folder which is nice.

```bash
#!/bin/bash

dir=$(pwd)
files="bashrc zshrc tmux.conf vimrc"
echo "current directory is ${dir}"
echo "moving current dotfiles to backup directory and installing new ones"

mkdir -p $dir/old

for file in $files; do
  echo "moving $file"
  mv ~/.$file $dir/old
  echo "creating symlink to ${file} in home directory"
  ln -s $dir/$file ~/.$file
done
```
