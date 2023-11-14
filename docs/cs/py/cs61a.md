# CS61A: Structure and Interpretation of Computer Programs

**🔮 COURSE-FINISHED-AT**: Nope, haven't finished yet.

**🔗 COURSE-SITE**: [inst.eecs.berkeley.edu/~cs61a/su20](https://inst.eecs.berkeley.edu/~cs61a/su20/)

---

## Higher-Order Functions

The homework [HW 02 Q4: Church numerals](https://inst.eecs.berkeley.edu/~cs61a/su20/hw/hw02/#q4) introduced a very interesting concept called *Church numerals*. I'd like to note it down.

> The logician Alonzo Church invented a system of representing non-negative integers entirely using functions. The purpose was to show that functions are sufficient to describe all of number theory: if we have functions, we do not need to assume that numbers exist, but instead we can invent them.

Using $\lambda$-functions in python, we have the following definitions:

```py
def zero(f):
    return lambda x: x

def successor(n): # n is a church numeral
    return lambda f: lambda x: f(n(f)(x))
```

Both `zero(f)` and `successor(n)` are *higher-order functions*, they take functions as arguments and return functions as results.

The `successor(n)` function may look scary, but it's actually not. `n` is a function that takes `f` in and returns another function that takes `x` in. So `n` is technically the same as `lambda f: lambda x: n(f)(x)`. What `successor(n)` does is just to wrap another layer of `f` to `n`.

From the explanation above, we can see that the number of `f` is simply the corresponding integer. Rather than defining `one(f)` as `successor(zero)` and `two(f)` as `successor(one)`, we can also use:

```py
def one(f):
    return lambda x: f(x)

def two(f):
    return lambda x: f(f(x))
```

Then it's easy to implement `church_to_int(n)` function:

```py
def church_to_int(n):
    return n(lambda x: x + 1)(0)
```

Let's examine how to add two Church numerals together. For example, by adding `two(f)(x) = f(f(x))` and `one(f)(x) = f(x)` together, we should get `three(f)(x) = f(f(f(x)))`. The answer is to take `one` and plug it into `x` of `two(f)(x)`: `two(f)(one(f)(x))`. The code would be:

```py
def add_church(m, n):
    return lambda f: lambda x: m(f)(n(f)(x))
```

Then we try multiplication. The idea is to plug `n` into `f` of `m(f)(x)`.

```py
def mul_church(m, n):
    return lambda f: lambda x: m(n(f))(x)
```
The most challenging task is to implement power. Here is the answer. You can verify this by plugging in some numbers.

```py
def pow_church(m, n):
    return lambda f: lambda x: n(m)(f)(x)
```

---

**Under Construction**