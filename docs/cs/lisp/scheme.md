# Scheme

**Scheme** is a dialect of the *Lisp* family of programming languages, known for its minimalism and simplicity. Many developers consider Scheme a very elegant language.

> Scheme is a very simple language, much easier to implement than many other languages of comparable expressive power. This ease is attributable to the use of lambda calculus to derive much of the syntax of the language from more primitive forms.
>
> <div align=right>——Wikipedia</div>

Online REPL: [try.scheme.org](https://try.scheme.org/).

---

## Syntax

### Primitives

Scheme has a set of *atomic* primitive expressions. Atomic means that these expressions cannot be divided up. For example:

```scm
scm> 123     ; Number
123
scm> #f      ; False
#f
scm> #t      ; True
#t
scm> "Hello" ; String
"Hello"
```

Note that the only primitive in Scheme that is false is `#f`. All other values are true.

---

### Call Expressions

<center>`(<operator> <operand1> <operand2> ...)`</center>

All expressions are written in the form of a list, with the first element being the operator and the rest being the operands. For example:

```scm
scm> (+ 1 2 3)                  ; 1 + 2 + 3 = 6
6
scm> (* (+ 1 2) 3 4)            ; (1 + 2) * 3 * 4 = 36
36
scm> (even? (* (+ 1 2) 3 4))    ; Is 36 even?
#t
scm> (- 5)                      ; -5
-5
scm> (- 1 2 3)                  ; 1 - 2 - 3 = -4
-4
scm> (>= 1 2)                   ; Is 1 >= 2?
#f
scm> (string-append "Hello" " " "World")
"Hello World"
```

In the examples above, `+`, `-`, `*`, `>=`, `even?` and `string-append` are all procedure (function) names.

Commonly used math procedures: `+`, `-`, `*`, `/`, `abs`, `quotient`, `remainder`, `modulo`, `min`, `max`, `expt`, `sqrt`, `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `log`, `exp`, `floor`, `ceiling`, `round`.

---

### Special Forms

Special forms are expressions that are not evaluated in the same way as call expressions. For example:

#### Lambda

Lambda function is the meat of Scheme. It is used to create anonymous functions.

Syntax: `(lambda (<param1> <param2> ...) <body>)`

```scm
scm> (lambda (x y) (+ x y))
#<procedure>
scm> ((lambda (x y) (+ x y)) 1 2)
3
```

#### Define

Use `(define <name> <value>)` to define a variable.

Use `(define (<name> <param1> <param2> ...) <body>)` to define a procedure. It is equivalent to `(define <name> (lambda (<param1> <param2> ...) <body>))`.

```scm
scm> (define x 1)
scm> x
1
scm> (define (add x y) (+ x y))
scm> (add 1 2)
3
scm> (define add-lambda (lambda (x y) (+ x y)))
scm> (add-lambda 1 2)
3
```

#### If

Syntax: `(if <condition> <consequent> <alternative>)`

```scm
(define x 10)
(if (odd? x)
    (print "x is odd")
    (print "x is even"))
; "x is even"
```

#### Cond

*Cond* is a multi-way if statement.

Syntax: `(cond (<condition1> <consequent1>) (<condition2> <consequent2>) ... [(else <alternative>)])`

```scm
scm> (define x 10)
scm> (cond
       ((< x 0) -1)
       ((= x 0) 0)
       (else 1))
1
```

#### And & Or

`and` and `or` are used to combine multiple conditions. They are *short-circuit*.

```scm
scm> (and
       (zero? 1)
       (/ 1 0))   ; Won't be evaluated
#f
scm> (or
       (zero? 0)
       (/ 1 0))   ; Also won't be evaluated
#t
```

Even though running `(/ 1 0)` alone will cause `DivisionByZero` error, In the example above it won't be evaluated since `and` and `or` are short-circuit.

---

### Quotation

Quotation is used to prevent evaluation of an expression. There are two types of quotations:

 - Quote: `(quote <expression>)` or `'(<expression>)`.

 - Quasiquote: `(quasiquote <expression>)` or ```(<expression>) ``.

Inside a quasiquote, use `unquote` or `,` to *unquote* (evaluate) an expression.

```scm
scm> (quote (+ 1 2))        ; (+ 1 2) will not be evaluated
(+ 1 2)
scm> '(zero? 2)             ; Equivalent to (quote (zero? 2))
(zero? 2)
scm> `(1 (+ 1 1) ,(+ 1 2))  ; (+ 1 1) won't be evaluated, but (+ 1 2) will
(1 (+ 1 1) 3)
```

---

### List

```scm
scm> (list 1 2 3)
(1 2 3)
scm> '(1 2 3)       ; Use quote to create a list
(1 2 3)
scm> (define lst '(1 2 3))
scm> (cons 4 lst)   ; CONStruct a list with `4` as the first element and `lst` as the rest
(4 1 2 3)
scm> (cons 0 nil)   ; `nil` is the built-in empty list
(0)
scm> (car lst)      ; `car` returns the first element of a list
1
scm> (cdr lst)      ; `cdr` returns the rest of a list
(2 3)
```

`car` is short for *Contents of Address Register*, and `cdr` is short for *Contents of Decrement Register*.

**Scheme code itself is a list.** So here comes some magic:

```scm
scm> (list + 1 2)   ; `+` as a primitive procedure will be calculated
(#[+] 1 2)
scm> (list '+ 1 2)  ; `+` must be quoted to prevent evaluation
(+ 1 2)
scm> (eval (list '+ 1 2))
3
scm> (eval '(+ 1 2))
3
```

---

### `=`, `eq?` & `equal?`

`=` can only be used to compare numbers.

For `(eq? <a> <b>)`.

 - If `a` and `b` are both numbers, booleans, symbols, or strings, return true if they are equivalent; false otherwise.
 - Otherwise, return true if `a` and `b` both refer to the same object in memory; false otherwise.

It behaves like `is` in python.

```scm
scm> (eq? '(1 2 3) '(1 2 3))
#f
scm> (define x '(1 2 3))
scm> (eq? x x)
#t
```

`(equal? <a> <b>)` returns true if `a` and `b` are equivalent. For two pairs, they are equivalent if their `car`s are equivalent and their `cdr`s are equivalent.

```scm
scm> (equal? '(1 2 3) '(1 2 3))
#t
```

---

### Streams

Streams are lazy lists. They are evaluated only when needed.

**Under Construction**