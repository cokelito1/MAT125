#!/bin/bash
for i in *.tex; do
	[ -f "$i" ] || break
	pdflatex "$i"
done
tar -zcf tareas.tar.gz *.pdf
