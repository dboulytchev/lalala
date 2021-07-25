(* Naural numbers in Peano encoding *)
type nat = O | S of nat

(*
type graph     = (nat * nat) list
type numbering = nat list 
*)

(*
    Graphs are represented as lists of pairs of nodes; nodes are represented
    as natural numbers in the range [0..numberOfNodes-1].

    Numberings are represented as ordered lists of natural numbers where i-th 
    elements holds the number of i-th node

*)
                  
(* nat -> nat -> bool

   Tests the ordering relation on natural numers:
   
   less x y = true <=> x < y
*)                
let rec less x y =
  
(* numbering -> nat -> nat

   Looks up an i-th element in a numbering
*)
let rec lookup (h :: tl) k = 

(* graph -> numbering -> bool

   Tests if given numbering for a given graph is a topologial sorting 
*)       
let rec eval graph numbering = 

                              
                            
                 
