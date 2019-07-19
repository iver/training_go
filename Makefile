SHELL := bash
ACTUAL := $(shell pwd)
PKGNAME := golang.tar.gz
THEME := minion
CONFIG := config.toml

export ACTUAL
export SOURCE

help:
	@echo -e "Golang Training. \n\nComandos disponibles:"
	@echo -e "\tmake install\t Instala el proyecto"
	@echo -e "\tmake start\t Inicia la presentación"
	@echo -e "\tmake debug\t Ejecuta el proyecto en modo debug"
	@echo -e "\tmake clean\t Limpia el proyecto"

install:
	@./bash/install.sh

start:
	@hugo server --verbose \
		--logFile=log/build.log \
		--buildDrafts \
		--enableGitInfo \
		-t ${THEME} &
	open http://localhost:1313/;

debug:
	@hugo server --verbose \
		--logFile=log/build.log \
		--buildDrafts \
		--enableGitInfo \
		--watch \
		-t ${THEME};

clean:
	@rm -rf htdocs ${PKGNAME} public;

package:
	@hugo -t ${THEME} -v -d htdocs;
	@./bash/set-version.sh;
	@minify -r -o htdocs/ --match=\.js htdocs;
	@tar -czf ${PKGNAME} htdocs;
	@rm -r htdocs;
	@echo "Package done! ... you can run deploy.sh script from yout host machine."

deploy:
	@./bash/deploy.sh;

export:
	@hugo -t ${THEME} -v -d htdocs;
