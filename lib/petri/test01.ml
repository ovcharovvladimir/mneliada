open Types.Petri
open Token

let test01 = State (One, PL10 (TR11 (Term, PL01 Term)))

let test02 =
  Share
    ( 3
    , PL11
        ( Link 2
        , TR12
            ( Term
            , PL11 (Term, Share (1, TR21 (Term, Link 2, Link 3)))
            , Share (2, PL11 (Term, Link 1)) ) ) )
