(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)
type attr =  Parsetree.attribute
type t =  attr list

type ('a,'b) st =
  { get : 'a option ;
    set : 'b option }

val process_method_attributes_rev :
  t ->
  (bool * bool , [`Get | `No_get ]) st * t

type attr_kind = 
  | Nothing 
  | Meth_callback of attr 
  | Uncurry of attr  
  | Method of attr

val process_attributes_rev :
  t -> attr_kind * t

val process_pexp_fun_attributes_rev :
  t -> bool * t

val process_bs :
  t -> bool * t

val external_needs_to_be_encoded :
  t -> bool

val has_inline_in_stru : 
  t -> 
  bool

val has_inline_payload_in_sig :
  t ->
  attr option 

type derive_attr = {
  explict_nonrec : bool;
  bs_deriving : Ast_payload.action list option
}


val iter_process_bs_string_int_unwrap_uncurry :
  t -> 
  [`Nothing | `String | `Int | `Ignore | `Unwrap | `Uncurry of int option ]


val iter_process_bs_string_as :
  t -> string option

val iter_process_bs_string_as_ast :   
  t -> 
  Parsetree.expression option
  
val has_bs_optional :
  t -> bool 

val iter_process_bs_int_as :
  t -> int option


val iter_process_bs_string_or_int_as :
    t ->
    [ `Int of int
    | `Str of string
    | `Json_str of string  ] option


val process_derive_type :
  t -> derive_attr * t

val iter_process_derive_type :
  t -> derive_attr


val bs : attr
val is_bs : attr -> bool



val bs_get : attr
val bs_get_arity : attr 
val bs_set : attr
val bs_return_undefined : attr

val deprecated : string -> attr
