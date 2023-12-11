# Y Combinator

The **Y Combinator** is a way to implement anonymous recursion in lambda calculus.

## Lead-in

We can easily define a `fact` function that computes the factorial of a number in python:

```py
fact = lambda n: 1 if n == 0 else n * fact(n - 1)
```

We've used `lambda` in python, but it is, actually, not lambda calculus.

You may think our lambda-calculus-version `fact` is something like this:

$$\mathbf{fact} := \lambda n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{fact}(n - 1)$$

However, this is not a valid lambda expression. The reason is that we cannot refer to $\mathbf{fact}$ itself in its own definition. Giving a name to a lambda expression is a *syntax sugar* and we should replace the name with the expression every time we use it. However, in this implementation, if we replace $\mathbf{fact}$ with its definition, we get an infinite expression, which is not well-defined.

---

## Another attempt

The issue arises because lambda expressions are *anonymous*, preventing us from directly referencing the expression itself. What if we were to pass the expression as an argument instead?

$$\mathbf{fact} := \lambda\ \mathbf{self}\ n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{self}(\mathbf{self}, n - 1)$$

We tried to pass $\mathbf{fact}$ itself as an argument explicitly. For example, by evaluating $\mathbf{fact}(\mathbf{fact}, 5)$ we get the factorial of $5$. This implementation does not rely on the name $\mathbf{fact}$ anymore, and we can safely expand the syntax sugar without worrying getting infinite long, so this is a valid lambda expression.

Unfortunately, each time we want to calculate the factorial of a number, we have to pass the expression itself as an argument. This seems absurd and goes against our desired approach.

But with this approach, we can continue moving forward towards the final solution.

---

## Dig deeper

Let's examine our last implementation again.

$$\mathbf{fact} := \lambda\ \mathbf{self}\ n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{self}(\mathbf{self}, n - 1)$$

It looks ugly. I mean, the two $\mathbf{self}$s in $\mathbf{self}(\mathbf{self}, n - 1)$ violates the holy principle of Don't-Repeat-Yourself (DRY). Let's try to get rid of one of them.

$$\mathbf{fact} := \lambda\ \mathbf{self}\ n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{self}(n - 1)$$

Apparently $\mathbf{fact}(\mathbf{fact}, 5)$ will no longer work. We need to pass a different argument: $\mathbf{fact}(\mathbf{?}, 5)$. What should we pass?

Let's suppose we already have a well-defined $\mathbf{fact_Real}$ function that is both anonymous and recursive. What if we pass $\mathbf{fact_Real}$ as $\mathbf{self}$ in that $\mathbf{fact}$ function?

$$\mathbf{fact}(\mathbf{fact_Real}) = \lambda\ n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{fact_Real}(n - 1)$$

Without too much surprise we find that the right-hand side of the equation actually equals the value of $\mathbf{fact_Real}$ itself. So we have:

$$\mathbf{fact}(\mathbf{fact_Real}) = \mathbf{fact_Real}$$

Such function $\mathbf{fact_Real}$ is called a **fixed point** of $\mathbf{fact}$. So our goal is to find such fixed point.

---

## Y Combinator

Is there a function $\mathbf{Y}$, that takes a function $f$ and returns the fixed point of $f$?

We achieve this by defining a helper function $\mathbf{helper}$:

$$\mathbf{helper} := \lambda f.\mathbf{fact}(f(f))$$

Let's see what $\mathbf{helper}(\mathbf{helper})$ is:

$$\mathbf{helper}(\mathbf{helper}) = \mathbf{fact}(\mathbf{helper}(\mathbf{helper}))$$

It is a fixed point of $\mathbf{fact}$! So we have:

$$
\begin{aligned}
\mathbf{fact_Real} &= \mathbf{helper}(\mathbf{helper}) \\
&= (\lambda f.\mathbf{fact}(f(f)))(\mathbf{helper}) \\
&= (\lambda f.\mathbf{fact}(f(f)))(\lambda f.\mathbf{fact}(f(f)))
\end{aligned}
$$

Well, that's it, $(\lambda f.\mathbf{fact}(f(f)))(\lambda f.\mathbf{fact}(f(f)))$ is our desired anonymous recursive factorial function.

Function $\mathbf{Y}$ would be:

$$
\begin{aligned}
\mathbf{Y} :=& \lambda f.\mathbf{helper}_f(\mathbf{helper}_f) \\
=& \lambda f.(\lambda g.f(g(g)))(\lambda g.f(g(g))) \\
=& \lambda f.(\lambda x.f(x\ x))(\lambda x.f(x\ x))
\end{aligned}
$$

$\mathbf{Y} = \lambda f.(\lambda x.f(x\ x))(\lambda x.f(x\ x))$ is our universal definition.

---

## Implementation

We can implement the Y Combinator in python:

```py
Y = lambda f: (lambda x: f(lambda y: x(x)(y)))(lambda x: f(lambda y: x(x)(y)))
```

Note that the expression `lambda y: x(x)(y)` cannot be replaced with `x(x)` due to Python's eager evaluation. If we were to use `x(x)`, the function `x` would be evaluated immediately, leading to an infinite recursion.

Then we can define the factorial function:

```py
fact = Y(lambda f: lambda n: 1 if n == 0 else n * f(n - 1))
print(fact(5))  # 120
```

That sounds good!