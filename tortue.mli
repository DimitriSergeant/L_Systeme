open Geo
  
type angle = float;;
type tortue = point * angle;;
type segment = point * point;;
type lseg = segment list;;

val avancer: tortue -> float -> tortue;;
val radian: float -> float;;
val degre: float -> float;;
val tourner: tortue -> angle -> tortue;;
val ajouter: tortue*lseg -> float -> tortue* lseg;;
val lseg_to_surf: lseg-> surface list;;

