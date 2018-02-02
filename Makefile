.PHONY: test bamboo clean

bamboo:
	npm run build

install:
	npm install
	opam switch 4.02.3+buckle-master
	eval `opam config env`
	# It's important to install batteries first, so the proper version of rpc can be installed afterwards
	git clone https://github.com/bsansouci/batteries-included ./node_modules/batteries-included
	cd ./node_modules/batteries-included && opam pin add -y batteries . && cd ../..
	opam install -y ocamlfind menhir rope zarith ppx_deriving rpc=1.9.52 cryptokit hex

doc/spec.pdf: doc/spec.tex
	(cd doc; pdflatex -halt-on-error spec.tex; pdflatex -halt-on-error spec.tex)

test:
	(cd src; sh ./run_tests.sh)

clean:
	npm run clean
