open Geo
open Tortue
open Lsysteme
  
let (entete : out_channel -> int -> int -> unit) = fun chan w h ->
  output_string chan "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<svg  xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"" ;
  output_string chan (string_of_int w) ;
  output_string chan "\" height=\"" ;
  output_string chan (string_of_int h) ;
  output_string chan "\" stroke=\"black\">\n" ;  
;;

let (fin : out_channel -> unit) = fun chan ->
  output_string chan "</svg>\n"
;;


let (dessin_seg : out_channel -> segment -> unit) = fun sort (p1,p2) ->
  output_string sort "<path d= \"M " ;
  output_string sort (string_of_float (p1.x)) ;
  output_string sort "," ;
  output_string sort (string_of_float (p1.y)) ;
  output_string sort " " ;
  output_string sort (string_of_float (p2.x)) ;
  output_string sort ",";
  output_string sort (string_of_float (p2.y)) ;
  output_string sort "\"/> \n";
;;

let rec (dessin: out_channel -> lseg -> unit) = fun sort ls ->
  match ls with
  |[] -> ()
  |seg::fin -> dessin_seg sort seg; dessin sort fin;;


