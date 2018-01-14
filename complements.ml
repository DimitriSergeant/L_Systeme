(* transforme une chaîne de caractères en une liste de caractères *)
let explode s =
  let rec exp i l =
    if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) []

let _ = assert (explode "abc" = ['a';'b';'c'])
