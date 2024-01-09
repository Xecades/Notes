# Mathematical Analysis Cheatsheet

> **Disclaimer**: By saying "cheatsheet" I don't mean something used for cheating, but rather a quick reference for the most important concepts and formulas. I don't encourage cheating in any way.

## Equivalent Infinitesimals

When $x\to0$:

 - $\sin x\sim \tan x\sim\arcsin x\sim\arctan x\sim x$
 - $1 - \cos x \sim \dfrac{1}{2} x ^ 2$
 - $\ln(1 + x) \sim e^x - 1 \sim x$
 - $(1 + x) ^ a - 1 \sim ax$

---

## Derivatives

 - $(\tan x)' = \sec ^ 2 x \longleftrightarrow (\cot x)' = - \csc ^ 2 x$
 - $(\sec x)' = \sec x \tan x \longleftrightarrow (\csc x)' = - \csc x \cot x$
 - $(\arcsin x)' = \dfrac{1}{\sqrt{1 - x ^ 2}} \longleftrightarrow (\arccos x)' = - \dfrac{1}{\sqrt{1 - x ^ 2}}$
 - $(\arctan x)' = \dfrac{1}{1 + x ^ 2} \longleftrightarrow (\operatorname{arccot} x)' = - \dfrac{1}{1 + x ^ 2}$

---

## Integrals

 - $\displaystyle\int\dfrac{x}{\sqrt{a^2 \pm x^2}}\mathrm{d}x = \pm\sqrt{a^2 \pm x^2}+C$
 - $\displaystyle\int\dfrac{1}{\sqrt{x^2+a^2}}\mathrm{d}x = \ln\left(x+\sqrt{x^2+a^2}\right)+C$
 - $\displaystyle\int\dfrac{1}{\sqrt{a^2-x^2}}\mathrm{d}x = \arcsin\dfrac{x}{a}+C$
 - $\displaystyle\int\dfrac{\mathrm{d}x}{x^2 - a^2} = \dfrac{1}{2a}\int\left(\dfrac{1}{x-a}-\dfrac{1}{x+a}\right)\mathrm{d}x = \dfrac{1}{2a}\ln\left|\dfrac{x-a}{x+a}\right|+C$
 - $\displaystyle\int\dfrac{\mathrm{d}x}{x^2 + a^2} = \dfrac{1}{a}\arctan\dfrac{x}{a}+C$
 - $\displaystyle\int\sqrt{a^2-x^2}\mathrm{d}x = \dfrac{x}{2}\sqrt{a^2-x^2}+\dfrac{a^2}{2}\arcsin\dfrac{x}{a}+C$, $a>0$
 - $\displaystyle\int\sqrt{x^2\pm a^2}\mathrm{d}x = \dfrac{x}{2}\sqrt{x^2\pm a^2}+\dfrac{a^2}{2}\ln\left(x+\sqrt{x^2\pm a^2}\right)+C$, $a>0$
 - $\int\tan x\mathrm{d}x = -\ln|\cos x|+C$
 - $\int\cot x\mathrm{d}x = \ln|\sin x|+C$
 - $\int\sec x\mathrm{d}x = \ln|\sec x+\tan x|+C$
 - $\int\csc x\mathrm{d}x = -\ln|\csc x+\cot x|+C = \ln|\csc x-\cot x|+C$
 - $\int\sec^3x\mathrm{d}x = \dfrac{1}{2}\sec x\tan x+\dfrac{1}{2}\ln|\sec x+\tan x|+C$

---

## Taylor Series

With $\theta\in(0, 1)$ and $\xi = x_0 + \theta(x - x_0)$:

 - $f(x) = f(x_0) + f'(x_0)(x-x_0) + \cdots + \dfrac{f^{(n)}(x_0)}{n!}(x-x_0)^n + \dfrac{f^{(n+1)}(\xi)}{(n+1)!}(x-x_0)^{n+1}$
 - $e^x = 1 + x + \dfrac{x^2}{2!} + \dfrac{x^3}{3!} + \cdots + \dfrac{x^n}{n!} + \dfrac{e^{\theta x}}{(n+1)!}x^{n+1}$
 - $\sin x = x - \dfrac{x^3}{3!} + \dfrac{x^5}{5!} - \cdots + (-1)^n\dfrac{x^{2n+1}}{(2n+1)!} + (-1)^{n+1}\dfrac{\cos\theta x}{(2n+3)!}x^{2n+3}$
 - $\cos x = 1 - \dfrac{x^2}{2!} + \dfrac{x^4}{4!} - \cdots + (-1)^n\dfrac{x^{2n}}{(2n)!} + (-1)^{n+1}\dfrac{\sin\theta x}{(2n+2)!}x^{2n+2}$
 - $\ln(1 + x) = x - \dfrac{x^2}{2} + \dfrac{x^3}{3} - \cdots + (-1)^{n-1}\dfrac{x^n}{n} + o(x^n)$
 - $(1+x)^\alpha = \dbinom{\alpha}{0} + \dbinom{\alpha}{1}x + \dbinom{\alpha}{2}x^2 + \cdots + \dbinom{\alpha}{n}x^n + o(x^n)$
 - $\dfrac{1}{1-x} = 1 + x + x^2 + \cdots + x^n + o(x^n)$
 - $\arctan x = x - \dfrac{x^3}{3} + \dfrac{x^5}{5} + \cdots + (-1)^n\dfrac{x^{2n+1}}{2n+1} + o(x^{2n+1})$
 - $\arcsin x = x + \dfrac{x^3}{6} + \dfrac{3x^5}{40} + o(x^5)$
 - $\arccos x = \dfrac{\pi}{2} - \arcsin x$