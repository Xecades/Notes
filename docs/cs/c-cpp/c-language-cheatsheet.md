# C Language Cheatsheet

## Operator Precedence

Refer to [cppreference](https://en.cppreference.com/w/c/language/operator_precedence).

## Format String

The syntax of a format placeholder is

```c
%[parameter][flags][width][.precision][length]type
```

\* Square brackets indicate optional parts of the placeholder.

### Type

| Type | Description |
| :--: | -- |
| `%` | Prints `%`. |
| `d` | Decimal `signed int`. |
| `u` | Decimal `unsigned int`. |
| `o` | Octal `unsigned int`. |
| `x`, `X` | Hexadecimal `unsigned int`. `x` for lower-case and `X` for upper-case. |
| `f` | Float-point types in fixed-point notation. |
| `e`, `E` | Float-point types in exponential notation: `d.ddde±dd`. `e` for lower-case "e" and `E` for upper-case. |
| `g`, `G` | Float-point types in either fixed-point or exponential notation, whichever is more appropriate for its magnitude. `g` for lower-case and `G` for upper-case. |
| `a`, `A` | Float-point in hexadecimal notation, starting with `0x` or `0X`. `a` for lower-case and `A` for upper-case. |
| `s` | `null`-terminated string. |
| `c` | `char`. |
| `p` | `void*` in an implementation-defined format. |
| `n` | Print nothing, but writes the number of characters written so far into an integer pointer parameter. |

Examples:

```c
printf("%%");           // %
printf("%d", 123);      // 123
printf("%d", -123);     // -123
printf("%u", 123);      // 123
printf("%u", -123);     // 4294967173
printf("%o", 123);      // 173
printf("%x", 123);      // 7b
printf("%X", 123);      // 7B
printf("%f", 123.456);  // 123.456000
printf("%e", 123.456);  // 1.234560e+02
printf("%E", 123.456);  // 1.234560E+02
printf("%g", 123.456);  // 123.456
printf("%G", 123.456);  // 123.456
printf("%a", 123.456);  // 0x1.edd2f1a9fbe77p+6
printf("%A", 123.456);  // 0X1.EDD2F1A9FBE77P+6
printf("%s", "Hello");  // Hello
printf("%c", 'H');      // H

int a = 123;
printf("%p", &a);       // 0x16d79b3d8

int n;
printf("Hello%n", &n);  // Hello
printf("%d", n);        // 5
```

### Others

For further information, refer to [Wikipedia](https://en.wikipedia.org/wiki/Printf).

Here are some common examples:

```c
printf("[%5d]", 123);         // [  123]
printf("[%-5d]", 123);        // [123  ]
printf("[%05d]", 123);        // [00123]
printf("[%+5d]", 123);        // [ +123]
printf("[%*d]", 5, 123);      // [  123] (dynamic width)
printf("[%.1f]", 123.456);    // [123.5]
printf("[%10f]", 123.456);    // [123.456000] (10 characters in total)
printf("[%10.5f]", 123.456);  // [ 123.45600] (5 precision, 10 characters)
printf("[%010.5f]", 123.456); // [0123.45600] (5 precision, 10 characters)
```