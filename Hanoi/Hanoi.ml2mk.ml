(* Natural numbers in Peano encoding *)
type nat = O | S of nat

(* Names for pins *)                  
type pin = A | B | C

(*
type move = (pin, pin)
type set  = (nat list, nat list, nat list) 
*)
                 
(*
    Moves are represented as pars of pin names; 
    the set is represented as triples of lists of 
    natural numbers:


       =     |     |
      ===    |     |
     =====   |     |
   -------------------
      A      B     C   <- names for pins

    Representation: ([1, 2, 3], [], [])   
 *)
                 
(* nat -> nat -> bool

   Tests the ordering relation on natural numers:
   
   less x y = true <=> x < y
*)                 
let rec less x y = 

(* move -> pin

   Gets the name of the complementary pin for a given move 
   (e.g. (A, B) -> C, etc.)
*)                   
let complement move = 

(* set -> pin -> nat list
   
   Selects the contents of given pin by its name
 *)          
let select (x, y, z) pin =
                          
(* move -> set -> set

   Makes a pseudo-set for given set and move:

   (from, to) -> set -> (set.from, set.to, set.complement)   
*)     
let selectMove move s = 
                      
(* set -> move -> set

   Permutes a pseudo set for a given move to get a "normal" set
 *)           
let permutate (x, y, z) move = 

(* move list -> set -> set

  Executes a given sequence of moves for given initial set and
  produces a final set (if possible) 
*)
let rec eval p s = 
