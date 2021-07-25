module L = List
         
open OCanren
open OCanren.Std
open GT
open Topsort
   
@type 'a gnat    = 'a Topsort.gnat = O | S of 'a with show, gmap
@type lnat       = lnat gnat logic               with show, gmap
@type lnumbering = lnat Std.List.logic           with show, gmap
@type graph      = (int * int) list              with show

let rec to_nat n = if n = 0 then o () else s @@ to_nat @@ n - 1 
                                                                             
let rec to_graph = function
  []           -> nil ()
| (b, e) :: tl -> pair (to_nat b) (to_nat e) % to_graph tl

let rec reify_nat h n = For_gnat.reify reify_nat h n;;
                      
Random.self_init ();;

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
     L.fold_left
       (fun (acc, i) n ->
          inner ((root, i) :: acc, i) n 
       )
       (acc, root+1)
       subs
  in
  fst @@ inner ([], 0) (n-1);;

let dag tree m n =
  tree @
  L.init m
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
  L.iter (fun (x, y) -> add @@ Printf.sprintf "  %s -> %s\n" (show(lnat) @@ L.nth n x) (show(lnat) @@ L.nth n y)) g;
  add "}\n";
  Buffer.contents b

let topsort g =  
  Printf.printf "Graph  : %s\n" @@ show(graph) g;
  Printf.printf "Topsort: %s\n" @@
  show(lnumbering) @@
  L.hd @@
  Stream.take ~n:1 @@ 
  run q
      (fun q -> eval ((===) (to_graph g)) ((===) q) (!!true))
      (fun a -> a#reify (Std.List.reify reify_nat))
  
let _ =
  L.iter topsort
    [      
     [0, 1; 1, 2];
     [0, 1; 0, 2; 1, 2];
     [0, 1; 0, 2; 2, 1];
     [0, 1; 0, 2; 2, 3; 1, 3; 1, 2]
    ]
    
                                                             

                                                     
