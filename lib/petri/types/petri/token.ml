open Types__Agent

type _ t +=
  | Zero : [> `Petri of [< `Tokens] | `State of [< `Place]] t
  | One : [> `Petri of [< `Tokens] | `State of [< `Place]] t
