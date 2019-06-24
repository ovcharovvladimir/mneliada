module L = Types.Link
open L
open Types.Petri
open Token

let test01 = State (One, PL10 (TR11 (Term, PL01 Term)))

let test02 =
  let id1 = Id 1 in
  let id2 = Id 2 in
  let id3 = Id 3 in
  Share
    ( id3
    , PL11
        ( Term
        , TR12
            ( Term
            , PL11 (Term, Share (id1, TR21 (Term, Link id2, Link id3)))
            , Share (id2, PL11 (Term, Link id1)) ) ) )
