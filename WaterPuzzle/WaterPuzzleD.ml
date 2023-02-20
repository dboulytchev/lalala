open GT

open OCanren
open OCanren.Std

open WaterPuzzle
open WaterPuzzle.HO

(*************************************************)
@type set     = nat * nat * nat * nat with show
@type lset    = ocanren {nat_logic * nat_logic * nat_logic * nat_logic} with show
@type answer  = move OCanren.Std.List.ground with show

let rec toN n = if n = 0 then !!O else !!(S (toN (n - 1)))

let _ =
  Printf.printf "Test!\n";
  Printf.printf "%s\n" @@
  show(answer) @@
  Stdlib.List.hd @@
  Stream.take ~n:1 @@
    run q (fun q -> ocanren {
                      fresh a, b, c, d in
                      FO.eval (toN !(5), toN !(3), toN !(0), toN !(0)) q (a, b, c, d) &
                      {c == toN !(1) | d == toN !(1)}
                    }) (fun rr -> rr#reify (Std.List.prj_exn prj_exn))
