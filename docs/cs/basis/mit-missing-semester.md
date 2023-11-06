# MIT Missing Semester

[MIT Missing Semester](https://missing.csail.mit.edu/) is a course that teaches the *un-taught* parts of computer science.

> Classes teach you all about advanced topics within CS, from operating systems to machine learning, but there’s one critical subject that’s rarely covered, and is instead left to students to figure out on their own: **proficiency with their tools**. We’ll teach you how to master the command-line, use a powerful text editor, use fancy features of version control systems, and much more!
> 
> <div align=right>——MIT Missing Semester</div>

---

## Shell Scripting

### Variables

**To define a variable**: use `#!sh foo=bar` instead of `#!sh foo = bar`. The latter tries to run a command named `foo` with arguments `=` and `bar`.

**To use a variable**: use `#!sh $foo`.

**Special variables**: (take `#!sh ./script.sh foo bar` as an example)

 - **`#!sh $0`**: `./script.sh`, name of the script.
 - **`#!sh $1` to `#!sh $9`**: `foo` to `bar`, arguments to the script.
 - **`#!sh $@`**: `foo bar`, all arguments.
 - **`#!sh $#`**: `2`, number of arguments.
 - **`#!sh $?`**: Return code of the previous command.
 - **`#!sh $$`**: PID of the current script.
 - **`#!sh $_`**: Last argument of the last command.

### Operators

**Operator `||`, `&&` and `;`**:

 - **`#!sh foo || bar`** means "run `foo`, if it fails, run `bar`".
 - **`#!sh foo && bar`** means "run `foo`, if it succeeds, run `bar`".
 - **`#!sh foo ; bar`** means "run `foo`, then run `bar`".

Example:

```sh
false || echo "Oops, fail"           # Oops, fail
true || echo "Will not be printed"   #
true && echo "Things went well"      # Things went well
false && echo "Will not be printed"  #
true ; echo "This will always run"   # This will always run
false ; echo "This will always run"  # This will always run
```

**Command substitution**: use `#!sh $(foo)` to run `foo` and use its output as a string. Example: `#!sh for file in $(ls)` iterates over all files.

**Process substitution**: `#!sh <(foo)` will run `foo` and place the output in a temporary file and substitute the `#!sh <()` with that file’s name. Example: `#!sh diff <(ls foo) <(ls bar)` compares the files of directory `foo` and `bar`.

### Redirection

**Input**: use `<` to redirect input from a file.

**Output**: use `>` to redirect output to a file. Use `>>` to append to a file.

**Error**: use `2>` to redirect error to a file.

**Both output and error**: use `&>` to redirect both output and error to a file.

**Both input and output**: use `<>` to redirect both input and output to a file.

**Discard**: redirect to `/dev/null` to discard output/error/input.

**Pipe**: use `|` to pipe the output of a command to the input of another command.

### Control Flow

**Under Construction**