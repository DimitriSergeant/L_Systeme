open Geo
  
type angle = float;;
type tortue = point * angle;;
type segment = point * point;;
type lseg = segment list;;



(* Fonction tourner qui prend en argument une tortue (point,angle) et un angle, et qui change l'angle de la tortue *)
let (avancer: tortue -> float -> tortue) = fun (p,a) dist ->
  ({x = p.x +. dist *. cos(a); y = p.y +. dist *. sin(a)},a);;


(* convertion d'un angle en degrés vers radians *) 
let (radian: float -> float) = fun x ->
  x*. pi /. 180.;; 

assert(radian 90. = pi/.2.);;

(* convertion d'un angle en radians vers degrés *) 
let (degre: float -> float) = fun x ->
  x*.180. /. pi;; 

assert(degre pi/.2. = 90.);;


(* Fonction tourner qui prend en argument une tortue (point,angle) et un angle, et qui change l'angle de la tortue *) 
let (tourner: tortue -> angle -> tortue)= fun (p,a) ang ->
  (p, a-.ang);;

(* ne pas tourner garder angle de la tortue *) 
let (ajouter: tortue*lseg -> float -> tortue*lseg) = fun (t,l) dist ->
  let ({x=xi;y=yi},a) = t in let ({x=xf;y=yf},a) = avancer t  dist in
 ({x=xf;y=yf},a),[{x=xi;y=yi},{x=xf;y=yf}]@l ;;

(* transforme notre lseg en surface list*) 
let rec (lseg_to_surf: lseg -> surface list)=fun l ->
  match l with
  |[] -> []
  |(p1,p2)::fin -> Line(p1,p2)::(lseg_to_surf fin);;



(*test réalisés pendant le codage grace aux fonctions d'affichage données dans aff  *) 
let tortinit = ({x=0.;y=0.},0.);;
let lseginit = [];;
let (t2,l2) = ajouter (tortinit,lseginit) 1.;;
let (t3,l3) = ajouter (t2,l2) 0.5;;
let line = lseg_to_surf l3;;





