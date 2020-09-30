---
marp: true
---

![width:346 height:278](debug.png)

# Debugging

- To follow along:
  - Connect to `stu` via SSH
  - `git clone https://github.com/lam2mo/uug-debug.git`

---

## Definitions

- **Software defect**: an error in code that produces incorrect behavior
  - Colloquially called “bugs”
  - Mismatch between user expectations and machine behavior
  - *Proximate cause* (symptom) vs. *root cause* (defect)
- **Debugging**: working from the former towards the latter
  - Basically: the process of continually asking “why is this happening?”
  - One of the most important practical skills in programming

---

## Definitions

- **Debugger** (e.g., `gdb`): a program that examines another running program
  - Execute the program step-by-step (by line or instruction)
  - Examine the contents of memory at any point
  - Add *breakpoints* and *watchpoints*
- Debuggers are more useful with extra information from the compiler
  - In gcc, compile with the `-g` option to enable this
  - It’s also useful to disable optimization (`-O0`)

---

## Running GDB

- `gdb ./program`  - launch GDB on program
  - (include `--tui` for "graphical" interface)
- `help <cmd>` - get description of a command
- `run <args>` - begin/restart execution
- `start <args>` - begin/restart execution and pause at main
- `quit` - exit GDB

---

## Process Control

- `break <func>` - set a *breakpoint* at the beginning of a function
- `break <file>:<line>` - set a *breakpoint* at a specific line of code
- `watch <loc>` - pause when a specific variable or memory location changes
- `continue` - resume execution (until a breakpoint, watchpoint, or segfault)
- `next` - run one line of code then pause (skips over function calls)
- `step` - run one line of code then pause (descends into functions)
- `nexti` / `stepi` - like `next` and `step` but run one machine instruction
- `finish` - run until current function returns

---

## Process State

- `print <expr>` - print current value of a variable or expression
- `print /x <expr>` - same as above but print in hexadecimal
- `ptype <expr>` - print the type of a variable or expression
- `display <expr>` - print value after every pause
- `info regs` - print values of all machine registers
- `info locals` - print values of all local variables
- `backtrace` - print stack trace (list of active functions on the stack)
  - (`up` and `down` to cycle through function call sites)

---

## Memory Examination

- `x/<N><u><f> <addr>` - examine memory at given address 
  - *N* is the number of units to display
  - *u* is the unit type:
    - `b` (byte)
    - `h` (half word - 2 bytes)
    - `w` (word - 4 bytes)
    - `g` ("giant" word - 8 bytes)
  - *f* is the format (any`printf` format or `i` for machine instructions)
    - `x` for hexadecimal is particularly useful here

---

## Resources

- [GDB Tutorial](http://www.cs.umd.edu/~srhuang/teaching/cmsc212/gdb-tutorial-handout.pdf)
- Cheat sheets: [simpler](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf) and [denser](http://users.ece.utexas.edu/~adnan/gdb-refcard.pdf)
- [Valgrind Tutorial](https://www.cprogramming.com/debugging/valgrind.html)
- [LLDB tutorial](https://lldb.llvm.org/use/tutorial.html)
- [GDB to LLDB command map](https://lldb.llvm.org/use/map.html)
