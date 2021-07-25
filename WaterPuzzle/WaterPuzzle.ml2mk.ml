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
let rec add n k =
  
(* nat -> nat -> nat

   Subtraction (note: sub x y = O if y >= x)
*)
let rec sub k m =

(* nat -> nat -> nat

   Minimum.
 *)
let min k m =
      
(* set -> move -> set
  
   Performs a given move for a given set if possible
*)                            
let step (capA, capB, a, b) move =

(* set -> move list -> set

   Performs a number of moves for a given set
*)
let rec eval set moves =   

