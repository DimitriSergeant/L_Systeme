open Geo
open Tortue
open Lsysteme

let (tortinit: tortue)  = ({x=0.5;y=0.1},pi/.2.);;
let (lseginit: lseg) = [];;


let (axiomeauto : axiomefinal) =  verifgene [] false;;;;
let (seqauto: sequence) = [F];;
let (regauto: regle) = (F, axiomeauto);;
let (fauto : sequence) = regrec seqauto regauto 3;;
let (figauto: figure)= (0.1 , pi/.4. , fauto);;


let (lsegauto: lseg) = fourniseg figauto (tortinit,lseginit);;
let (surfauto: surface list)  = lseg_to_surf lsegauto;;



let () =  Aff.draw "ESSAI" surfauto;;
