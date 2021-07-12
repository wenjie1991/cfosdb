Run:
	cp ../data_preparation/*.tsv ./
	Rscript ./to_json.R
	raku ./import.pl6
	cp ./*.json ../frontend/src/assets/

clean:
	rm ./cFosDB.db
	rm ./*.json
