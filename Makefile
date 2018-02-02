.PHONY: test bamboo clean

bamboo:
	npm run build

doc/spec.pdf: doc/spec.tex
	(cd doc; pdflatex -halt-on-error spec.tex; pdflatex -halt-on-error spec.tex)

test:
	(cd src; sh ./run_tests.sh)

clean:
	npm run clean
