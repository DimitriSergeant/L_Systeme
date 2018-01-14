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

(* sequence une fois la regle applique nb fois (nb demandé a l'utilisateur)  *)
print_string "Entrez le nombre de fois ou vous voulez appliquer la règle (4 max) \n";;
let nb = read_int ();;
let (sregramif : sequence) = regrec seqramif regramif nb;;
(* figure comportant la longue des traits, l'angle de rotation et la sequence générée au dessus *)
let (figramif:figure)= (0.025,pi/.4. , sregramif);;
(* fournit la liste de segments nécessaires pour l'affichage*)
let (lsegramif: lseg) = fourniseg figramif (tortinit,lseginit);;
(* transformation des segments en surface pour affichage *)
let (surframif: surface list)  = lseg_to_surf lsegramif;;

(* affichage a partir du module aff *) 
let () =  Aff.draw "ESSAI" surframif;;


(* (*ecriture dans un fichier svg *)  
let fich = open_out "dessinramif.svg";;
entete fich 500 500;
dessin fich lsegramif;
fin fich;;
*)
