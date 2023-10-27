# Completeness of the Real Numbers

## Least upper bound property

Every nonempty subset of $\mathbb{R}$ having an upper bound has a least upper bound.

## Monotone convergence theorem

If a sequence of $\mathbb{R}$ is monotone and bounded, then it converges.

## Nested interval theorem

For a sequence of **closed** intervals $\{[a_n,b_n]\}$, if $[a_{n+1},b_{n+1}]\subset[a_n,b_n]$ for all $n\in\mathbb{N}^\star$ and $\lim\limits_{n\to\infty}{|a_n-b_n|}=0$, then exists exactly one $\xi\in\mathbb{R}$ so that $\xi\in[a_n,b_n]$ for all $n\in\mathbb{N}^\star$.

## Bolzano-Weierstrass theorem

Every bounded sequence of $\mathbb{R}$ has a convergent subsequence.

## Cauchy criterion

A sequence of $\mathbb{R}$ is convergent if and only if it is a fundamental sequence.

> **Fundamental sequence**: A sequence $\{x_n\}$ is called a fundamental sequence if for all $\varepsilon > 0$, exists $N\in\mathbb{N}^\star$ so that $|x_{n+p} - x_n| < \varepsilon$ for all $n>N$ and $p\in\mathbb{N}^\star$. Fundamental sequence is also known as Cauchy sequence.

## Heine-Borel theorem

If $H$ is an infinite **open** cover of **closed** interval $[a, b]$, then exists a finite subset $H_0\subset H$ so that $H_0$ is an **open** cover of $[a,b]$.

> Or: If $H = \{(a_\alpha, b_\alpha) | \alpha \in \Lambda\}$ which satisfies $\bigcup\limits_{\alpha\in\Lambda}{(a_\alpha, b_\alpha)} \supset [a, b]$, then exists a finite subset $H_0\subset H$ so that $\bigcup\limits_{(a_\alpha, b_\alpha)\in H_0}{(a_\alpha, b_\alpha)} \supset [a, b]$.