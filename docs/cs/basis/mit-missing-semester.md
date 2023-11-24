# MIT Missing Semester

**🔮 COURSE-FINISHED-AT**: 2023-11-11

**🔗 COURSE-SITE**: [missing.csail.mit.edu](https://missing.csail.mit.edu/)

---

MIT Missing Semester is a course that teaches the *untaught* parts of computer science.

> Classes teach you all about advanced topics within CS, from operating systems to machine learning, but there’s one critical subject that’s rarely covered, and is instead left to students to figure out on their own: **proficiency with their tools**. We’ll teach you how to master the command-line, use a powerful text editor, use fancy features of version control systems, and much more!
> 
> <div align=right>——MIT Missing Semester</div>

For the parts I'm already familiar with, I skip them.

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
while true; do echo "Hello"; done

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
 - **`tac`**: reverse `cat`.
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

Refer to [Tmux](https://github.com/tmux/tmux/wiki).

Here is a tutorial: [A Quick and Easy Guide to tmux](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/).

---

## Version Control (Git)

Here I list some useful commands that I'm not familiar with. I won't dig into that too much.

```sh
$ git log --all --graph --decorate
$ git clone --shallow
$ git fetch
$ git stash
$ git stash pop
```

---

## Metaprogramming

Here is an example of a simple Makefile that compiles a LaTeX document.

```makefile
paper.pdf: paper.tex plot-data.png
	pdflatex paper.tex

plot-%.png: %.dat plot.py
	./plot.py -i $*.dat -o $@
```

---

## Security and Cryptography

### Cryptographic hash function

**Cryptographic hash functions** map an arbitrary length input to a fixed-length output. The general model is

```
hash(value: array<byte>) -> vector<byte, N>  (for some fixed N)
```

It has the following properties:

 - **Deterministic**: the same input maps to the same output.
 - **Non-invertible**: it is *hard* to find an input m such that `hash(m) = h` for some desired output `h`.
 - **Target collision resistant**: given an input `m1`, it’s *hard* to find a different input `m2` such that `hash(m1) = hash(m2)`.
 - **Collision resistant**: it’s *hard* to find two inputs `m1` and `m2` such that `hash(m1) = hash(m2)` (this is a strictly stronger property than target collision resistance).

Note that it is *hard* to find a collision, but it is not completely *impossible*. This is why each cryptographic hash function has a [lifespan](https://valerieaurora.org/hash.html).

A widely used cryptographic hash function is **SHA-1**. For example, Git uses SHA-1 to identify commits. But it is [not secure anymore](https://security.googleblog.com/2017/02/announcing-first-sha1-collision.html). To generate an SHA-1 hash, we can use the `shasum` command on macOS.

```sh
$ echo "hello, world" | shasum -a 1
cd50d19784897085a8d0e3e413f8612b097c03f1  -
```

Imagine we're playing a number-guessing game. I've thought of a random number, and you're trying to guess it. You need to share your guess before I reveal if it's correct.

Now, to ensure I don't cheat by altering the number in my mind, we can employ a cryptographic hash function. Before you make your guess, I'll share the hash of my number. After the game, you can verify that I haven't tampered with the chosen number by checking the hash of your guessed number.

### Key derivation function

**Key derivation functions**, or **KDFs**, share similarities with cryptographic hash functions, but they are specifically designed for deriving secret keys from a given input, typically a password or a low-entropy key. KDFs are intentionally designed to operate at a *slow* pace, making it time-consuming to brute-force the password.

**Applications**:

 - Producing keys from passphrases for use in other cryptographic algorithms (e.g. symmetric cryptography).
 - Storing login credentials. Storing plaintext passwords is bad; the right approach is to generate and store a random [salt](https://en.wikipedia.org/wiki/Salt_(cryptography)) `salt = random()` for each user, store `KDF(password + salt)`, and verify login attempts by re-computing the KDF given the entered password and the stored salt.

### Symmetric cryptography

**Symmetric cryptography** is used to encrypt and decrypt data. It uses a **secret key** to encrypt and decrypt data. The same key is used for both encryption and decryption. The model is

```
keygen() -> key  (this function is randomized)

encrypt(plaintext: array<byte>, key) -> array<byte>  (the ciphertext)
decrypt(ciphertext: array<byte>, key) -> array<byte>  (the plaintext)
```

An example of a symmetric cryptosystem in wide use today is AES.

### Asymmetric cryptography

Except for encrypting and decrypting data, **asymmetric cryptography** can also be used to sign and verify data. It uses a **public key** and a **private key**. The public key is used to encrypt data and verify signatures, while the private key is used to decrypt data and sign data. The model is

```
keygen() -> (public-key, private-key)  (this function is randomized)

encrypt(plaintext: array<byte>, public-key) -> array<byte>  (the ciphertext)
decrypt(ciphertext: array<byte>, private-key) -> array<byte>  (the plaintext)

sign(message: array<byte>, private-key) -> array<byte>  (the signature)
verify(message: array<byte>, signature: array<byte>, public-key) -> bool  (whether or not the signature is valid)
```

As its name suggests, public key *can* be made public. Anyone can use the public key to encrypt data *for you*, but only you, with the corresponding private key, can decrypt it. That's how private messaging apps like Telegram works.

On the flip side, you can sign data using your private key. Others can then verify the signature using your public key. This mechanism is exemplified in practices such as verifying commits in Git through digital signatures.
