(* Mostly copied from https://github.com/Chris00/ocaml-rope/blob/master/src/rope.ml
Parts that are modified are marked with "Modified" and commented out *)

(* File: rope.ml

   Copyright (C) 2007

     Christophe Troestler
     email: Christophe.Troestler@umh.ac.be
     WWW: http://math.umh.ac.be/an/software/

   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License version 2.1 or
   later as published by the Free Software Foundation, with the special
   exception on linking described in the file LICENSE.

   This library is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the file
   LICENSE for more details. *)

(** Rope implementation inspired from :

    Hans Boehm, Russ Atkinson, Michael Plass, "Ropes: an alternative
    to strings", Software Practice and Experience 25, vol. 12 (1995),
    pp. 1315-1330.

    http://www.cs.ubc.ca/local/reading/proceedings/spe91-95/spe/vol25/issue12/spe986.pdf *)

(* TODO:
   - Regexp (maybe using Jérôme Vouillon regexp lib ?
     http://www.pps.jussieu.fr/~vouillon/)

   - Camomille interop. (with phantom types for encoding ??)
     See also the OSR http://cocan.org/osr/unicode_library
*)


let min i j = if (i:int) < j then i else j
let max i j = if (i:int) > j then i else j

exception Out_of_bounds of string

(* One assumes throughout that the length is a representable
   integer.  Public functions that allow to construct larger ropes
   must check this. *)
type t =
  | Sub of string * int * int
      (* (s, i0, len) where only s.[i0 .. i0+len-1] is used by the
         rope.  [len = 0] is forbidden, unless the rope has 0 length
         (i.e. it is empty).  Experiments show that this is faster
         than [Sub of string] and does not really use more memory --
         because splices share all nodes. *)
  | Concat of int * int * t * int * t
      (* [(height, length, left, left_length, right)].  This asymmetry
         between left and right was chosen because the full length and
         the left length are more often needed that the right
         length. *)

type rope = t

let small_rope_length = 32
  (** Use this as leaf when creating fresh leaves.  Also sub-ropes of
      length [<= small_rope_length] may be flattened by [concat2].
      This value must be quite small, typically comparable to the size
      of a [Concat] node. *)

let make_length_pow2 = 10
let make_length = 1 lsl make_length_pow2

let max_flatten_length = 1024
  (** When deciding whether to flatten a rope, only those with length [<=
      max_flatten_length] will be. *)

let extract_sub_length = small_rope_length / 2
  (** When balancing, copy the substrings with this length or less (=>
      release the original string). *)

let level_flatten = 12
  (** When balancing, flatten the rope at level [level_flatten].  The
      sum of [min_length.(n)], [0 <= n <= level_flatten] must be of te
      same order as [max_flatten_length]. *)

(* Fibonacci numbers $F_{n+2}$.  By definition, a NON-EMPTY rope [r]
   is balanced iff [length r >= min_length.(height r)].
   [max_height] is the first height at which the fib. number overflow
   the integer range. *)
let min_length, max_height =
  (* Since F_{n+2} >= ((1 + sqrt 5)/2)^n, we know F_{d+2} will overflow: *)
  let d = (3 * Sys.word_size) / 2 in
  let m = Array.make d max_int in
  (* See [add_nonempty_to_forest] for the reason for [max_int] *)
  let prev = ref 0
  and last = ref 1
  and i = ref 0 in
  try
    while !i < d - 1 do
      let curr = !last + !prev in
      if curr < !last (* overflow *) then raise Exit;
      m.(!i) <- curr;
      prev := !last;
      last := curr;
      incr i
    done;
    assert false
  with Exit -> m, !i


let rebalancing_height = min (max_height - 1) 60
  (** Beyond this height, implicit balance will be done.  This value
      allows gross inefficiencies while not being too time consuming.
      For example, explicit rebalancing did not really improve the
      running time on the ICFP 2007 task. *)
  (* 32 bits: max_height - 1 = 42 *)

let empty = Sub("", 0, 0)

let length = function
  | Sub(_, _, len) -> len
  | Concat(_,len,_,_,_) -> len

let height = function
  | Sub(_,_,_) -> 0
  | Concat(h,_,_,_,_) -> h

let is_empty = function
  | Sub(_, _, len) -> len = 0
  | _ -> false

let is_not_empty = function
  | Sub(_, _, len) -> len <> 0
  | _ -> true

(* For debugging purposes and judging the balancing *)
let print =
  let rec map_left = function
    | [] -> []
    | [x] -> ["/" ^ x]
    | x :: tl -> (" " ^ x) :: map_left tl in
  let map_right = function
    | [] -> []
    | x :: tl -> ("\\" ^ x) :: List.map (fun r -> " " ^ r) tl in
  let rec leaves_list = function
    | Sub(s, i0, len) -> [String.sub s i0 len]
    | Concat(_,_, l,_, r) ->
        map_left(leaves_list l) @ map_right(leaves_list r) in
  fun r -> List.iter print_endline (leaves_list r)
;;

let of_string s = Sub(s, 0, String.length s)
(* safe: string is now immutable *)

(* Since we will need to copy the string anyway, let us take this
   opportunity to split it in small chunks for easier further
   sharing.  In order to minimize the height, we use a simple
   bisection scheme. *)
let rec unsafe_of_substring s i len =
  if len <= small_rope_length then Sub(String.sub s i len, 0, len)
  else
    let len' = len / 2 in
    let i' = i + len' in
    let left = unsafe_of_substring s i len'
    and right = unsafe_of_substring s i' (len - len') in
    let h = 1 + max (height left) (height right) in
    let ll = length left in
    Concat(h, ll + length right, left, ll, right)

let of_substring s i len =
  let len_s = String.length s in
  if i < 0 || len < 0 || i > len_s - len then invalid_arg "Rope.of_substring";
  (* If only a small percentage of the string is not in the rope, do
     not cut the string in small pieces.  The case of small lengths is
     managed by [unsafe_of_substring]. *)
  if len >= len_s - (len / 10) then Sub(s, i, len)
  else unsafe_of_substring s i len

let of_char c = Sub(String.make 1 c, 0, 1)

(* Construct a rope from [n-1] copies of a call to [gen ofs len] of
   length [len = make_length] and a last call with the remainder
   length.  So the tree has [n] leaves [Sub].  The strings returned by
   [gen ofs len] may be longer than [len] of only the first [len]
   chars will be used. *)
let rec make_of_gen gen ofs len ~n =
  if n <= 1 then
    if len > 0 then Sub(gen ofs len, 0, len) else empty
  else
    let nl = n / 2 in
    let ll = nl * max_flatten_length in
    let l = make_of_gen gen ofs ll ~n:nl in
    let r = make_of_gen gen (ofs + ll) (len - ll) ~n:(n - nl) in
    Concat(1 + max (height l) (height r), len, l, ll, r)

let make_length_mask = make_length - 1

let make_n_chunks len =
  if len land make_length_mask = 0 then len lsr make_length_pow2
  else len lsr make_length_pow2 + 1

let make len c =
  if len < 0 then failwith "Rope.make: len must be >= 0";
  if len <= make_length then Sub(String.make len c, 0, len)
  else
    let base = String.make make_length c in
    make_of_gen (fun _ _ -> base) 0 len ~n:(make_n_chunks len)

let init len f =
  if len < 0 then failwith "Rope.init: len must be >= 0";
  if len <= make_length then Sub(String.init len f, 0, len)
  else
    (* Do not use String.init to avoid creating a closure. *)
    let gen ofs len =
      let b = Bytes.create len in
      for i = 0 to len - 1 do Bytes.set b i (f (ofs + i)) done;
      Bytes.unsafe_to_string b in
    make_of_gen gen 0 len ~n:(make_n_chunks len)

(* [copy_to_subbytes t ofs r] copy the rope [r] to the byte range
   [t.[ofs .. ofs+(length r)-1]].  It is assumed that [t] is long enough.
   (This function could be a one liner with [iteri] but we want to use
   [Bytes.blit_string] for efficiency.) *)
let rec copy_to_subbytes t ofs = function
  | Sub(s, i0, len) ->
      Bytes.blit_string s i0 t ofs len
  | Concat(_, _, l,ll, r) ->
      copy_to_subbytes t ofs l;
      copy_to_subbytes t (ofs + ll) r

let to_string = function
  | Sub(s, i0, len) ->
     (* Optimize when the rope hold a single string. *)
     if i0 = 0 && len = String.length s then s
     else String.sub s i0 len
  | r ->
     let len = length r in
     if len > Sys.max_string_length then
       failwith "Rope.to_string: rope length > Sys.max_string_length";
     let t = Bytes.create len in
     copy_to_subbytes t 0 r;
     Bytes.unsafe_to_string t

(* Similar to [copy_to_subbytes] do more work to allow specifying a
   range of [src]. *)
let rec unsafe_blit src srcofs dst dstofs len =
  match src with
  | Sub(s, i0, _) ->
     String.blit s (i0 + srcofs) dst dstofs len
  | Concat(_, _, l, ll, r) ->
     let rofs = srcofs - ll in
     if rofs >= 0 then
       unsafe_blit r rofs dst dstofs len
     else
       let llen = - rofs in (* # of chars after [srcofs] in the left rope *)
       if len <= llen then
         unsafe_blit l srcofs dst dstofs len
       else (* len > llen *) (
         unsafe_blit l srcofs dst dstofs llen;
         unsafe_blit r 0      dst (dstofs + llen) (len - llen);
       )

let blit src srcofs dst dstofs len =
  if len < 0 then failwith "Rope.blit: len >= 0 required";
  if srcofs < 0 || srcofs > length src - len then
    failwith "Rope.blit: not a valid range of src";
  if dstofs < 0 || dstofs > Bytes.length dst - len then
    failwith "Rope.blit: not a valid range of dst";
  unsafe_blit src srcofs dst dstofs len

(* Flatten a rope (avoids unecessary copying). *)
let flatten = function
  | Sub(_,_,_) as r -> r
  | r ->
      let len = length r in
      assert(len <= Sys.max_string_length);
      let t = Bytes.create len in
      copy_to_subbytes t 0 r;
      Sub(Bytes.unsafe_to_string t, 0, len)

let rec get rope i = match rope with
  | Sub(s, i0, len) ->
      if i < 0 || i >= len then raise(Out_of_bounds "Rope.get")
      else s.[i0 + i]
  | Concat(_,_, l, left_len, r) ->
      if i < left_len then get l i else get r (i - left_len)


let rec iter f = function
  | Sub(s, i0, len) -> for i = i0 to i0 + len - 1 do f s.[i] done
  | Concat(_, _, l,_, r) -> iter f l; iter f r

let rec iteri_rec f init = function
  | Sub(s, i0, len) ->
      let offset = init - i0 in
      for i = i0 to i0 + len - 1 do f (i + offset) s.[i] done
  | Concat(_, _, l,ll, r) ->
      iteri_rec f init l;
      iteri_rec f (init + ll) r

let iteri f r = ignore(iteri_rec f 0 r)

let rec map ~f = function
  | Sub(s, i0, len) ->
     let b = Bytes.create len in
     for i = 0 to len - 1 do
       Bytes.set b i (f (String.unsafe_get s (i0 + i)))
     done;
     Sub(Bytes.unsafe_to_string b, 0, len)
  | Concat(h, len, l, ll, r) ->
     let l = map ~f l in
     let r = map ~f r in
     Concat(h, len, l, ll, r)

let rec mapi_rec ~f idx0 = function
  | Sub(s, i0, len) ->
     let b = Bytes.create len in
     for i = 0 to len - 1 do Bytes.set b i (f (idx0 + i) s.[i0 + i]) done;
     Sub(Bytes.unsafe_to_string b, 0, len)
  | Concat(h, len, l, ll, r) ->
     let l = mapi_rec ~f idx0 l in
     let r = mapi_rec ~f (idx0 + ll) r in
     Concat(h, len, l, ll, r)

let mapi ~f r = mapi_rec ~f 0 r

(** Balancing
 ***********************************************************************)

(* Fast, no fuss, concatenation. *)
let balance_concat rope1 rope2 =
  let len1 = length rope1
  and len2 = length rope2 in
  if len1 = 0 then rope2
  else if len2 = 0 then rope1
  else
    let h = 1 + max (height rope1) (height rope2) in
    Concat(h, len1 + len2, rope1, len1, rope2)

(* Invariants for [forest]:
   1) The concatenation of the forest (in decreasing order) with the
   unscanned part of the rope is equal to the rope being balanced.
   2) All trees in the forest are balanced, i.e. [forest.(n)] is empty or
   [length forest.(n) >= min_length.(n)].
   3) [height forest.(n) <= n] *)
(* Add the rope [r] (usually a leaf) to the appropriate slot of
   [forest] (according to [length r]) gathering ropes from lower
   levels if necessary.  Assume [r] is not empty. *)
let add_nonempty_to_forest forest r =
  let len = length r in
  let n = ref 0 in
  let sum = ref empty in
  (* forest.(n-1) ^ ... ^ (forest.(2) ^ (forest.(1) ^ forest.(0)))
     with [n] s.t. [min_length.(n) < len <= min_length.(n+1)].  [n]
     is at most [max_height-1] because [min_length.(max_height) = max_int] *)
  while len > min_length.(!n + 1) do
    if is_not_empty forest.(!n) then (
      sum := balance_concat forest.(!n) !sum;
      forest.(!n) <- empty;
    );
    if !n = level_flatten then sum := flatten !sum;
    incr n
  done;
  (* Height of [sum] at most 1 greater than what would be required
     for balance. *)
  sum := balance_concat !sum r;
  (* If [height r <= !n - 1] (e.g. if [r] is a leaf), then [!sum] is
     now balanced -- distinguish whether forest.(!n - 1) is empty or
     not (see the cited paper pp. 1319-1320).  We now continue
     concatenating ropes until the result fits into an empty slot of
     the [forest]. *)
  let sum_len = ref(length !sum) in
  while !n < max_height && !sum_len >= min_length.(!n) do
    if is_not_empty forest.(!n) then (
      sum := balance_concat forest.(!n) !sum;
      sum_len := length forest.(!n) + !sum_len;
      forest.(!n) <- empty;
    );
    if !n = level_flatten then sum := flatten !sum;
    incr n
  done;
  decr n;
  forest.(!n) <- !sum

let add_to_forest forest r =
  if is_not_empty r then add_nonempty_to_forest forest r

(* Add a NON-EMPTY rope [r] to the forest *)
let rec balance_insert forest rope = match rope with
  | Sub(s, i0, len) ->
      (* If the length of the leaf is small w.r.t. the length of
         [s], extract it to avoid keeping a ref the larger [s]. *)
      if 25 * len <= String.length s then
        add_nonempty_to_forest forest (Sub(String.sub s i0 len, 0, len))
      else   add_nonempty_to_forest forest rope
  | Concat(h, len, l,_, r) ->
      (* FIXME: when to rebalance subtrees *)
      if h >= max_height || len < min_length.(h) then (
        (* sub-rope needs rebalancing *)
        balance_insert forest l;
        balance_insert forest r;
      )
      else add_nonempty_to_forest forest rope
;;

let concat_forest forest =
  let concat (n, sum) r =
    let sum = balance_concat r sum in
    (n+1, if n = level_flatten then flatten sum else sum) in
  snd(Array.fold_left concat (0,empty) forest)


let balance = function
  | Sub(s, i0, len) as r ->
      if 0 < len && len <= extract_sub_length then
        Sub(String.sub s i0 len, 0, len)
      else  r
  | r ->
      let forest = Array.make max_height empty in
      balance_insert forest r;
      concat_forest forest

(* Only rebalance on the height.  Also doing it when [length r
   < min_length.(height r)] ask for too many balancing and thus is slower. *)
let balance_if_needed r =
  if height r >= rebalancing_height then balance r else r


(** "Fast" concat for ropes.
 **********************************************************************

 * Since concat is one of the few ways a rope can be constructed, it
 * must be fast.  Also, this means it is this concat which is
 * responsible for the height of small ropes (until balance kicks in
 * but the later the better).
 *)

exception Relocation_failure (* Internal exception *)

(* Try to relocate the [leaf] at a position that will not increase the
   height.
   [length(relocate_topright rope leaf _)= length rope + length leaf]
   [height(relocate_topright rope leaf _) = height rope] *)
let rec relocate_topright rope leaf len_leaf = match rope with
  | Sub(_,_,_) -> raise Relocation_failure
  | Concat(h, len, l,ll, r) ->
      let hr = height r + 1 in
      if hr < h then
        (* Success, we can insert the leaf here without increasing the height *)
        let lr = length r in
        Concat(h, len + len_leaf, l,ll,
              Concat(hr, lr + len_leaf, r, lr, leaf))
      else
        (* Try at the next level *)
        Concat(h, len + len_leaf, l,ll,  relocate_topright r leaf len_leaf)

let rec relocate_topleft leaf len_leaf rope = match rope with
  | Sub(_,_,_) -> raise Relocation_failure
  | Concat(h, len, l,ll, r) ->
      let hl = height l + 1 in
      if hl < h then
        (* Success, we can insert the leaf here without increasing the height *)
        let len_left = len_leaf + ll in
        let left = Concat(hl, len_left, leaf, len_leaf, l) in
        Concat(h, len_leaf + len, left, len_left, r)
      else
        (* Try at the next level *)
        let left = relocate_topleft leaf len_leaf l in
        Concat(h, len_leaf + len, left, len_leaf + ll, r)


(* We avoid copying too much -- as this may slow down access, even if
   height is lower. *)
let concat2_nonempty rope1 rope2 =
  match rope1, rope2 with
  | Sub(s1,i1,len1), Sub(s2,i2,len2) ->
      let len = len1 + len2 in
      if len <= small_rope_length then
        let s = Bytes.create len in
        Bytes.blit_string s1 i1 s 0 len1;
        Bytes.blit_string s2 i2 s len1 len2;
        Sub(Bytes.unsafe_to_string s, 0, len)
      else
        Concat(1, len, rope1, len1, rope2)
  | Concat(h1, len1, l1,ll1, (Sub(s1, i1, lens1) as leaf1)), _
      when h1 > height rope2 ->
      let len2 = length rope2 in
      let len = len1 + len2
      and lens = lens1 + len2 in
      if lens <= small_rope_length then
        let s = Bytes.create lens in
        Bytes.blit_string s1 i1 s 0 lens1;
        copy_to_subbytes s lens1 rope2;
        Concat(h1, len, l1,ll1, Sub(Bytes.unsafe_to_string s, 0, lens))
      else begin
        try
          let left = relocate_topright l1 leaf1 lens1 in
          (* [h1 = height l1 + 1] since the right branch is a leaf
             and [height l1 = height left]. *)
          Concat(max h1 (1 + height rope2), len, left, len1, rope2)
        with Relocation_failure ->
          let h2plus1 = height rope2 + 1 in
          (* if replacing [leaf1] will increase the height or if further
             concat will have an opportunity to add to a (small) leaf *)
          if (h1 = h2plus1 && len2 <= max_flatten_length)
            || len2 < small_rope_length then
            Concat(h1 + 1, len, rope1, len1, flatten rope2)
          else
            (* [h1 > h2 + 1] *)
            let right = Concat(h2plus1, lens, leaf1, lens1, rope2) in
            Concat(h1, len, l1, ll1, right)
      end
  | _, Concat(h2, len2, (Sub(s2, i2, lens2) as leaf2),_, r2)
      when height rope1 < h2 ->
      let len1 = length rope1 in
      let len = len1 + len2
      and lens = len1 + lens2 in
      if lens <= small_rope_length then
        let s = Bytes.create lens in
        copy_to_subbytes s 0 rope1;
        Bytes.blit_string s2 i2 s len1 lens2;
        Concat(h2, len, Sub(Bytes.unsafe_to_string s, 0, lens), lens, r2)
      else begin
        try
          let right = relocate_topleft leaf2 lens2 r2 in
          (* [h2 = height r2 + 1] since the left branch is a leaf
             and [height r2 = height right]. *)
          Concat(max (1 + height rope1) h2, len, rope1, len1, right)
        with Relocation_failure ->
          let h1plus1 = height rope1 + 1 in
          (* if replacing [leaf2] will increase the height or if further
             concat will have an opportunity to add to a (small) leaf *)
          if (h1plus1 = h2 && len1 <= max_flatten_length)
            || len1 < small_rope_length then
            Concat(h2 + 1, len, flatten rope1, len1, rope2)
          else
            (* [h1 + 1 < h2] *)
            let left = Concat(h1plus1, lens, rope1, len1, leaf2) in
            Concat(h2, len, left, lens, r2)
      end
  | _, _ ->
      let len1 = length rope1
      and len2 = length rope2 in
      let len = len1 + len2 in
      (* Small unbalanced ropes may happen if one concat left, then
         right, then left,...  This costs a bit of time but is a good
         defense. *)
      if len <= small_rope_length then
        let s = Bytes.create len in
        copy_to_subbytes s 0 rope1;
        copy_to_subbytes s len1 rope2;
        Sub(Bytes.unsafe_to_string s, 0, len)
      else begin
        let rope1 =
          if len1 <= small_rope_length then flatten rope1 else rope1
        and rope2 =
          if len2 <= small_rope_length then flatten rope2 else rope2 in
        let h = 1 + max (height rope1) (height rope2) in
        Concat(h, len1 + len2, rope1, len1, rope2)
      end
;;


let concat2 rope1 rope2 =
  let len1 = length rope1
  and len2 = length rope2 in
  let len = len1 + len2 in
  if len1 = 0 then rope2
  else if len2 = 0 then rope1
  else begin
    if len < len1 (* overflow *) then
      failwith "Rope.concat2: the length of the resulting rope exceeds max_int";
    let h = 1 + max (height rope1) (height rope2) in
    if h >= rebalancing_height then
      (* We will need to rebalance anyway, so do a simple concat *)
      balance (Concat(h, len, rope1, len1, rope2))
    else
      (* No automatic rebalancing -- experimentally lead to faster exec *)
      concat2_nonempty rope1 rope2
  end
;;

(** Subrope
 ***********************************************************************)

(** [sub_to_substring flat j i len r] copies the subrope of [r]
    starting at character [i] and of length [len] to [flat.[j ..]]. *)
let rec sub_to_substring flat j i len = function
  | Sub(s, i0, _) ->
      Bytes.blit_string s (i0 + i) flat j len
  | Concat(_, _, l, ll, r) ->
      let ri = i - ll in
      if ri >= 0 then (* only right branch *)
        sub_to_substring flat j ri len r
      else (* ri < 0 *)
        let lenr = ri + len in
        if lenr <= 0 then (* only left branch *)
          sub_to_substring flat j i len l
        else ( (* at least one char from the left and right branches *)
          sub_to_substring flat j         i (-ri) l;
          sub_to_substring flat (j - ri)  0 lenr r;
        )

let flatten_subrope rope i len =
  assert(len <= Sys.max_string_length);
  let flat = Bytes.create len in
  sub_to_substring flat 0 i len rope;
  Sub(Bytes.unsafe_to_string flat, 0, len)
;;

(* Are lazy sub-rope nodes really needed? *)
(* This function assumes that [i], [len] define a valid sub-rope of
   the last arg.  *)
let rec sub_rec i len = function
  | Sub(s, i0, lens) ->
      assert(i >= 0 && i <= lens - len);
      Sub(s, i0 + i, len)
  | Concat(_, rope_len, l, ll, r) ->
      let rl = rope_len - ll in
      let ri = i - ll in
      if ri >= 0 then
        if len = rl then r (* => ri = 0 -- full right sub-rope *)
        else sub_rec ri len r
      else
        let rlen = ri + len (* = i + len - ll *) in
        if rlen <= 0 then (* right sub-rope empty *)
          if len = ll then l (* => i = 0 -- full left sub-rope *)
          else sub_rec i len l
        else
          (* at least one char from the left and right sub-ropes *)
          let l' = if i = 0 then l else sub_rec i (-ri) l
          and r' = if rlen = rl then r else sub_rec 0 rlen r in
          let h = 1 + max (height l') (height r') in
          (* FIXME: do we have to use this opportunity to flatten some
             subtrees?  In any case, the height of tree we get is no
             worse than the initial tree (but the length may be much
             smaller). *)
          Concat(h, len, l', -ri, r')


let sub rope i len =
  let len_rope = length rope in
  if i < 0 || len < 0 || i > len_rope - len then invalid_arg "Rope.sub"
  else if len = 0 then empty
  else if len <= max_flatten_length && len_rope >= 32768 then
    (* The benefit of flattening such subropes (and constants) has been
       seen experimentally.  It is not clear what the "exact" rule
       should be. *)
    flatten_subrope rope i len
  else sub_rec i len rope


(** String alike functions
 ***********************************************************************)

let is_space = function
  | ' ' | '\012' | '\n' | '\r' | '\t' -> true
  | _ -> false

let rec trim_left = function
  | Sub(s, i0, len) ->
     let i = ref i0 in
     let i_max = i0 + len in
     while !i < i_max && is_space (String.unsafe_get s !i) do incr i done;
     if !i = i_max then empty else Sub(s, !i, i_max - !i)
  | Concat(_, _, l, _, r) ->
     let l = trim_left l in
     if is_empty l then trim_left r
     else let ll = length l in
          Concat(1 + max (height l) (height r), ll + length r, l, ll, r)

let rec trim_right = function
  | Sub(s, i0, len) ->
     let i = ref (i0 + len - 1) in
     while !i >= i0 && is_space (String.unsafe_get s !i) do decr i done;
     if !i < i0 then empty else Sub(s, i0, !i - i0 + 1)
  | Concat(_, _, l, ll, r) ->
     let r = trim_right r in
     if is_empty r then trim_right l
     else let lr = length r in
          Concat(1 + max (height l) (height r), ll + lr, l, ll, r)

let trim r = trim_right(trim_left r)

(* Escape the range s.[i0 .. i0+len-1].  Modeled after Bytes.escaped *)
let escaped_sub s i0 len =
  let n = ref 0 in
  let i1 = i0 + len - 1 in
  for i = i0 to i1 do
    n := !n + (match String.unsafe_get s i with
               | '\"' | '\\' | '\n' | '\t' | '\r' | '\b' -> 2
               | ' ' .. '~' -> 1
               | _ -> 4)
  done;
  if !n = len then Sub(s, i0, len) else (
    let s' = Bytes.create !n in
    n := 0;
    for i = i0 to i1 do
      (match String.unsafe_get s i with
       | ('\"' | '\\') as c ->
          Bytes.unsafe_set s' !n '\\'; incr n; Bytes.unsafe_set s' !n c
       | '\n' ->
          Bytes.unsafe_set s' !n '\\'; incr n; Bytes.unsafe_set s' !n 'n'
       | '\t' ->
          Bytes.unsafe_set s' !n '\\'; incr n; Bytes.unsafe_set s' !n 't'
       | '\r' ->
          Bytes.unsafe_set s' !n '\\'; incr n; Bytes.unsafe_set s' !n 'r'
       | '\b' ->
          Bytes.unsafe_set s' !n '\\'; incr n; Bytes.unsafe_set s' !n 'b'
       | (' ' .. '~') as c -> Bytes.unsafe_set s' !n c
       | c ->
          let a = Char.code c in
          Bytes.unsafe_set s' !n '\\';
          incr n;
          Bytes.unsafe_set s' !n (Char.chr (48 + a / 100));
          incr n;
          Bytes.unsafe_set s' !n (Char.chr (48 + (a / 10) mod 10));
          incr n;
          Bytes.unsafe_set s' !n (Char.chr (48 + a mod 10));
      );
      incr n
    done;
    Sub(Bytes.unsafe_to_string s', 0, !n)
  )

let rec escaped = function
  | Sub(s, i0, len) -> escaped_sub s i0 len
  | Concat(h, _, l, _, r) ->
     let l = escaped l in
     let ll = length l in
     let r = escaped r in
     Concat(h, ll + length r, l, ll, r)

(* Return the index of [c] in [s.[i .. i1-1]] plus the [offset] or
   [-1] if not found. *)
let rec index_string offset s i i1 c =
  if i >= i1 then -1
  else if s.[i] = c then offset + i
  else index_string offset s (i+1) i1 c;;

(* Return the index of [c] from position [i] in the rope or a negative
   value if not found *)
let rec unsafe_index offset i c = function
  | Sub(s, i0, len) ->
      index_string (offset - i0) s (i0 + i) (i0 + len) c
  | Concat(_, _, l,ll, r) ->
      if i >= ll then unsafe_index (offset + ll) (i - ll) c r
      else
        let li = unsafe_index offset i c l in
        if li >= 0 then li else unsafe_index (offset + ll) 0 c r

let index_from r i c =
  if i < 0 || i >= length r then invalid_arg "Rope.index_from" else
    let j = unsafe_index 0 i c r in
    if j >= 0 then j else raise Not_found

let index_from_opt r i c =
  if i < 0 || i >= length r then invalid_arg "Rope.index_from_opt";
  let j = unsafe_index 0 i c r in
  if j >= 0 then Some j else None

let index r c =
  let j = unsafe_index 0 0 c r in
  if j >= 0 then j else raise Not_found

let index_opt r c =
  let j = unsafe_index 0 0 c r in
  if j >= 0 then Some j else None

let contains_from r i c =
  if i < 0 || i >= length r then invalid_arg "Rope.contains_from"
  else unsafe_index 0 i c r >= 0

let contains r c = unsafe_index 0 0 c r >= 0

(* Return the index of [c] in [s.[i0 .. i]] (starting from the
   right) plus the [offset] or [-1] if not found. *)
let rec rindex_string offset s i0 i c =
  if i < i0 then -1
  else if s.[i] = c then offset + i
  else rindex_string offset s i0 (i - 1) c

let rec unsafe_rindex offset i c = function
  | Sub(s, i0, _) ->
      rindex_string (offset - i0) s i0 (i0 + i) c
  | Concat(_, _, l,ll, r) ->
      if i < ll then unsafe_rindex offset i c l
      else
        let ri = unsafe_rindex (offset + ll) (i - ll) c r in
        if ri >= 0 then ri else unsafe_rindex offset (ll - 1) c l

let rindex_from r i c =
  if i < 0 || i > length r then invalid_arg "Rope.rindex_from" else
    let j = unsafe_rindex 0 i c r in
    if j >= 0 then j else raise Not_found

let rindex_from_opt r i c =
  if i < 0 || i > length r then invalid_arg "Rope.rindex_from_opt";
  let j = unsafe_rindex 0 i c r in
  if j >= 0 then Some j else None

let rindex r c =
  let j = unsafe_rindex 0 (length r - 1) c r in
  if j >= 0 then j else raise Not_found

let rindex_opt r c =
  let j = unsafe_rindex 0 (length r - 1) c r in
  if j >= 0 then Some j else None

let rcontains_from r i c =
  if i < 0 || i >= length r then invalid_arg "Rope.rcontains_from"
  else unsafe_rindex 0 i c r >= 0


(* Modified
let lowercase_ascii r = map ~f:Char.lowercase_ascii r
let uppercase_ascii r = map ~f:Char.uppercase_ascii r
let lowercase = lowercase_ascii
let uppercase = uppercase_ascii *)

let rec map1 f = function
  | Concat(h, len, l, ll, r) -> Concat(h, len, map1 f l, ll, r)
  | Sub(s, i0, len) ->
      if len = 0 then empty else begin
        let s' = Bytes.create len in
        Bytes.set s' 0 (f (String.unsafe_get s i0));
        Bytes.blit_string s (i0 + 1) s' 1 (len - 1);
        Sub(Bytes.unsafe_to_string s', 0, len)
      end

(* Modified
let capitalize_ascii r = map1 Char.uppercase_ascii r
let uncapitalize_ascii r = map1 Char.lowercase_ascii r
let capitalize = capitalize_ascii
let uncapitalize = uncapitalize_ascii *)

(** Iterator
 ***********************************************************************)
module Iterator = struct

  type t = {
    rope: rope;
    len: int; (* = length rope; avoids to recompute it again and again
                 for bound checks *)
    mutable i: int; (* current position in the rope; it is always a
                       valid position of the rope or [-1]. *)
    mutable path: (rope * int) list;
    (* path to the current leaf with global range.  First elements are
       closer to the leaf, last element is the full rope. *)
    mutable current: string; (* local cache of current leaf *)
    mutable current_g0: int;
    (* global index of the beginning of current string.
       i0 = current_g0 + offset *)
    mutable current_g1: int;
    (* global index of the char past the current string.
       len = current_g1 - current_g0 *)
    mutable current_offset: int; (* = i0 - current_g0 *)
  }


  (* [g0] is the global index (of [itr.rope]) of the beginning of the
     node we are examining.
     [i] is the _local_ index (of the current node) that we seek the leaf for *)
  let rec set_current_for_index_rec itr g0 i = function
    | Sub(s, i0, len) ->
        assert(0 <= i && i < len);
        itr.current <- s;
        itr.current_g0 <- g0;
        itr.current_g1 <- g0 + len;
        itr.current_offset <- i0 - g0
    | Concat(_, _, l,ll, r) ->
        if i < ll then set_current_for_index_rec itr g0 i l
        else set_current_for_index_rec itr (g0 + ll) (i - ll) r

  let set_current_for_index itr =
    set_current_for_index_rec itr 0 itr.i itr.rope

  let rope itr = itr.rope

  let make r i0 =
    let len = length r in
    let itr =
      { rope = balance_if_needed r;
        len = len;
        i = i0;
        path = [(r, 0)]; (* the whole rope *)
        current = ""; current_offset = 0;
        current_g0 = 0; current_g1 = 0;
        (* empty range, important if [current] not set! *)
      } in
    if i0 >= 0 && i0 < len then
      set_current_for_index itr; (* force [current] to be set *)
    itr

  let peek itr i =
    if i < 0 || i >= itr.len then raise(Out_of_bounds "Rope.Iterator.peek")
    else (
      if itr.current_g0 <= i && i < itr.current_g1 then
        itr.current.[i + itr.current_offset]
      else
        get itr.rope i (* rope get *)
    )

  let get itr =
    let i = itr.i in
    if i < 0 || i >= itr.len then raise(Out_of_bounds "Rope.Iterator.get")
    else (
      if i < itr.current_g0 || i >= itr.current_g1 then
        set_current_for_index itr; (* out of local bounds *)
      itr.current.[i + itr.current_offset]
    )

  let pos itr = itr.i

  let incr itr = itr.i <- itr.i + 1

  let decr itr = itr.i <- itr.i - 1

  let goto itr j = itr.i <- j

  let move itr k = itr.i <- itr.i + k
end

(** (In)equality
 ***********************************************************************)

exception Less
exception Greater

let compare r1 r2 =
  let len1 = length r1 and len2 = length r2 in
  let i1 = Iterator.make r1 0
  and i2 = Iterator.make r2 0 in
  try
    for _i = 1 to min len1 len2 do (* on the common portion of [r1] and [r2] *)
      let c1 = Iterator.get i1 and c2 = Iterator.get i2 in
      if c1 < c2 then raise Less;
      if c1 > c2 then raise Greater;
      Iterator.incr i1;
      Iterator.incr i2;
    done;
    (* The strings are equal on their common portion, the shorter one
       is the smaller. *)
    compare (len1: int) len2
  with
  | Less -> -1
  | Greater -> 1
;;

(* Semantically equivalent to [compare r1 r2 = 0] but specialized
   implementation for speed. *)
let equal r1 r2 =
  let len1 = length r1 and len2 = length r2 in
  if len1 <> len2 then false else (
    let i1 = Iterator.make r1 0
    and i2 = Iterator.make r2 0 in
    try
      for _i = 1 to len1 do (* len1 times *)
        if Iterator.get i1 <> Iterator.get i2 then raise Exit;
        Iterator.incr i1;
        Iterator.incr i2;
      done;
      true
    with Exit -> false
  )

(** KMP search algo
 ***********************************************************************)
let init_next p =
  let m = String.length p in
  let next = Array.make m 0 in
  let i = ref 1 and j = ref 0 in
  while !i < m - 1 do
    if p.[!i] = p.[!j] then begin incr i; incr j; next.(!i) <- !j end
    else if !j = 0 then begin incr i; next.(!i) <- 0 end else j := next.(!j)
  done;
  next

let search_forward_string p =
  if String.length p > Sys.max_array_length then
    failwith "Rope.search_forward: string to search too long";
  let next = init_next p
  and m = String.length p in
  fun rope i0 ->
    let i = Iterator.make rope i0
    and j = ref 0 in
    (try
       (* The iterator will raise an exception of we go beyond the
          length of the rope. *)
       while !j < m do
         if p.[!j] = Iterator.get i then begin Iterator.incr i; incr j end
         else if !j = 0 then Iterator.incr i else j := next.(!j)
       done;
     with Out_of_bounds _ -> ());
    if !j >= m then Iterator.pos i - m else raise Not_found


(** Buffer
 ***********************************************************************)

module Buffer = struct

  (* The content of the buffer consists of the forest concatenated in
     decreasing order plus (at the end) the part stored in [buf]:
     [forest.(max_height-1) ^ ... ^ forest.(1) ^ forest.(0)
                                                     ^ String.sub buf 0 pos]
  *)
  type t = {
    mutable buf: Bytes.t;
    buf_len: int; (* = String.length buf; must be > 0 *)
    mutable pos: int;
    mutable length: int; (* the length of the rope contained in this buffer
                            -- including the part in the forest *)
    forest: rope array; (* keeping the partial rope in a forest will
                           ensure it is balanced at the end. *)
  }

  (* We will not allocate big buffers, if we exceed the buffer length,
     we will cut into small chunks and add it directly to the forest.  *)
  let create n =
    let n =
      if n < 1 then small_rope_length else
        if n > Sys.max_string_length then Sys.max_string_length
        else n in
    { buf = Bytes.create n;
      buf_len = n;
      pos = 0;
      length = 0;
      forest = Array.make max_height empty;
    }

  let clear b =
    b.pos <- 0;
    b.length <- 0;
    Array.fill b.forest 0 max_height empty

  (* [reset] is no different from [clear] because we do not grow the
     buffer. *)
  let reset b = clear b

  let add_char b c =
    if b.length = max_int then failwith "Rope.Buffer.add_char: \
	buffer length will exceed the int range";
    if b.pos >= b.buf_len then (
      (* Buffer full, add it to the forest and allocate a new one: *)
      add_nonempty_to_forest
        b.forest (Sub(Bytes.unsafe_to_string b.buf, 0, b.buf_len));
      b.buf <- Bytes.create b.buf_len;
      Bytes.set b.buf 0 c;
      b.pos <- 1;
    )
    else (
      Bytes.set b.buf b.pos c;
      b.pos <- b.pos + 1;
    );
    b.length <- b.length + 1

  let unsafe_add_substring b s ofs len =
    (* Beware of int overflow *)
    if b.length > max_int - len then failwith "Rope.Buffer.add_substring: \
	buffer length will exceed the int range";
    let buf_left = b.buf_len - b.pos in
    if len <= buf_left then (
      (* Enough space in [buf] to hold the substring of [s]. *)
      String.blit s ofs b.buf b.pos len;
      b.pos <- b.pos + len;
    )
    else (
      (* Complete [buf] and add it to the forest: *)
      Bytes.blit_string s ofs b.buf b.pos buf_left;
      add_nonempty_to_forest
        b.forest (Sub(Bytes.unsafe_to_string b.buf, 0, b.buf_len));
      b.buf <- Bytes.create b.buf_len;
      b.pos <- 0;
      (* Add the remaining of [s] to to forest (it is already
         balanced by of_substring, so we add is as such): *)
      let s = unsafe_of_substring s (ofs + buf_left) (len - buf_left) in
      add_nonempty_to_forest b.forest s
    );
    b.length <- b.length + len

  let add_substring b s ofs len =
    if ofs < 0 || len < 0 || ofs > String.length s - len then
      invalid_arg "Rope.Buffer.add_substring";
    unsafe_add_substring b s ofs len

  let add_string b s = unsafe_add_substring b s 0 (String.length s)

  let add_rope b (r: rope) =
    if is_not_empty r then (
      let len = length r in
      if b.length > max_int - len then failwith "Rope.Buffer.add_rope: \
	buffer length will exceed the int range";
      (* First add the part hold by [buf]: *)
      add_to_forest b.forest (Sub(Bytes.sub_string b.buf 0 b.pos, 0, b.pos));
      b.pos <- 0;
      (* I thought [balance_insert b.forest r] was going to rebalance
         [r] taking into account the content already in the buffer but
         it does not seem faster.  We take the decision to possibly
         rebalance when the content is asked. *)
      add_nonempty_to_forest b.forest r; (* [r] not empty *)
      b.length <- b.length + len
    )
  ;;

  let add_buffer b b2 =
    if b.length > max_int - b2.length then failwith "Rope.Buffer.add_buffer: \
	buffer length will exceed the int range";
    add_to_forest b.forest (Sub(Bytes.sub_string b.buf 0 b.pos, 0, b.pos));
    b.pos <- 0;
    let forest = b.forest in
    let forest2 = b2.forest in
    for i = Array.length b2.forest - 1 to 0 do
      add_to_forest forest forest2.(i)
    done;
    b.length <- b.length + b2.length
  ;;

  let add_channel b ic len =
    if b.length > max_int - len then failwith "Rope.Buffer.add_channel: \
	buffer length will exceed the int range";
    let buf_left = b.buf_len - b.pos in
    if len <= buf_left then (
      (* Enough space in [buf] to hold the input from the channel. *)
      really_input ic b.buf b.pos len;
      b.pos <- b.pos + len;
    )
    else (
      (* [len > buf_left]. Complete [buf] and add it to the forest: *)
      really_input ic b.buf b.pos buf_left;
      add_nonempty_to_forest
        b.forest (Sub(Bytes.unsafe_to_string b.buf, 0, b.buf_len));
      (* Read the remaining from the channel *)
      let len = ref(len - buf_left) in
      while !len >= b.buf_len do
        let s = Bytes.create b.buf_len in
        really_input ic s 0 b.buf_len;
        add_nonempty_to_forest
          b.forest (Sub(Bytes.unsafe_to_string s, 0, b.buf_len));
        len := !len - b.buf_len;
      done;
      (* [!len < b.buf_len] to read, put them into a new [buf]: *)
      let s = Bytes.create b.buf_len in
      really_input ic s 0 !len;
      b.buf <- s;
      b.pos <- !len;
    );
    b.length <- b.length + len
  ;;

  (* Search for the nth element in [forest.(i ..)] of total length [len] *)
  let rec nth_forest forest k i len =
    assert(k <= Array.length forest);
    let r = forest.(k) in (* possibly empty *)
    let ofs = len - length r in (* offset of [r] in the full rope *)
    if i >= ofs then get r (i - ofs)
    else nth_forest forest (k + 1) i ofs

  let nth b i =
    if i < 0 || i >= b.length then raise(Out_of_bounds "Rope.Buffer.nth");
    let forest_len = b.length - b.pos in
    if i >= forest_len then Bytes.get b.buf (i - forest_len)
    else nth_forest b.forest 0 i forest_len
  ;;

  (* Return a rope, [buf] must be duplicated as it becomes part of the
     rope, thus we duplicate it as ropes are immutable.  What we do is
     very close to [add_nonempty_to_forest] followed by
     [concat_forest] except that we do not modify the forest and we
     select a sub-rope.  Assume [len > 0] -- and [i0 >= 0]. *)
  let unsafe_sub (b: t) i0 len =
    let i1 = i0 + len in (* 1 char past subrope *)
    let forest_len = b.length - b.pos in
    let buf_i1 = i1 - forest_len in
    if buf_i1 >= len then
      (* The subrope is entirely in [buf] *)
      Sub(Bytes.sub_string b.buf (i0 - forest_len) len, 0, len)
    else begin
      let n = ref 0 in
      let sum = ref empty in
      if buf_i1 > 0 then (
        (* At least one char in [buf] and at least one in the forest.
           Concat the ropes of inferior length and append the part of [buf] *)
        let rem_len = len - buf_i1 in
        while buf_i1 > min_length.(!n + 1) && length !sum < rem_len do
          sum := balance_concat b.forest.(!n) !sum;
          if !n = level_flatten then sum := flatten !sum;
          incr n
        done;
        sum := balance_concat
                 !sum (Sub(Bytes.sub_string b.buf 0 buf_i1, 0, buf_i1))
      )
      else (
        (* Subrope in the forest.  Skip the forest elements until
           the last chunk of the sub-rope is found.  Since [0 < len
           <= forest_len], there exists a nonempty rope in the forest. *)
        let j = ref buf_i1 in (* <= 0 *)
        while !j <= 0 do j := !j + length b.forest.(!n); incr n done;
        sum := sub b.forest.(!n - 1) 0 !j (* init. with proper subrope *)
      );
      (* Add more forest elements until we get at least the desired length *)
      while length !sum < len do
        assert(!n < max_height);
        sum := balance_concat b.forest.(!n) !sum;
(* FIXME: Check how this line may generate a 1Mb leaf: *)
(*         if !n = level_flatten then sum := flatten !sum; *)
        incr n
      done;
      let extra = length !sum - len in
      if extra = 0 then !sum else sub !sum extra len
    end

  let sub b i len =
    if i < 0 || len < 0 || i > b.length - len then
      invalid_arg "Rope.Buffer.sub";
    if len = 0 then empty
    else (unsafe_sub b i len)

  let contents b =
    if b.length = 0 then empty
    else (unsafe_sub b 0 b.length)


  let length b = b.length
end


(* Using the Buffer module should be more efficient than sucessive
   concatenations and ensures that the final rope is balanced. *)
let concat sep = function
  | [] -> empty
  | r0 :: tl ->
      let b = Buffer.create 1 in (* [buf] will not be used as we add ropes *)
      Buffer.add_rope b r0;
      List.iter (fun r -> Buffer.add_rope b sep; Buffer.add_rope b r) tl;
      Buffer.contents b


(* Modified *)

(** Input/output -- modeled on Pervasive
 ***********************************************************************)

(* Imported from pervasives.ml: *)
let rec output_string fh = function
  | Sub(s, i0, len) -> output fh (Bytes.unsafe_of_string s) i0 len
  | Concat(_, _, l,_, r) -> output_string fh l; output_string fh r
;;

let output_rope = output_string

let print_string rope = output_string stdout rope
let print_endline rope = output_string stdout rope; print_newline()

let prerr_string rope = output_string stderr rope
let prerr_endline rope = output_string stderr rope; prerr_newline()


(**/**)
let rec number_leaves = function
  | Sub(_,_,_) -> 1
  | Concat(_,_, l,_, r) -> number_leaves l + number_leaves r

let rec number_concat = function
  | Sub(_,_,_) -> 0
  | Concat(_,_, l,_, r) -> 1 + number_concat l + number_concat r

let rec length_leaves = function
  | Sub(_,_, len) -> (len, len)
  | Concat(_,_, l,_, r) ->
      let (min1,max1) = length_leaves l
      and (min2,max2) = length_leaves r in
      (min min1 min2, max max1 max2)


module IMap = Map.Make(struct
  type t = int
  let compare = Pervasives.compare
end)

let distrib_leaves =
  let rec add_leaves m = function
    | Sub(_,_,len) ->
        (try incr(IMap.find len !m)
          with _ -> m := IMap.add len (ref 1) !m)
    | Concat(_,_, l,_, r) -> add_leaves m l; add_leaves m r in
  fun r ->
    let m = ref(IMap.empty) in
    add_leaves m r;
    !m


(**/**)

(** Toplevel
 ***********************************************************************)

module Rope_toploop = struct
  open Format

  let max_display_length = ref 400
    (* When displaying, truncate strings that are longer than this. *)

  let ellipsis = ref "..."
    (* ellipsis for ropes longer than max_display_length.  User changeable.  *)

  (* Return [max_len - length r].  *)
  let rec printer_lim max_len (fm:formatter) r =
    if max_len > 0 then
      match r with
      | Concat(_,_, l,_, r) ->
          let to_be_printed = printer_lim max_len fm l in
          printer_lim to_be_printed fm r
      | Sub(s, i0, len) ->
          let l = if len < max_len then len else max_len in
          (match escaped_sub s i0 l with
           | Sub (s, i0, len) ->
              if i0 = 0 && len = String.length s then pp_print_string fm s
              else for i = i0 to i0 + len - 1 do
                     pp_print_char fm (String.unsafe_get s i)
                   done
           | Concat _ -> assert false);
          max_len - len
    else max_len

  let printer fm r =
    pp_print_string fm "\"";
    let to_be_printed = printer_lim !max_display_length fm r in
    pp_print_string fm "\"";
    if to_be_printed < 0 then pp_print_string fm !ellipsis
end

(** Regexp
 ***********************************************************************)

module Regexp = struct
  (* FIXME: See also http://www.pps.jussieu.fr/~vouillon/ who is
     writing a DFA-based regular expression library.  Would be nice to
     cooperate. *)

end


;;
(* Local Variables: *)
(* compile-command: "make -k -C.." *)
(* End: *)
