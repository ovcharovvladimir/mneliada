# ![M N E Li Ad A](https://hub.darcs.net/Fayonnagan_Piker/mneliada/raw-file/docs/MNELIADA.png)

* Multiplicative
* Non Commutative
* Exponential
* Linear Logic
* with Additive case
* and Applicative pattern matching

# Features and technologies

* pi calculus, lambdas and concatenative stack works together as one
* deep inference structural proofs for type system
* signatures for kinds, classes, types and sorts
* linear logic, interaction nets, proof nets and solo calculus
* core syntax without any keywords, any natural language can be used
* competition of algorithms in additive and applicative fashion with match and winner
* can be used for mathematics, cryptography, smart contracts, proofs and applications
* monads, arrows, transformers, functors and profunctors can be used
* concurrent asynchronous processes, offers, sessions with parallel logic of pi calculus
* user defined binary operators is supported, with fixity direction and level
* specific rewriting logic for new syntax operators can be defined by user

# ![Proof search as execution](https://hub.darcs.net/Fayonnagan_Piker/mneliada/raw-file/docs/ps.png)

## Example code

```
#!/usr/bin/env mneliada

! hex[{ 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | A | B | C | D | E | F }]

! byte[{ :hex . :hex }]

! uint32[{ :byte . :byte . :byte . :byte }]

! option[[a] { None | Some{a} }]

! Number [
  ? t [{ :Type }]
  ? add [[ :t * :t ] { :t }]
  ? mul [[ :t * :t ] { :t }]
  + ( ? of_int32 [[ :uint32 ] { :t }]
      ? to_int32 [[ :t ] { _ : uint32 option }]
    )
] {
  ! Shugar {
    ! (+) >> add
    ! (*) >> mul
  }
}

! Complex {
  ! t [[a : Number] { C{a . a} }]
  ! add [[ C{a.b} . C{c.d} ] { C{(a+c) . (b+d)} }]
}

# Example of GADT expression
! expr[ [a : hex]{ HexExpr{a} } | [a : uint32]{ Uint32Expr{a} } ]

#{

This is multiline comment

#}

```

---

## Types

## Fixity table

| **Prec**\ \ \  | **Left**\ \ \  | **Prefix**\ \ \  |  **Right** |
|------|---|-----|----------|
| High |   |     |          |
|      |   |     |          |
|      |   |     |          |
|      |   |     | `*` `|`  |
|      |   |     | `.` `>>` |
|      |   |     | `+`      |
|      |   | `!` |          |
|      |   |     |          |
|      |   |     |          |
|      |   | `\` |          |
| Low  |   |     |          |

---

## Syntax operators

| **Syntax**\ \ \ \ \ \ \ \ \ \ \ \ \ \ \  | **Descr** |
|---------------|-----------------------------------------------------|
| `.`           | Bind                                                |
| `\`           | Lambda                                              |
| `!`           | Of course                                           |
| `>>`          | Pipe                                                |
| `a{b}`        | send channel `b` to channel `a`                     |
| `a[b]`        | receive channel from channel `a` and bind it to `b` |
| `_[a]`        | create scoped fresh channel `a`                     |
| `123 : fnt`   | Number `123` of type `int`                          |
| `123 : float` | Number `123` of type `float`                        |

---

## Example of shugar rules transformations application (can be done at compile time)

| **Before**\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  | **After** |
|----------|----------|
| `a >> b  ` | `( ! a[c] . b{c} )` |
| `a[b]{c} ` | `( a[b] . a{c} )` |
| `a{b}[c] ` | `( a{b} . a[c] )` |
| `a[b | c]` | `( a[b] | a[c] )` |
| `a[b . c]` | `( a[b] . a[c] )` |
| `a[b + c]` | `( a[b] + a[c] )` |
| `a[[b]]  ` | `( a[c] . c[b] )` |
| `a[[b] . c]  ` | `( a[d] . d[b] . a[c] )` |
| `1 + 2` | `3` |
| `"Hello" . " " . "world"` | `"Hello world"` |
| `a[[b]{c}]` | `a[d] . d[b] . d{c}` |
| `:t` | `(_ : t)` |


---

```
! a     # Before
! b
! c
```
```
| ! a   # After
| ! b
| ! c
```

---

## Examples of lambda translation

### SKI combinators

```
( \x . x ) \i . expr
-----------------------------------------------------------
_[i] . expr | ! _[a] . i{a} | ! _[b] . a{b} | a[x] . x >> b
------------------------------------------------------------------
_[i] . expr | ! _[a] . i{a} | ! _[b] . a{b} | a[x] . ! x[c] . b{c}

```
