(* Natural numbers in Peano encoding *)
type nat = O | S of nat

(* A possible moves:
   --- pour A to B
   --- pour B to A
   --- fill A
   --- fill B
*)
type move = AB | BA | FillA | FillB
                                
(*
Make this type definition compile

type set = (nat, nat, nat, nat)
*)

(*
    A set is a quadruple:

       (capacity of A, capacity of B, contents of A, contents of B)
*)

(* Some operations on natural numbers *)

(* nat -> nat -> nat

   Addition.
*)                            
let rec add n = function
| O   -> n
| S k -> S (add n k)       

(* nat -> nat -> nat

   Subtraction (note: sub x y = O if y >= x)
*)
let rec sub k m =
  match k with
  | O    -> O
  | S k' -> match m with
            | O    -> k
            | S m' -> sub k' m'

(* nat -> nat -> nat

   Minimum.
 *)
let min k m =
  let rec min' = function
  | (O, S _)   -> k
  | (S _, O)   -> m
  | (S k, S m) -> min' (k, m)
  | (O, O)     -> k
  in
  min' (k, m)
      
(* set -> move -> set
  
   Performs a given move for a given set if possible
*)                            
let step (capA, capB, a, b) = function
| FillA -> (capA, capB, capA, b)
| FillB -> (capA, capB, a, capB)
| AB    -> let diff = sub capB b in 
           (capA, capB, sub a diff, add b (min diff a))
| BA    -> let diff = sub capA a in 
           (capA, capB, add a (min diff b), sub b diff)

(* set -> move list -> set

   Performs a number of moves for a given set
*)
let rec eval set = function
| []         -> set
| m :: moves -> eval (step set m) moves  

