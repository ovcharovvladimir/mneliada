open Types__Agent
include Types__Petri__

type _ t +=
  | TR10 : [> `Petri of [< `Place]] t -> [`Petri of [`Tranz]] t
  | TR01 : [> `Petri of [< `Place]] t -> [`Petri of [`Tranz]] t
  | TR11 :
      [> `Petri of [< `Place]] t * [> `Petri of [< `Place]] t
      -> [`Petri of [`Tranz]] t
  | TR21 :
      [> `Petri of [< `Place]] t
      * [> `Petri of [< `Place]] t
      * [> `Petri of [< `Place]] t
      -> [`Petri of [`Tranz]] t
  | TR12 :
      [> `Petri of [< `Place]] t
      * [> `Petri of [< `Place]] t
      * [> `Petri of [< `Place]] t
      -> [`Petri of [`Tranz]] t
  | PL10 : [> `Petri of [< `Tranz]] t -> [`Petri of [`Place]] t
  | PL01 : [> `Petri of [< `Tranz]] t -> [`Petri of [`Place]] t
  | PL11 :
      [> `Petri of [< `Tranz]] t * [> `Petri of [< `Tranz]] t
      -> [`Petri of [`Place]] t
  | PL21 :
      [> `Petri of [< `Tranz]] t
      * [> `Petri of [< `Tranz]] t
      * [> `Petri of [< `Tranz]] t
      -> [`Petri of [`Place]] t
  | PL12 :
      [> `Petri of [< `Tranz]] t
      * [> `Petri of [< `Tranz]] t
      * [> `Petri of [< `Tranz]] t
      -> [`Petri of [`Place]] t
  | State : [> `State of 'a] t * ([> `Petri of 'a] as 'b) t -> 'b t
  | Share : int * ([> `Petri of [< `Place | `Tranz]] as 'b) t -> 'b t
  | Link : int -> [> `Petri of [< `Place | `Tranz]] t
  | Term : [> `Petri of [< `Place | `Tranz]] t
