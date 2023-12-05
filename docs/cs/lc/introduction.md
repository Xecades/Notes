# Introduction

> **Lambda calculus** (also written as **$\lambda$-calculus**) is a formal system in mathematical logic for expressing computation based on function abstraction and application using variable binding and substitution. It is a universal model of computation that can be used to simulate any Turing machine. It was introduced by the mathematician Alonzo Church in the 1930s as part of his research into the foundations of mathematics.
>
> <div align=right>——Wikipedia</div>

---

## Terms

### Definition

The basic building blocks of lambda calculus are **terms**. A term is either a **variable**, an **abstraction**, or an **application**.

1. $x$. A **variable** is a symbol that represents a value.
2. $(\lambda x.M)$. An **abstraction** is a function that takes **ONE** variable $x$ and returns a term $M$. Variables and term are separated by a dot.
3. $(M\ N)$. An **application** applies a term $M$ to another term $N$.

For example, $(\lambda x.(\mathbf{sqrt}\ x))$ is an abstraction that takes a variable $x$ and returns the term $(\mathbf{sqrt}\ x)$, which is an application of the function $\mathbf{sqrt}$ to the variables $x$.

Note that $(\mathbf{sqrt}\ x)$ is equivalent to $\sqrt{x}$ in mathematics. Actually, we have to define the function $\mathbf{sqrt}$ first. We just suppose it exists for now.

If you are familiar with [Scheme](../lisp/scheme.md), you may find that the lambda expression $(\lambda x.(\mathbf{sqrt}\ x))$ is very similar to the Scheme expression `(lambda (x) (sqrt x))`. In fact, Scheme is built on lambda calculus. Now you may understand why normal arithmetic operations in Scheme are prefix notations (`+ 1 2`) instead of infix notations (`1 + 2`) — `+` is just a function, it has nothing different from other functions like `cdr` or `list`.

> For the wellness of your eyes, sometimes I will use infix notations and common math as an informal representation of lambda expressions. For example, $(\lambda x.(\mathbf{add}\ x\ y))$ is written as $(\lambda x.(x + y))$. Just don't forget $+$ is a function.

---

### Syntax sugar

Writing a long lambda expression is tedious. We can use the following *syntax sugar* to simplify it.

1. $(\lambda x_1\ x_2\ \cdots\ x_n.M)$ is equivalent to $(\lambda x_1.(\lambda x_2.(\cdots(\lambda x_n.M)\cdots)))$.
2. $(M\ N_1\ N_2\ \cdots\ N_n)$ is equivalent to $((\cdots((M\ N_1)\ N_2)\cdots)\ N_n)$.

Parentheses can be omitted if they are not necessary. For example, $(\lambda x.(f\ x))$ is equivalent to $\lambda x.f\ x$.

---

### Partial evaluation

Consider the function $\mathbf{add}$ (We haven't defined it yet, but just suppose it exists). It is apparent that $(\mathbf{add}\ 1\ 2)$ gives us $3$, but what about $(\mathbf{add}\ 1)$? Well, it is a function that takes a number $x$ and returns $x+1$. In other words, $(\mathbf{add}\ 1)=(\lambda x.(\mathbf{add}\ 1\ x))$.

By not giving all the arguments to a function, we can get a new function with some arguments already applied. This is called **partial evaluation**.

---

## Reduction

The meaning of lambda expressions is defined by how expressions can be reduced. There are three kinds of reduction: **$\alpha$-conversion**, **$\beta$-reduction**, and **$\eta$-conversion**.

 - **$\alpha$-conversion**: Rename the bound variables in an abstraction. $(\lambda x.f\ x)$ and $(\lambda y.f\ y)$ are equivalent.
 - **$\beta$-reduction**: Apply a function to an argument. For example, $((\lambda x.x)\ y)$ reduces to $y$.
 - **$\eta$-conversion**: Remove redundant abstractions. $(\lambda x.f\ x)$ is equivalent to $f$ if $x$ is not used in $f$.

For example:

$$
\begin{aligned}
&(\lambda f\ x.((f\ x)\ 1))(\mathbf{add})\\
=&\lambda x.((\mathbf{add}\ x)\ 1)\\
=&\lambda x.\mathbf{add}\ x\ 1\\
=&\lambda x.x + 1
\end{aligned}
$$

---

## Conditional expression

I'd like to mention that conditional expressions like `if` are nothing more than functions. We can define our own $\mathbf{if}$ function in lambda calculus:

$$
\begin{aligned}
\mathbf{TRUE} &:= \lambda x\ y.x \\
\mathbf{FALSE} &:= \lambda x\ y.y \\
\mathbf{if} &:= \lambda p.\lambda x.\lambda y.p\ x\ y
\end{aligned}
$$

Then $(\mathbf{if}\ p\ a\ b)$ represents the conditional expression `if p then a else b`.

It is easier than you think, isn't it?

Normally I'd like to use a python-ish syntax to represent lambda expressions. For example, I use $(a\ \mathbf{if}\ p\ \mathbf{else}\ b)$ instead of $(\mathbf{if}\ p\ a\ b)$.