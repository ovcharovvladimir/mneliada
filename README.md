# ![M N E Li Ad A](./mneliada/raw-file/docs/MNELIADA.png)

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

# Docs

## Types

## Fixity table

| **Prec**\ \ \  | **Left**\ \ \            | **Prefix**\ \ \                |  **Right**                 |
|------|------------------|-----------------|-------------------|
| High |                  |                 |                   |
|      |                  |                 |                   |
|      |                  |                 |                   |
|      |                  |                 | `*` `|`           |
|      |                  |                 | `.` `>>`              |
|      |                  |                 | `+`                 |
|      |                  | `!`               |                   |
|      |                  |                 |                   |
|      |                  |                 |                   |
|      |                  | `\`               |                   |
| Low  |                  |                 |                    |

---

## Syntax operators

| **Syntax**\ \ \         | **Descr**            |
|----------|-------------|
| `.`        | Bind        |
| `\`        | Lambda      |
| `!`        | Of course   |
| `>>`       | Pipe        |
| `a{b}`     | send channel `b` to channel `a` |
| `a[b]`     | receive channel from channel `a` and bind it to `b` |
| `_[a]`    | create scoped fresh channel `a` |
| `123 : Int` | Number `123` of type `Int` |
| `123 : Float` | Number `123` of type `Float` |

---

## Example of shugar rules transformations (compile time)

| **Before**\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  | **After** |
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

---

## Example code

```

! complex[a : ADT] . a[b : Number] . a{ Real{b} * Imag{b} }

! expr[a : GADT] . a[Int]{I{Int}} | a[Int]{B{Int}}

! elem[b] . _[a] . complex{a} . a{Float} . a >> b


```


---

# How to build

## Environment

It's highly recommended to [install Nix](https://nixos.org/nix/download.html).

- E.g.
```shell
curl https://nixos.org/nix/install | sh
. ~/.nix-profile/etc/profile.d/nix.sh
```

### Quick Start

- TL;DR:
```shell
make setup && make test
make build && scripts/run random_render --help
```

- More:
```shell
make help
```

## FAQ

### Using unstable channel

Nix development Environment relies on unstable channel.
Which is default on fresh nix install.

So in case you're on stable nix, or use NixOS, do the following:

1. Add unstable channel:

```shell
nix-channel --add https://nixos.org/channels/nixos-unstable unstable
```

2. Update unstable channel:

```
nix-channel --update
```

3. Pass the `NIX_ARGS` variable to make:  
(note that path to `channels/unstable` may differ on your system)

```shell
make NIX_ARGS="-I nixpkgs=$HOME/.nix-defexpr/channels/unstable" sync

# Other way

export NIX_ARGS="-I nixpkgs=$HOME/.nix-defexpr/channels/unstable"
make sync
```

### Run REPL on or build sub-directory only

```shell
scripts/repl ./test
```

```shell
scripts/build ./test
```

## Troubleshooting

- Missing dependencies
In case you encounter a message like this (i.e. in case of library missing):

```
Error: Library "alcotest" not found.
```

Launch the following command: `make sync`. In case it didn't help, try
update lock file: `make lock` and try again. If this didn't help, try
`make update` to install dependencies without lock file, or even `make upgrade`
to upgrade their versions.

- User groups permission

In case during project building on GNU/Linux you encounter such message:

```
error: cloning builder process: Operation not permitted
```

Then user groups for non-privileged users should be enabled:

```shell
sysctl kernel.unprivileged_userns_clone=1
```
