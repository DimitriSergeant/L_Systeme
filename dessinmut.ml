open Geo
open Tortue
open Lsysteme

(* position initiale de la tortue , avec les segments enregistrés initialement à [] *) 
let (tortinit: tortue)  = ({x=0.5;y=0.},pi/.2.);;
let (lseginit: lseg) = [];;


(* sequence de depart pour la ramification *)
let (seqramif: sequence) = [F];;
(* regle pour la ramification *)
let (regramif : regle) = (F, [F;Cr([P;F]);F;Cr([M;F]);F]);;

(* sequence une fois la regle applique nb fois (nb demandé à l'utilisateur) *)
print_string "Entrez le nombre de fois ou vous voulez appliquer la règle (4 max) \n";;
let nb = read_int ();;
let (sregramif : sequence) = regrec seqramif regramif nb;;

(* Génère la sequence  a partir de la sequence de ramification a laquelle on a appliqué une mutation avec un probabilité p demandée à l'utilisateur*) 
print_string "Entrez la probabilité de la mutation souhaitée (entre 0. et 1.) \n";;
let p = read_float ();;
let (ramifmut: sequence) = mutation p sregramif;;

(* figure comportant la longue des traits, l'angle de rotation et la sequence générée au dessus *)
let (figmut: figure)= (0.05 , pi/.4. , ramifmut);;

(* fournit la liste de segments nécessaires pour l'affichage*)
let (lsegmut: lseg) = fourniseg figmut (tortinit,lseginit);;

(* transformation des segments en surface pour affichage *)
let (surfmut: surface list)  = lseg_to_surf lsegmut;;

 
(* affichage a partir du module aff *) 
let () =  Aff.draw "ESSAI" surfmut;;
