open Tortue
open Geo


#load "dynlink.cma";;
#load "camlp4o.cma";;


type motif  = |F 
	      |M 
	      |P 
	      |Cr of motif list;;  
type sequence = motif list;;
type figure = float * angle * sequence;;
type axiomeinit = motif;;
type axiomefinal = motif list;;
type regle = axiomeinit * axiomefinal;;

val fourniseg: figure -> tortue*lseg -> lseg;;
val applireg: sequence -> regle -> sequence;;
val regrec: sequence -> regle -> int -> sequence;;
val remove_last: axiomefinal -> axiomefinal;;
val last_elem: axiomefinal -> motif;;
val checkbon: axiomefinal -> int -> int -> bool;;
val auxautogenere: axiomefinal -> int -> motif -> axiomefinal;;
val autogenere: axiomefinal;;
val verifgene: axiomefinal -> bool -> axiomefinal;;

val mutation: float -> sequence -> sequence;;

val flot_to_seq: char Stream.t -> motif list;; 
