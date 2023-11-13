# Prove That...

C'mon, prove these linear algebra things!

> For the content below, I use $W\leqslant V$ to denote $W$ is a subspace of $V$, and $\exists!$ to denote "there exists a unique".

## Group, Ring & Field

1. $\mathbb{Q}(\sqrt{2}) = \{a+b\sqrt{2}\mid a,b\in\mathbb{Q}\}$ is a field.
2. $\mathbb{Q}$ is the smallest number field (i.e. subfield of $\mathbb{C}$).

---

## Linear Space

1. For $W\subset V(\mathbf{F})$, $W\leqslant V\iff W$ is closed under addition and scalar multiplication.
2. $S_1\subset S_2\subset V(\mathbf{F})\Rightarrow\operatorname{span}S_1\subset\operatorname{span}S_2$.
3. If $S_1$ and $S_2$ are linearly independent, then $\operatorname{span}S_1=\operatorname{span}S_2\Rightarrow|S_1|=|S_2|$.
4. Functions $\exp(\lambda_1x)$, $\exp(\lambda_2x)$ and $\exp(\lambda_3x)$ are linearly independent. ($\lambda_1$, $\lambda_2$ and $\lambda_3$ are distinct)
5. For $W_1, W_2\leqslant V(\mathbf{F})$:
    1. $W_1\cup W_2\leqslant V\iff W_1\subset W_2$ or $W_2\subset W_1$.
    2. $W_1 + W_2 = \operatorname{span}(W_1\cup W_2)$.
    3. $\dim(W_1 + W_2) = \dim W_1 + \dim W_2 - \dim(W_1\cap W_2)$.
6. For $W_1, W_2\leqslant V(\mathbf{F})$, the following propositions are equivalent:
    1. $W_1 \cap W_2 = \{0\}$.
    2. $\forall\alpha\in W_1 + W_2$, $\exists!\alpha_1\in W_1$ and $\exists!\alpha_2\in W_2$ such that $\alpha = \alpha_1 + \alpha_2$.
    3. If $0 = \alpha_1 + \alpha_2 (\alpha_1 \in W_1, \alpha_2 \in W_2)$, then $\alpha_1 = \alpha_2 = 0$.
    4. $\dim(W_1 + W_2) = \dim W_1 + \dim W_2$.

---

## Inner Product Space

1. (*Cauchy–Schwarz inequality*) $|\langle\alpha,\beta\rangle|\leq \|\alpha\|\cdot\|\beta\|$.
2. (*Triangle inequality*) $\|\alpha\|+\|\beta\| \geq \|\alpha+\beta\|$.
3. (*Pythagorean theorem*) $\|\alpha\|^2+\|\beta\|^2 = \|\alpha+\beta\|^2\iff\alpha\perp\beta\iff\angle(\alpha,\beta)=\dfrac{\pi}{2}$.
4. (*Gram–Schmidt process*) Any Euclidean space has an orthonormal basis. (The method to construct it is called Gram–Schmidt process.)
5. If $B = \{\varepsilon_1, \varepsilon_2, \cdots, \varepsilon_n\}$ is an orthonormal basis of $V(\mathbf{F})$, then $\forall\alpha\in V$, $\alpha = \sum\limits_{i=1}^n\langle\alpha,\varepsilon_i\rangle\cdot\varepsilon_i$.

---

## Linear Transformation

1. $\sigma:V\to W$ is injective $\iff\ker\sigma = \{0\}$.
2. $\sigma:V\to W$ is surjective $\iff\operatorname{im}\sigma = W$.
3. If $B=\{\alpha_1,\alpha_2,\dots,\alpha_n\}$ is a basis of $V$, then $\forall \beta_1, \beta_2, \dots, \beta_n\in W$, $\exists !\sigma:V \to W$ such that $\sigma(\alpha_i) = \beta_i$.
4. For $\sigma: V \to W$, $\operatorname{rank}\sigma + \dim\ker\sigma = \dim V$.
5. For $\sigma: V \to W$, if $\dim V = \dim W = n$, the following propositions are equivalent:
    1. $\sigma$ is injective.
    2. $\sigma$ is surjective.
    3. $\operatorname{rank}\sigma = n$.
6. $V\cong W \iff \dim V = \dim W$.

---

## Matrix

1. $\mathbf{M}(\sigma)$ and $\sigma$ are one-to-one.
2. Prove with matrix: if $\dim V(\mathbf{F})=m$, $\dim W(\mathbf{F})=n$, then $\mathcal{L}(V, W)\cong \mathbf{F}^{m\times n}$.
3. Prove with matrix: $\dim\mathcal{L}(V, W)=\dim V\cdot\dim W$.