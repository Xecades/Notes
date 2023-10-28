# Prove That...

Here are theorems and proofs that are essential in mathematical analysis. It would be nice if you could prove them smoothly.

## Set

1. (*De Morgan's laws*)
    - $(A \cup B)^C = A^C \cap B^C$
    - $(A \cap B)^C = A^C \cup B^C$
2. Any countable union of countable sets is a countable set.

---

## Limit of a sequence

1. Prove with definition: $\lim\limits_{n\to\infty}{\sqrt[n]{n}} = 1$.
2. If $\lim\limits_{n\to\infty}{a_n} = a$, then $\lim\limits_{n\to\infty}{\dfrac{a_1+a_2+\cdots+a_n}{n}} = a$.
3. For convergent sequences $\{x_n\}$ and $\{y_n\}$, if $\lim\limits_{n\to\infty}x_n=a$, $\lim\limits_{n\to\infty}y_n=b$, and $a<b$, then exists $N\in\mathbb{N}^\star$ so that $x_n<y_n$ for all $n>N$.
4. If $\lim\limits_{n\to\infty}x_n=a$, $\lim\limits_{n\to\infty}y_n=b\neq0$, then $\lim\limits_{n\to\infty}\dfrac{x_n}{y_n}=\dfrac{a}{b}$.
5. $a_n = \left(1 + \dfrac{1}{n}\right)^n$ and $b_n = \left(1 + \dfrac{1}{n}\right)^{n + 1}$ converges to $e$.
6. $a_n = 1 + \dfrac{1}{1!} + \dfrac{1}{2!} + \cdots + \dfrac{1}{n!}$ converges to $e$.
7. $a_n = 1 + \dfrac{1}{2} + \dfrac{1}{3} + \cdots + \dfrac{1}{n} - \ln n$ converges to $\gamma$.
8. $\lim\limits_{n\to\infty}a_n=A\iff\lim\limits_{n\to\infty}a_{2n-1}=\lim\limits_{n\to\infty}a_{2n}=A$.
9.  $\{a_n\}$ is convergent $\iff$ every non-trivial subsequence $\{a_{n_k}\}$ of $\{a_n\}$ converges.
10. $a_n = \sin n$ is divergent.
11. Prove with *Nested interval theorem*: $\mathbb{R}$ is uncountable.
12. Refer to [Completeness of the Real Numbers](completeness-of-real-numbers.md), and prove
    1. *Least upper bound* $\Rightarrow$ *Monotone convergence*.
    2. *Monotone convergence* $\Rightarrow$ *Nested interval*.
    3. *Nested interval* $\Rightarrow$ *Bolzano-Weierstrass*.
    4. *Bolzano-Weierstrass* $\Rightarrow$ *Cauchy criterion*.
    5. *Cauchy criterion* $\Rightarrow$ *Least upper bound*.
    6. *Cauchy criterion* $\Rightarrow$ *Nested interval*.
    7. *Nested interval* $\Rightarrow$ *Least upper bound*.

---

## Limit of a function

1. If $\lim\limits_{x\to a}f(x)=A$, $\lim\limits_{x\to a}g(x)=B$ and $A>B$, then exists $\delta>0$ so that $f(x)>g(x)$ for all $x\in\mathring{U}(x_0, \delta)$.
2. If $\lim\limits_{x\to x_0}f(x)=A$, then exists $\delta>0$ so that $f(x)$ is bounded in $\mathring{U}(x_0, \delta)$.
3. Prove with definition: $\lim\limits_{x\to0}\dfrac{\sin x}{x} = 1$.
4. (*Heine's theorem*) The necessary and sufficient condition for $\lim\limits_{x\to a}f(x)=A$ is that for all sequences $\{x_n\}$ which converges to $a$ and $x_n\neq a$ for all $n\in\mathbb{N}^\star$, $\lim\limits_{n\to\infty}f(x_n)=A$.
5. Prove with *Heine's theorem*: $f(x)=\sin\dfrac{1}{x}$ has no limit as $x\to0$.
6. (*Cauchy criterion*) Prove with *Heine's theorem*: $\lim\limits_{x\to a}f(x)=A$ if and only if for all $\varepsilon>0$, exists $\delta>0$ so that $|f(x)-f(y)|<\varepsilon$ for all $x,y\in\mathring{U}(x_0, \delta)$.
7. Prove with definition: $\lim\limits_{x\to\infty}\left(1+\dfrac{1}{x}\right)^x=e$.

---

## Continuity

1. Every irrational point of $R(x)$ is continuous, every rational point of $R(x)$ is removable discontinuous, where
> $$R(x)=\left\{\begin{align}\frac{1}{q}&\quad \text{if}\ x=\frac{p}{q}\text{, with}\ p\in\mathbb{Z}\ \text{and}\ q\in\mathbb{N}\ \text{coprime.}\\0&\quad \text{if}\ x\ \text{is irrational.}\end{align}\right.$$
2. If $u=g(x)$ is continuous at $x_0$, and $y=f(u)$ is continuous at $u_0=g(x_0)$, then $f\circ g(x)=f(g(x))$ is continuous at $x_0$.
3. If $f(x)$ is continuous in closed interval $[a, b]$,
    1. then it is bounded in $[a, b]$.
    2. then $\max f(x)$ and $\min f(x)$ exists in $[a, b]$.
    3. and $f(a)\cdot f(b)<0$, then exists $\xi\in(a, b)$ so that $f(\xi)=0$.
    4. then it can reach all values between $\min f(x)$ and $\max f(x)$.
    5. (*Cantor's theorem*) then it is uniformly continuous in $[a, b]$.
4. The sufficient and necessary condition for $f(x)$ to be uniformly continuous in $D$ is that for all sequences $\{x_n\}, \{y_n\}\in D^\mathbb{N}$ that satisfies $\lim\limits_{n\to\infty}(x_n-y_n)=0$, $\lim\limits_{n\to\infty}(f(x_n)-f(y_n))=0$.
5. If $f(x)$ is continuous in finite open interval $(a, b)$, then $f(x)$ is uniformly continuous on $(a, b)$ if and only if $\lim\limits_{x\to a^+}f(x)$ and $\lim\limits_{x\to b^-}f(x)$ exist.