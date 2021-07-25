module L = List

open GT

open OCanren
open OCanren.Std

open Hanoi

(*************************************************)

@type pin    = Hanoi.gpin = A | B | C with show
@type answer = (pin, pin) Pair.ground List.ground with show

let rec toN n = if n = 0 then o () else s (toN (n - 1))

let gen_pin n =
  let rec gen_pin m =
    if m = n then nil () else toN m % gen_pin (m + 1) in
  gen_pin 0

let start n  = pair (gen_pin n) (pair (nil ()) (nil ()))
let finish n = pair (nil ()) (pair (nil ()) (gen_pin n))

let _ =
  Printf.printf "%s\n" @@
  show(answer) @@
  L.hd @@
  Stream.take ~n:1 @@
  run q (fun q -> eval ((===) q) ((===) (start 7)) (finish 7)) project
