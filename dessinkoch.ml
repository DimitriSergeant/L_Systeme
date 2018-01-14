open Geo
open Tortue
open Lsysteme



(* position initiale de la tortue , avec les segments enregistrés initialement à [] *) 
let (tortinit: tortue)  = ({x=0.2;y=0.2},pi/.2.);;
let (lseginit: lseg) = [];;

(* sequence de depart pour koch *) 
let (seqkoch:sequence)= [F;M;M;F;M;M;F];;

(* regle pour koch *)
let (regkoch : regle) = (F, [F;P;F;M;M;F;P;F]);;
(* sequence une fois la regle applique nb *)
print_string "Entrez le nombre de fois ou vous voulez appliquer la règle  \n";;
let nb = read_int ();;
let (sregkoch : sequence) = regrec seqkoch regkoch nb;;						   
(* figure comportant la longueur des traits, l'angle de rotation et la sequence générée au dessus *)
let (figkoch:figure)=  (0.02,pi/.3. , sregkoch);;

(* fournit la liste de segments nécessaires pour l'affichage*)
let (lsegkoch: lseg) = fourniseg figkoch (tortinit,lseginit);;
(* transformation des segments en surface pour affichage *)
let (surfkoch: surface list)  = lseg_to_surf lsegkoch;;

(* affichage a partir du module aff *) 
let () =  Aff.draw "ESSAI" surfkoch;;




(*


Partie non réussie


 (*ecriture dans un fichier svg *)  
let fich = open_out "dessinkoch.svg";;
entete fich 500 500;
dessin fich lsegkoch;
fin fich;;
*)
