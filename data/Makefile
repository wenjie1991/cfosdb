Run:
	cp ../../data/*.tsv ./
	Rscript ./to_json.R
	raku ./import.pl6

clean:
	rm ./cFosDB.db
	rm ./*.json
