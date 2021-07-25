TOPFILE = Hanoi
OCAMLC = ocamlfind c
OCAMLOPT = ocamlfind opt
OCAMLDEP = ocamlfind dep
SOURCES = Hanoi.ml2mk.ml HanoiD.ml
MLSOURCES = $(filter-out %.ml2mk.ml, $(SOURCES))
MKSOURCES = $(filter %.ml2mk.ml, $(SOURCES))
# -dsource --- dump a text *after* camlp5 extension
CAMLP5 = -syntax camlp5o -package GT-p5,OCanren.syntax,GT.syntax.all 
PXFLAGS = $(CAMLP5)
BFLAGS = -rectypes -g -package GT,OCanren 
OFLAGS = $(BFLAGS) -inline 10
NOCANREN = noCanren
NOCFLAGS =

all: .depend $(TOPFILE) $(TOPFILE).byte

.depend: $(SOURCES)
	$(OCAMLDEP) $(PXFLAGS) *.ml > .depend

$(TOPFILE): $(MKSOURCES:.ml2mk.ml=.cmx) $(MLSOURCES:.ml=.cmx)
	$(OCAMLOPT) -o $(TOPFILE) $(OFLAGS) $(LIBS:.cma=.cmxa) -linkpkg $^

$(TOPFILE).byte:  $(MKSOURCES:.ml2mk.ml=.cmo) $(MLSOURCES:.ml=.cmo)
	$(OCAMLC) -o $(TOPFILE).byte $(BFLAGS) $(LIBS) -linkpkg $^

clean:
	rm -Rf *.cmi *.cmo *.cmx *.annot *.o *.opt *.byte *~ .depend $(TOPFILE)

-include .depend

# generic rules

###############
%.ml: %.ml2mk.ml
	$(NOCANREN) $(NOCFLAGS) -o $@ $<

%.cmi: %.mli
	$(OCAMLC) -c $(BFLAGS) $(PXFLAGS) $<

# Note: cmi <- mli should go first
%.cmi: %.ml 
	$(OCAMLC) -c $(BFLAGS) $(PXFLAGS) $<

%.cmo: %.ml
	$(OCAMLC) -c $(BFLAGS) $(PXFLAGS) $<

%.o: %.ml
	$(OCAMLOPT) -c $(OFLAGS) $(STATIC) $(PXFLAGS) $<

%.cmx: %.ml
	$(OCAMLOPT) -c $(OFLAGS) $(STATIC) $(PXFLAGS) $<

