# CS61A: Structure and Interpretation of Computer Programs

**📖 COURSE-STARTED-AT**: 2023-11-14

**🔮 COURSE-FINISHED-AT**: Nope, haven't finished yet.

**🔗 COURSE-SITE**: [inst.eecs.berkeley.edu/~cs61a/su20](https://inst.eecs.berkeley.edu/~cs61a/su20/)

---

## Higher-Order Functions

### HW 02 Q4: Church numerals

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

The `successor(n)` function may look scary, but it's actually pretty straight-forward. `n` is a function that takes `f` in and returns another function that takes `x` in. So `n` is technically the same as `lambda f: lambda x: n(f)(x)`. What `successor(n)` does is just to wrap another layer of `f` to `n`.

From the explanation above, we see that the number of `f`s is simply the corresponding integer. Rather than defining `one(f)` as `successor(zero)` and `two(f)` as `successor(one)`, we can also use:

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

The most challenging task is to implement power.

```py
def pow_church(m, n):
    return lambda f: lambda x: n(m)(f)(x)
```

You can verify this by plugging in some numbers.

---

### HW 03 Q6: Anonymous factorial

Another interesting quiz I found is [HW 03 Q6: Anonymous factorial](https://inst.eecs.berkeley.edu/~cs61a/su20/hw/hw03/#q6).

The recursive factorial function can be written as a single expression by using a conditional expression.

```py
fact = lambda n: 1 if n == 1 else n * fact(n - 1)
```

Note that this implementation relies on the *fact* that `fact` has a name. Is there a way to define `fact` recursively without giving it a name?

The task is to implement an anonymous function that computes the factorial of `n` using **only** call expressions, conditional expressions, and lambda expressions (no assignment or def statements). You may also use `-` and `*` operators.

How the non-anonymous factorial function works is that inside each layer of recursion, the function `fact` itself can always be called. Thus, we come up with the idea to **pass the function itself as an argument** to the function.

```py
def fact(f, n):
    return 1 if n == 1 else n * f(f, n - 1)

fact(fact, 5) # 120
```

So the answer would be:

```py
fact = (lambda f: lambda x: f(f, x))(lambda f, x: 1 if x == 1 else x * f(f, x - 1))
```

The logic behind this quiz is something called *Y Combinator*. Y Combinator is a method to turn a non-anonymous recursive function into an anonymous one. Here's one example (by GitHub Copilot):

```py
def Y(f):
    return (lambda x: f(lambda y: x(x)(y)))(lambda x: f(lambda y: x(x)(y)))

fact = Y(lambda f: lambda n: 1 if n == 0 else n * f(n - 1))

fact(5)  # 120
```

I won't dig into Y Combinator here. (Maybe elsewhere)

---

## Data Abstraction

The way to implement data abstraction in python is way easier than in C++. Here's an example to construct a tree (which is actually nested lists):

```py
def tree(label, branches = []):
    for branch in branches:
        assert is_tree(branch)
    return [label] + list(branches)

def label(tree):
    return tree[0]

def branches(tree):
    return tree[1:]

def is_tree(tree):
    if type(tree) != list or len(tree) < 1:
        return False
    for branch in branches(tree):
        if not is_tree(branch):
            return False
    return True

def is_leaf(tree):
    return not branches(tree)
```

To construct a Fibonacci tree, we simply use:

```py
def fib_tree(n):
    if n == 0 or n == 1:
        return tree(n)

    left = fib_tree(n - 2)
    right = fib_tree(n - 1)
    fib_n = label(left) + label(right)
    return tree(fib_n, [left, right])
```

That's it. A newly-baked Fibonacci tree, in a few lines. (I'm lovin' python)

---

## Mutation

Here's a piece of code, pay attention how `a` behaves.

```py
>>> a = [1, 2]
>>> b = a
>>> b.append(3)
>>> b
[1, 2, 3]
>>> a
[1, 2, 3]
```

You may expect `a` to be `[1, 2]`, but it's not. The reason is that `a` and `b` are both *names* that refer to the same *object*. When we call `b.append(3)`, we are actually ***mutating*** the object that `a` refers to. Thus, `a` is also changed.

Using mutations, we can do some magic:

```py
>>> def magic(x):
...     x[0] = 1
...
>>> a = [0, 2]
>>> magic(a)
>>> a
[1, 2]
```

The `magic` function above behaves pretty C-ish, compare it with the following C code:

```c
void magic(int x[]) {
    x[0] = 1;
}

int main() {
    int a[] = {0, 2};
    magic(a);
    printf("{%d, %d}", a[0], a[1]); // {1, 2}
}
```

In python, types are classified into two categories:

 - Mutable types: `list`, `dict`, `set`, `bytearray`, etc.
 - Immutable types: `int`, `float`, `bool`, `str`, `tuple`, `frozenset`, `bytes`, etc.

Note that `tuple` is immutable, but it *can* contain mutable objects.

```py
>>> a = ([], 2)
>>> b = a
>>> a[0].append(1)
>>> a
([1], 2)
>>> b
([1], 2)
```

`is` operator can be used to check whether two names refer to the same object. And `==` checks whether two objects are equal.

```py
>>> a = [1, 2, 3]
>>> b = [1, 2, 3]
>>> c = a
>>> a == b  # True
>>> a == c  # True
>>> a is b  # False
>>> a is c  # True
```

In this case, `a` and `b` are two different objects that *happened* to hold the same value, while `a` and `c` are literally the same object.

Mutable objects can be used as dictionary keys, but immutable objects cannot.

```py
>>> a = {[1, 2]: 0}  # TypeError: unhashable type: 'list'
>>> a = {(1, 2): 0}  # No error
```

Mutable default arguments are dangerous. Consider the following code:

```py
>>> def f(x = []):
...     x.append(0)
...     return x
...
>>> f()
[0]
>>> f()
[0, 0]
>>> f()
[0, 0, 0]
```

The default argument `x = []` is evaluated only once, when the function is defined. Thus, every time we call `f()`, we are actually appending `0` to the same list.

---

## Nonlocal

The `nonlocal` statement is used to indicate that a variable is defined in the parent's local scope. Consider the following code:

```py
>>> n = 1
>>> def f():
...     n += 1
...     return n
...
>>> f()  # UnboundLocalError
```

The error is caused by the fact that `n` is not defined in the local scope of `f`. To fix this, we use `nonlocal`:

```py
>>> n = 1
>>> def f():
...     nonlocal n
...     n += 1
...     return n
...
>>> f()
>>> n
2
```

Such statement is very useful for implementing *closures*.

```py
>>> def make_inc(n):
...     def inc(k):
...         nonlocal n
...         n += k
...         return n
...     return inc
...
>>> inc = make_inc(0)
>>> inc(10)
10
>>> inc(10)
20
>>> inc(10)
30
```

---

## Iterators & Generators

### Iterators

`iter` function takes an *iterable* object and returns an *iterator*. `next` function takes an iterator and returns the next item in the iterable object. When there's no more item, `next` raises a `StopIteration` exception.

```py
>>> t = iter([1, 2])
>>> s = t
>>> next(t)
1
>>> next(s)  # Iterators are mutable. 
2
>>> next(t)  # StopIteration
```

Some built-in functions like `map`, `filter`, `zip` return iterators.

```py
>>> t = map(lambda x: x ** 2, [1, 2, 3])
>>> next(t)
1
>>> next(t)
4
>>> next(t)
9
>>> next(t)  # StopIteration
```

Note that such functions are *lazy*, they don't compute the whole list at once. Instead, they compute the next item only when it's needed.

```py
>>> def check(x):
...     print("Checking", x)
...     return x * x >= 10
...
>>> t = filter(check, range(6))  # No output yet
>>> next(t)
Checking 0
Checking 1
Checking 2
Checking 3
Checking 4
4
>>> next(t)
Checking 5
5
>>> next(t)  # StopIteration
```

---

### Generators

A *generator* is a function that returns an *iterator*. It looks like a normal function, but it contains `yield` statements.

```py
>>> def naturals():
...     n = 0
...     while True:
...         yield n
...         n += 1
...
>>> t = naturals()
>>> next(t)
0
>>> next(t)
1
>>> next(t)
2
```

Generators are also *lazy*. This is why `naturals` doesn't run into an infinite loop.

`yield from` is another special syntax that allows a generator to yield all values from another generator. You can consider it a syntax sugar for nested loops. For example,

```py
yield from t
```

is equivalent to:

```py
for x in t:
    yield x
```

### HW 05 Q6: Remainder Generator

The homework [HW 05 Q6: Remainder Generator](https://inst.eecs.berkeley.edu/~cs61a/su20/hw/hw05/#q6) asks us to implement `remainders_generator`. This is an easy task but it helps to understand iterators and generators.

> `remainders_generator` takes in an integer `m`, and yields `m` different generators. The first generator is a generator of multiples of `m`, i.e. numbers where the remainder is 0. The second is a generator of natural numbers with remainder 1 when divided by `m`. The last generator yields natural numbers with remainder `m - 1` when divided by `m`.

In short, `remainders_generator` yields all the congruence classes of `m`.

For instance, `remainders_generator(4)` should yield:

```py
>>> for r in remainders_generator(4):
...     print([next(r) for _ in range(5)])
... 
[4, 8, 12, 16, 20]
[1, 5, 9, 13, 17]
[2, 6, 10, 14, 18]
[3, 7, 11, 15, 19]
```

Here is my implementation:

```py
def remainders_generator(m):
    def remainder(r):
        if r == 0: r += m
        while True:
            yield r
            r += m
    for r in range(m):
        yield remainder(r)
```

---

## Scheme

Scheme is a dialect of Lisp. For the syntax and language features, refer to [Scheme](../lisp/scheme.md) notes.

The task is to build a Scheme interpreter, in python. I won't go into details here, but I'd like to note down some important parts.

Interpreting a piece of code follows the following procedures:

1. Input
2. Tokenize
3. Parse
4. Evaluate
5. Print

```py
Input = '(even? (* (+ 1 2) 3 4))'
Token = ['(', 'even?', '(', '*', '(', '+', '1', '2', ')', '3', '4', ')', ')']
Parsed = CallExpr(Name('even?'),
             [CallExpr(Name('*'),
                 [CallExpr(Name('+'),
                     [Literal(1), Literal(2)]),
                 Literal(3), Literal(4)])])
Evaluation = True
Print = '#t'
```

Another thing to mention is that Scheme also have environment frames. When evaluating an expression, the current environment frame should be passed to the `eval` function.

---

## SQL

SQL is pronounced as "sequel".

**Under Construction**