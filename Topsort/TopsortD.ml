open OCanren
open OCanren.Std
open Topsort
open Topsort.HO

@type lnumbering = nat_logic Std.List.logic      with show, gmap
@type graph      = (GT.int * GT.int) GT.list     with show

let rec to_nat n = if n = 0 then !!O else !!(S (to_nat @@ n - 1))

let rec to_graph = function
  []           -> nil ()
| (b, e) :: tl -> pair (to_nat b) (to_nat e) % to_graph tl

let () = Random.self_init ()

let split n =
  let m = 1 + Random.int n in
  let rec init acc rest i =
  match i with
  | 1 -> rest :: acc
  | k -> let x = if rest = 1 then 1 else 1 + Random.int rest in
         init (x :: acc) (rest-x+1) (k-1)
  in
  init [] (n-m+1) m

let tree n =
  let rec inner (acc, root) = function
  | 1 -> (acc, root+1)
  | n ->
     let subs = split n in
     Stdlib.List.fold_left
       (fun (acc, i) n ->
          inner ((root, i) :: acc, i) n
       )
       (acc, root+1)
       subs
  in
  fst @@ inner ([], 0) (n-1);;

let dag tree m n =
  tree @
  Stdlib.List.init m
    (fun _ ->
      let rec gen _ =
        let x, y = Random.int n, Random.int n in
        if Stdlib.(<) x y then (x, y) else gen ()
      in
      gen ()
    )

let to_dot n g =
  let b   = Buffer.create 512 in
  let add = Buffer.add_string b in
  add "digraph X {\n";
  Stdlib.List.iter (fun (x, y) ->
    add @@ Printf.sprintf "  %s -> %s\n" (GT.show(nat_logic) @@ Stdlib.List.nth n x) (GT.show(nat_logic) @@ Stdlib.List.nth n y)
  ) g;
  add "}\n";
  Buffer.contents b

let topsort g =
  Printf.printf "Graph  : %s\n" @@ GT.show(graph) g;
  Printf.printf "Topsort: %s\n" @@
  GT.show(lnumbering) @@
  Stdlib.List.hd @@
  Stream.take ~n:1 @@
  run q
      (fun q -> FO.eval (to_graph g) q !!true)
      (fun a -> a#reify (Std.List.reify nat_reify))

let _ =
  Stdlib.List.iter topsort
    [
     [0, 1; 1, 2];
     [0, 1; 0, 2; 1, 2];
     [0, 1; 0, 2; 2, 1];
     [0, 1; 0, 2; 2, 3; 1, 3; 1, 2]
    ]
