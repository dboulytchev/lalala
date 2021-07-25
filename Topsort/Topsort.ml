open GT
open OCanren
open OCanren.Std
type 'a0 gnat =
  | O 
  | S of 'a0 
module For_gnat = (Fmap)(struct let rec fmap fa0 = function | O -> O | S a0 -> S (fa0 a0)
                                type 'a0 t = 'a0 gnat end)
let rec o () = inj (For_gnat.distrib O)
and s x__0 = inj (For_gnat.distrib (S x__0))
let rec less x y q7 =
  fresh (q1 y' q3) (q1 === (s y')) (y q1) (x q3) (((q3 === (o ())) &&& (q7 === (!! true))) ||| (fresh (x') (q3 === (s x')) (less (fun q5 -> x' === q5) (fun q6 -> y' === q6) q7)))
let rec lookup q8 q9 q10 =
  fresh (q11 h tl q14) (q11 === (h % tl)) (q8 q11) (q9 q14)
    (((q14 === (o ())) &&& (h === q10)) ||| (fresh (k) (q14 === (s k)) (lookup (fun q17 -> tl === q17) (fun q15 -> k === q15) q10)))
let rec eval graph numbering q28 =
  fresh (q29 q19) (numbering q29) (graph q19)
    (((q19 === (nil ())) &&& (q28 === (!! true))) |||
       (fresh (b e graph' q23) (q19 === ((pair b e) % graph'))
          (less (lookup (fun q30 -> q30 === q29) (fun q25 -> b === q25)) (lookup (fun q30 -> q30 === q29) (fun q26 -> e === q26)) q23)
          (conde [(q23 === (!! false)) &&& (q28 === (!! false)); (q23 === (!! true)) &&& (eval (fun q27 -> graph' === q27) (fun q30 -> q30 === q29) q28)])))