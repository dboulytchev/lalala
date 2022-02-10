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

let projector : (_, (pin * pin) Std.List.ground) Reifier.t =
  Std.List.prj_exn (Std.Pair.prj_exn prj_exn prj_exn)
let project rr = rr#reify projector

let () =
  Printf.printf "%s\n" @@
  GT.show(answer) @@
  Stdlib.List.hd @@
  Stream.take ~n:1 @@
  run q (fun q -> eval_o ((===) q) ((===) (start 7)) (finish 7)) (fun rr -> rr#reify projector)
