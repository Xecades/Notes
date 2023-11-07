# MIT Missing Semester

[MIT Missing Semester](https://missing.csail.mit.edu/) is a course that teaches the *untaught* parts of computer science.

> Classes teach you all about advanced topics within CS, from operating systems to machine learning, but there’s one critical subject that’s rarely covered, and is instead left to students to figure out on their own: **proficiency with their tools**. We’ll teach you how to master the command-line, use a powerful text editor, use fancy features of version control systems, and much more!
> 
> <div align=right>——MIT Missing Semester</div>

---

## Shell Scripting

### Variables

**To define a variable**: use `foo=bar` instead of `foo = bar`. The latter tries to run a command named `foo` with arguments `=` and `bar`.

**To use a variable**: use `$foo`.

**Special variables**: (take `./script.sh foo bar` as an example)

 - **`$0`**: `./script.sh`, name of the script.
 - **`$1` to `$9`**: `foo` to `bar`, arguments to the script.
 - **`$@`**: `foo bar`, all arguments.
 - **`$#`**: `2`, number of arguments.
 - **`$?`**: Return code of the previous command.
 - **`$$`**: PID of the current script.
 - **`$_`**: Last argument of the last command.

**Arithmetic**: use `((x + y))` to do arithmetic. Use `$((x + y))` to use the result of the arithmetic. Comparisons like `((x >= y))` are also supported.

### Operators

**Operator `||`, `&&` and `;`**:

 - **`foo || bar`** means "run `foo`, if it fails, run `bar`".
 - **`foo && bar`** means "run `foo`, if it succeeds, run `bar`".
 - **`foo ; bar`** means "run `foo`, then run `bar`".

Example:

```sh
false || echo "Oops, fail"           # Oops, fail
true || echo "Will not be printed"   #
true && echo "Things went well"      # Things went well
false && echo "Will not be printed"  #
true ; echo "This will always run"   # This will always run
false ; echo "This will always run"  # This will always run
```

**Command substitution**: use `$(foo)` to run `foo` and use its output as a string. Example: `for file in $(ls)` iterates over all files.

**Process substitution**: `<(foo)` will run `foo` and place the output in a temporary file and substitute the `<()` with that file’s name. Example: `diff <(ls foo) <(ls bar)` compares the files of directory `foo` and `bar`.

### Redirection

**Input**: use `<` to redirect input from a file.

**Output**: use `>` to redirect output to a file. Use `>>` to append to a file.

**Error**: use `2>` to redirect error to a file.

**Both output and error**: use `&>` to redirect both output and error to a file.

**Both input and output**: use `<>` to redirect both input and output to a file.

**Discard**: redirect to `/dev/null` to discard output/error/input.

**Pipe**: use `|` to pipe the output of a command to the input of another command.

### Control Flow

**`If`**: use `if foo; then bar; fi` to run `bar` if `foo` succeeds. `foo` can be any command or a test. Refer to `man test` for more information about tests. Here are some simple examples:

 - **`if [[ -d foo ]];`**: if `foo` is a directory.
 - **`if [[ -f foo ]];`**: if `foo` is a file.
 - **`if [[ $foo -ne 0 ]];`**: if `foo` is not equal to `0`.
 - **`if [[ $foo -gt 0 ]];`**: if `foo` is greater than `0`.

The `[[ ]]` notation is syntactic sugar for the `test` command. The following two lines are equivalent:

```sh
if [[ -d foo ]]; then
if test -d foo; then
```

`[[ ]]` notation provides more features than `test`. For example, `[[ ]]` supports `&&` and `||` operators, while `test` does not.

**`For`, `While` and `Until`**:

```sh
# Run baz for each foo in bar
for foo in bar; do baz; done

# e.g. Print all files in the current directory
for file in $(ls); do echo $file; done

# Run bar while foo succeeds
while foo; do bar; done

# e.g. Print "Hello" forever
until false; do echo "Hello"; done

# Run bar until foo succeeds
until foo; do bar; done

# e.g. Print "Hello" forever
until false; do echo "Hello"; done
```

**Case**: see the example:

```sh
case $fruit in
    apple)
        echo "It's an apple."
        ;;
    banana)
        echo "It's a banana."
        ;;
    orange|lemon) # "|" means "or"
        echo "It's an orange or a lemon."
        ;;
    *)
        echo "It's an unknown fruit."
        ;;
esac
```

**Functions**: use `foo() { bar; }` to define a function named `foo` that runs `bar`. Example:

```sh
multiply() {
    result=$(($1 * $2))
    echo "The result of multiplication is: $result"
}

# Call the function
multiply 5 3
```

### Others

**Shebang**: use `#!/bin/bash` to specify the interpreter of the script. The shebang must be the first line of the script. You can also choose python as the interpreter, e.g. `#!/usr/bin/env python`.

**Exit code**: use `exit 0` to exit with code `0`. Use `exit` to exit with the return code of the last command.

### Homework

> Write a command or script to recursively find the most recently modified file in a directory. More generally, can you list all files by recency?

Here is my implementation of the first part of the homework.

```sh
__check_modified() {
    local file
    file=$(ls -t "$1" | head -n1)

    while [[ -d "$1/$file" ]]; do
        file=$(ls -t "$1/$file" | head -n1)
    done

    echo "$1/$file"
}

__check_modified "$1"
```

---

## Data Wrangling

I don't know how to document this part, so I just note down some useful tools.

 - **`grep`**: search for a pattern in a file.
 - **`sed`**: stream editor.
 - **`awk`**: pattern scanning and processing language.
 - **`sort`**: sort lines of text files.
 - **`uniq`**: report or omit repeated lines.
 - **`paste`**: merge lines of files.
 - **`wc`**: print newline, word, and byte counts for each file.
 - **`tee`**: read from standard input and write to standard output and files.
 - **`tr`**: translate or delete characters.
 - **`less`**: open a file for interactive reading.
 - **`head`**: output the first part of files.
 - **`tail`**: output the last part of files.
 - **`xargs`**: build and execute command lines from standard input.
 - **`bc`**: arbitrary precision calculator language.
 - **`jq`**: command-line JSON processor.
 - **`pup`**: command line tool for processing HTML.

**One more thing**: Learning Regex can be incredibly useful. It's definitely worth investing time in it!

---

## Command-line Environment

### Job Control

When pressed `Ctrl-C`, the shell delivers a **SIGINT** SIGnal to the process, which *by default* INTerrupts the process.

This python program captures **SIGINT** and ignores it:

```python
import signal, time

def handler(signum, time):
    print("\nI got a SIGINT, but I am not stopping")

signal.signal(signal.SIGINT, handler)

# This program is a simple counter
i = 0
while True:
    time.sleep(.1)
    print("\r{}".format(i), end="")
    i += 1
```

When we run this program and press `Ctrl-C`, the program will continue to run. To stop it, we need to send a **SIGQUIT** signal to it, by typing `Ctrl-\`.

```sh
$ python sigint.py
16^C
I got a SIGINT, but I am not stopping
25^C
I got a SIGINT, but I am not stopping
45^\[1]    54634 quit       python sigint.py
```

Note that **SIGINT** and **SIGQUIT** can both be captured by the program. However, **SIGTERM** cannot. It is a more graceful way to TERMinate the process. To send the signal we can use `kill -TERM <PID>` or `kill <PID>` for short.

`Ctrl-Z` is used to suspend a process. It sends a **SIGTSTP** signal, short for "terminal stop". When a process is suspended, it pauses.

Command `jobs` lists the unfinished jobs associated with the current terminal session. For example, if I suspended the `sigint.py` program above:

```sh
$ python sigint.py
25^Z
[1]  + 56852 suspended  python sigint.py
$ jobs
[1]  + suspended  python sigint.py
```

Then we can use `fg` to bring the job to the foreground, and `bg` to the background.

```sh
$ fg %1      # %1 means it is the first job
[1]  + 56852 continued  python sigint.py
75           # Number counting continues
```

By using the `&` suffix, a command runs in the background but still prints to the terminal.

To background a program we can use `Ctrl-Z` and `bg`, but note that the process will die if you close the terminal. To prevent this, we can use `nohup` to run the program in the background, it sets the process to ignores **SIGHUP** signal, which is sent to a process when the terminal session ends.

```sh
$ nohup python sigint.py &
```

To get a comprehensive list of signals, check `man signal`.

### Terminal Multiplexers

**Under Construction**