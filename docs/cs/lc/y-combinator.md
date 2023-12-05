# Y Combinator

The **Y Combinator** is a way to implement anonymous recursion in lambda calculus.

## Lead-in

We can easily define a `fact` function that computes the factorial of a number in python:

```py
fact = lambda n: 1 if n == 0 else n * fact(n - 1)
```

We used `lambda` in python, but it is, actually, not lambda calculus.

You may think our lambda-calculus-version `fact` is like this:

$$\mathbf{fact} := \lambda n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{fact}(n - 1)$$

However, this is not a valid lambda expression. The reason is that we cannot refer to $\mathbf{fact}$ itself in its own definition. Giving a name to a lambda expression is a *syntax sugar* and every time we use it, we should replace the name with the expression. In this implementation, if we replace $\mathbf{fact}$ with its definition, we get an infinite expression, which does not make sense.

We cannot even define a simple recursive function in lambda calculus! That sounds horrible. But luckily, we have solutions.

---

## Another attempt

The problem occurs because we can't refer to the expression itself in a lambda expression (that is, lambda expressions are anonymous). What if we pass the expression as an argument?

$$\mathbf{fact} := \lambda\ \mathbf{self}\ n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{self}(\mathbf{self}, n - 1)$$

We tried to pass $\mathbf{fact}$ itself as an argument explicitly. To calculate the factorial of $5$, we have to use $\mathbf{fact}(\mathbf{fact}, 5)$. This implementation does not rely on the name $\mathbf{fact}$ anymore, so this is a valid lambda expression.

Hold on, we encountered another trouble! Every time we want to calculate the factorial of a number, we have to pass the expression itself as an argument. It sounds ridiculous and that is not what we wish.

But with this attempt, we can forge ahead to the final solution.

---

## Dig deeper

Let's examine our last implementation again.

$$\mathbf{fact} := \lambda\ \mathbf{self}\ n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{self}(\mathbf{self}, n - 1)$$

It looks ugly. I mean, the two $\mathbf{self}$s in $\mathbf{self}(\mathbf{self}, n - 1)$ violates the principle of Don't-Repeat-Yourself. Let's try to get rid of one of them.

$$\mathbf{fact} := \lambda\ \mathbf{self}\ n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{self}(n - 1)$$

Apparently $\mathbf{fact}(\mathbf{fact}, 5)$ will no longer work. We need to pass a different argument: $\mathbf{fact}(\mathbf{?}, 5)$. What should we pass?

Let's suppose we already have a well-defined $\mathbf{fact_Real}$ function that is anonymous and recursive. That is, $\mathbf{fact_Real}$ is a valid lambda expression, and it doesn't require an extra $\mathbf{self}$ argument.

What if we pass $\mathbf{fact_Real}$ as $\mathbf{self}$ in that $\mathbf{fact}$ function?

$$\mathbf{fact}(\mathbf{fact_Real}) = \lambda\ n.1\ \mathbf{if}\ n = 0\ \mathbf{else}\ n\times\mathbf{fact_Real}(n - 1)$$

What's that? It's $\mathbf{fact_Real}$ itself! So we have:

$$\mathbf{fact}(\mathbf{fact_Real}) = \mathbf{fact_Real}$$

Such function $\mathbf{fact_Real}$ is called a **fixed point** of $\mathbf{fact}$.

We still haven't finished yet, but we are close.

---

## Y Combinator

Is there a function $\mathbf{Y}$, that takes a function $f$ and returns the fixed point of $f$?

We achieve this by defining a helper function $\mathbf{helper}$:

$$\mathbf{helper} := \lambda f.\mathbf{fact}(f(f))$$

Let's see what is $\mathbf{helper}(\mathbf{helper})$:

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

So function $Y$ would be:

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

Note that `lambda y: x(x)(y)` cannot be replaced with `x(x)`, because python does eager evaluation. If we use `x(x)`, `x` will be evaluated immediately, which will cause an infinite recursion.

Then we can define the factorial function:

```py
fact = Y(lambda f: lambda n: 1 if n == 0 else n * f(n - 1))
print(fact(5))  # 120
```

That sounds good!