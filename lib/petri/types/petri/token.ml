open Types__Agent

type _ t +=
  | Zero : [> `Petri of [< `Tokens]] t | One : [> `Petri of [< `Tokens]] t
