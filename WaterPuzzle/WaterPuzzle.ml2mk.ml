open Peano
open List

let ( - ) a b = if a >= b then a - b else 0

(* A possible moves:
   --- pour A to B
   --- pour B to A
   --- fill A
   --- fill B
*)
type move = AB | BA | FillA | FillB
                            
let step (capA, capB, a, b) = function
| FillA -> (capA, capB, capA, b)
| FillB -> (capA, capB, a, capB)
| AB    -> let diff = capB - b in
           (capA, capB, a - diff, min diff a + b)
| BA    -> let diff = capA - a in
           (capA, capB, min diff b + a, b - diff)

(* set -> move list -> set
   Performs a number of moves for a given set
*)
let eval = fold_left step

[@@@ocaml
open GT
open OCanren
open OCanren.Std
open HO
     
ocanren type answer = move GT.list 
                    
let _ = 
  Printf.printf "%s\n"
  @@ show (answer) 
  @@ Stdlib.List.hd
  @@ Stream.take ~n:1
  @@ ocanrun (q : answer) {fresh a, b, c, d in
                           FO.eval (5, 3, 0, 0) q (a, b, c, d) &
                           {a == 1 | d == 1}
                          } -> q
]
          


      
