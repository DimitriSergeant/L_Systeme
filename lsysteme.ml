open Tortue
open Geo

#load "dynlink.cma";;
#load "camlp4o.cma";;


(* Grammaire utilisée pour la réalisation des actions*) 
type motif  = |F (*Avancer*)
	      |M (*Tourner a droite*)
	      |P (*Tourner a gauche*)
	      |Cr of motif list;; (* Les crochets *) 

(* Sequence qui va se représenter comme ceci: [F;M;F;Cr([F;P]);P;F] par exemple *) 
type sequence = motif list;;

(* type figure prend une distance: float qui représente la distance de tracé d'un F
 angle: float qui représente l'angle de rotation réalisé par un P ou un M
 la sequence qui est la liste de motif à réaliser *) 
type figure = float * angle * sequence;;

(* axiomeinit et axiomefinal sont respectivement les membres gauche et droit d'une regle*) 
type axiomeinit = motif;;
type axiomefinal = motif list;;
(* une regle est un couple qui a un motif associe une motif liste*)
type regle = axiomeinit * axiomefinal;;


(*Fonction qui prend en arguments une figure, une tortue et un liste de segments et qui renvoie un list de segments
A partir de la sequence insl, de la distance dist et de l'angle ang donnés, deplace la tortue tor, tout en ajoutant chaque segment 
  a la liste de segments l *)
(* Exemple : fourniseg   (1. , pi/.4. , [F;F])  (({x=0.5;y=0.},pi/.2.),[]) = [({x=0.5;y=0.},{x=0.5;y=1.});({x=5.;y=1.},{x=5.;y=2.})]    *) 
let rec (fourniseg: figure -> tortue*lseg -> lseg )= fun (dist,ang,insl) (tor,l) ->
  match insl with
  |[] -> l
  |Cr(ml)::s -> let tsave=tor in (fourniseg (dist,ang,ml) (tsave,l))@(fourniseg (dist,ang,s) (tor,l))
  |F::s -> let (tor2,ls2) = ajouter (tor,l) dist  in fourniseg (dist,ang,s) (tor2,ls2)       
  |P::s -> let tor2 = tourner tor (-1. *. ang) in fourniseg (dist,ang,s) (tor2,l)
  |M::s -> let tor2 = tourner tor ang in fourniseg (dist,ang,s) (tor2,l);;



(*Fonction qui prend en arguments une sequence et une regle et qui renvoie une sequence a laquelle on a appliqué la regle *)
(* Exemple : applireg [F;F] (F,[F;P;F])  = [F;P;F;F;P;F]     *)
let rec (applireg: sequence -> regle -> sequence)= fun seq (gauche,droit) ->
  match seq with
  |[] -> [] 
  |F::s -> if (gauche = F) then droit@(applireg s (gauche,droit))
      else F::(applireg s (gauche,droit)) 
  |P::s -> if (gauche = P) then droit@( applireg s (gauche,droit))
      else P::(applireg s (gauche,droit))
  |M::s -> if (gauche = M) then droit@( applireg s (gauche,droit))
    else M::(applireg s (gauche,droit))
  |Cr(ml)::s -> if (gauche = Cr(ml)) then droit@( applireg s (gauche,droit))
      else Cr(applireg ml (gauche,droit))::(applireg s (gauche,droit));;   



(*Fonction qui prend en arguments une sequence une regle et un entier n et qui renvoie une sequence a laquelle on a appliqué n fois la regle *)
(* Exemple : regrec [F;F] (F,[F;P;F]) 1 = [F;P;F;F;P;F]  
   regrec [F;F] (F,[F;P;F]) 2 = regrec [F;P;F;F;P;F] (F,[F;P;F]) 1 *)
let rec  (regrec: sequence -> regle -> int -> sequence)= fun seq r1 n ->
  if (n>0) then regrec (applireg seq r1) r1 (n-1)
else seq;; 




(************************
(* Fonction qui ne prend aucun argument et qui génère aléatoirement un motif *)
let (generemotif: axiomeinit) =
  Random.self_init(); let n = Random.int 4 in
  match n with
  |0 -> F
  |1 -> P
  |2 -> M
  |3 -> Cr([]);;
*************************)

(* Fonction qui retire le dernier element d'un axiomefinal (motif list)  *)
let rec (remove_last: axiomefinal -> axiomefinal) = fun ax ->
  match ax with
  |[] -> []
  |a::[] -> []
  |a::s -> a::(remove_last s) 
;;

(* Fonction qui renvoie le dernier element d'un axiomefinal (motif list)  *)
let rec (last_elem: axiomefinal -> motif) = fun ax ->
  match ax with
  |[] -> F
  |a::[] -> a
  |a::s -> last_elem s 
;;
  
(* Fonction qui prend un axiome final en argument ainsi que deux entiers qui représentent les compteurs de Cr et de P et M et retourne true s'il y a au moins 2 Cr et 3 P ou M dans l'axiomefinal *)
let rec(checkbon: axiomefinal -> int -> int -> bool) = fun ax cptcr cptrot ->
  match ax with
  |[] -> false
  |F::s -> checkbon s cptcr cptrot
  |Cr(x)::s -> cptcr = cptcr + 1; if(cptcr > 2 && cptrot > 1) then true
    else checkbon s cptcr cptrot
  |P::s -> cptrot = cptrot +1; if(cptcr > 2 && cptrot > 1) then true
    else checkbon s cptcr cptrot
  |M::s -> cptrot = cptrot +1; if(cptcr > 2 && cptrot > 1) then true
    else checkbon s cptcr cptrot ;;


(* Fonction qui prend en argument un axiomefinale, un entier nb et un motif  et retourne un axiome final
   Tant que nb est différent de 0 on génère aléatoirement un motif. 
   le motif elemprec sert a verifier qu'on ne génère pas un axiome possédant: P;M ou l'inverse, si c'est le cas on appelle last_elem et remove_last afin de ne pas générer de motifs inutils
*)
(*Exemple: auxautogenere [F] 2 F = [F;P;F] *)
let rec (auxautogenere: axiomefinal -> int ->  motif -> axiomefinal) = fun ax nb elemprec ->
 if (nb<=0) then ax
 else let r = (Random.int 4) in 
   match r with
   | 0 -> auxautogenere (ax@[F]) (nb - 1) F 
   | 1 -> if elemprec = M then
       let n_ax = remove_last ax in auxautogenere n_ax (nb+1) (last_elem n_ax) else auxautogenere (ax@[P]) (nb-1) P
   | 2 -> if elemprec = P then let n_ax= remove_last ax in auxautogenere n_ax (nb+1) (last_elem n_ax) else auxautogenere (ax@[M]) (nb-1) M
   | 3 -> if (nb>2) then 
       let sousn = 1+Random.int nb-1 in
       let sousax = auxautogenere [] sousn elemprec in
       auxautogenere (ax@[Cr(sousax)]) (nb-sousn-1) F
     else auxautogenere ax nb elemprec
       
   |_ -> ax;;


(* Fonction qui ne prend pas d'arguments et qui crée un axiomefinal :
appel de auxautogenere avec un n aléatoire entre 15 et 35 ici*) 
let (autogenere: axiomefinal)=
   let nbmotif = 15 + Random.int 15 in
   auxautogenere [] nbmotif F;;


(* Fonction qui test si l'axiomefinal généré possède au moins deux Cr() et 3 rotations P ou M
Si non alors appelle a nouveau autogenere jusqu'a ce que l'axiomefinal généré soit bon*)
let rec (verifgene: axiomefinal -> bool -> axiomefinal)= fun ax b->
  match b with
  |true -> ax
  |false -> let sgene = autogenere in verifgene sgene (checkbon sgene 0 0);;













(*Fonction qui prend une probabilité p:float et une sequence seq et qui retourne une sequence 
On applique une transformation d'un P en M ou d'un M en P avec une probabilité p passée en argument
*) 
let rec (mutation: float -> sequence -> sequence)= fun p seq ->
  Random.self_init(); let r = Random.float 1. in 
  match seq with
  |[] -> []
  |F::s -> F::(mutation p s) 
  |Cr(ml)::s -> Cr(mutation p ml)::(mutation p s) 
  |P::s -> if(r>p) then P::(mutation p s)
      else M::(mutation p s) 
  |M::s -> if(r>p) then M::(mutation p s)
    else P::(mutation p s);;
 




(* fonction qui prend un flot de char et qui retourne une motif list correspondant a notre grammaire *) 
let rec (flot_to_seq: char Stream.t -> motif list) =
  parser  
	     |[<''F' ; y = flot_to_seq >] -> F::y 
	     |[<''+' ; y = flot_to_seq >] -> P::y
	     |[<''-'; y = flot_to_seq >] -> M::y
	     |[<''['; danscr = flot_to_seq ; '']' ; y = flot_to_seq >] -> Cr(danscr)::y 
	     |[< >]  -> [];;

