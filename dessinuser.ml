open Geo
open Tortue
open Lsysteme

#load "dynlink.cma";;
#load "camlp4o.cma";;

(* position initiale de la tortue , avec les segments enregistrés initialement à [] *) 
let (tortinit: tortue)  = ({x=0.5;y=0.},pi/.2.);;
let (lseginit: lseg) = [];;

(* Récupère la chaine de caractères entrée par l'utilisateur*)
print_string "Entrez la figure de départ caractères autorisés: F + - [ ] \n";;
let (str1:string) = read_string ();;
(* Transforme la chaine en flot  *)
let (flt1: char Stream.t) = Stream.of_string str;;
(* Transforme  le flot dans la grammaire utilisée (en une motif list) *) 
let (seq_user: sequence) = flot_to_seq flt;;

(*  *) 

(* Récupère la chaine de caractères entrée par l'utilisateur*)
print_string "Entrez la transformation sur F souhaitée: il faut au moins deux [ ]  et au moins une rotation  ,  caractères autorisés: F + - [ ] \n";;
let (str2:string) = read_string ();;
(* Transforme la chaine en flot  *)
let (flt2: char Stream.t) = Stream.of_string str;;
(* Transforme  le flot dans la grammaire utilisée (en une motif list) *) 
let (ax_user: sequence) = flot_to_seq flt;;
(* créé la règle correspondante si l'axiome est correct*) 
assert(checkbon ax_user 0 0 = true);;
let (reg_user: regle) = (F, ax_user) 

  
print_string "Entrez le nombre de fois ou vous voulez appliquer la règle (4 max) \n";;
let nb = read_int ();;w
let (sreg_user : sequence) = regrec seq_user reg_user nb;;


let (fig_user:figure)= (0.025,pi/.4. , sreg_user);;
(* fournit la liste de segments nécessaires pour l'affichage*)
let (lseg_user: lseg) = fourniseg fig_user (tortinit,lseginit);;
(* transformation des segments en surface pour affichage *)
let (surf_user: surface list)  = lseg_to_surf lseg_user;;

(* affichage a partir du module aff *) 
let () =  Aff.draw "ESSAI" surf_user;;
