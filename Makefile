SLIDES := $(patsubst %.md,%.pdf,$(wildcard *.md))

all : $(SLIDES) $(HANDOUTS)

%.pdf : %.md
	pandoc $^  -H header.incl --pdf-engine=xelatex -t beamer --slide-level 2 -o $@

clobber :
	rm -f $(SLIDES)
