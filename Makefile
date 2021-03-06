# ENVIRONMENT
INCLUDES=-I +lablGL
LABLGLCMAS=lablgl.cma lablglut.cma unix.cma

# BUILD RULES
all: dessinramif dessinkoch dessinauto dessinmut dessinuser


dessinkoch: aff.cmo geo.cmo tortue.cmo lsysteme.cmo  dessinkoch.cmo    
	ocamlc $(INCLUDES) $(LABLGLCMAS) geo.cmo aff.cmo tortue.cmo lsysteme.cmo  dessinkoch.cmo -o dessinkoch   

dessinkoch.cmo: dessinkoch.ml aff.cmo geo.cmo tortue.cmo  lsysteme.cmo 
	ocamlc -c dessinkoch.ml

dessinramif: aff.cmo geo.cmo tortue.cmo lsysteme.cmo dessinramif.cmo 
	ocamlc $(INCLUDES) $(LABLGLCMAS) geo.cmo aff.cmo tortue.cmo lsysteme.cmo  dessinramif.cmo -o dessinramif 

dessinramif.cmo: dessinramif.ml aff.cmo geo.cmo tortue.cmo  lsysteme.cmo 
	ocamlc -c dessinramif.ml

dessinauto: aff.cmo geo.cmo tortue.cmo lsysteme.cmo  dessinauto.cmo
	ocamlc $(INCLUDES) $(LABLGLCMAS) geo.cmo aff.cmo tortue.cmo lsysteme.cmo  dessinauto.cmo -o dessinauto 

dessinauto.cmo: dessinauto.ml aff.cmo geo.cmo tortue.cmo  lsysteme.cmo
	ocamlc -c dessinauto.ml

dessinmut: aff.cmo geo.cmo tortue.cmo lsysteme.cmo  dessinmut.cmo
	ocamlc $(INCLUDES) $(LABLGLCMAS) geo.cmo aff.cmo tortue.cmo lsysteme.cmo  dessinmut.cmo -o dessinmut  

dessinmut.cmo: dessinmut.ml aff.cmo geo.cmo tortue.cmo  lsysteme.cmo 
	ocamlc -c dessinmut.ml


dessinuser: aff.cmo geo.cmo tortue.cmo lsysteme.cmo dynlink.cma camlp4o.cma  dessinuser.cmo 
	ocamlc $(INCLUDES) $(LABLGLCMAS) geo.cmo aff.cmo tortue.cmo lsysteme.cmo  dessinuser.cmo -o dessinmut  

dessinuser.cmo: dessinuser.ml aff.cmo geo.cmo tortue.cmo  lsysteme.cmo dynlink.cma camlp4o.cma
	ocamlc -c dessinuser.ml






geo.cmi: geo.mli
	ocamlc -c geo.mli
geo.cmo: geo.ml geo.cmi
	ocamlc -c geo.ml

aff.cmi: aff.mli geo.cmi
	ocamlc -c aff.mli
aff.cmo: aff.cmi geo.cmo
	ocamlc $(INCLUDES) -c aff.ml



tortue.cmi: tortue.mli geo.cmi
	ocamlc -c tortue.mli
tortue.cmo: tortue.ml tortue.cmi geo.cmi
	ocamlc -c tortue.ml


lsysteme.cmi: lsysteme.mli tortue.cmi geo.cmi dynlink.cma camlp4o.cma
	ocamlc -c lsysteme.mli
lsysteme.cmo: lsysteme.ml lsysteme.cmi tortue.cmi geo.cmi dynlink.cma camlp4o.cma
	ocamlc -c lsysteme.ml


#ecriture_svg.cmi: ecriture_svg.mli lsysteme.cmi tortue.cmi geo.cmi
#	ocamlc -c ecriture_svg.mli
#ecriture_svg.cmo: ecriture_svg.ml lsysteme.cmi tortue.cmi geo.cmi
#	ocamlc -c ecriture_svg.ml

clean:
	rm -f *.cmi *.cmo *~
