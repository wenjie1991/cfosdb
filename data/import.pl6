use DB::SQLite;
use JSON::Fast;

my $sqlite-db = DB::SQLite.new(filename => 'cFosDB.db', busy-timeout => 50000);
#my $db = $sqlite-db.db;

my $table-name;
my $json-str;
my $create-table;

# deposit brain_area_annotation
$table-name = "brain_area_annotation";
$json-str = slurp "./clean_brain_area_annotation.json";
$create-table = qq:to/END/;
DROP TABLE IF EXISTS $table-name; 
CREATE TABLE brain_area_annotation (
	brain_code text primary key,
	main	text,
	long_1	text,
	short_1	text,
    long_2	text,
	short_2	text,
    long_3	text,
	short_3	text,
	species text
);
END
import-json($json-str, $create-table, $table-name);


# deposit brain_area_behavior
$table-name = "brain_area_behavior";
$json-str = slurp "./clean_behavior_brain_area.json";
$create-table = qq:to/END/;
DROP TABLE IF EXISTS $table-name; 
CREATE TABLE $table-name (
	brain_code    text,
	behavior      text,
	species       text,
	gender        text,
	doi           text,
	condition     text,
    figure        text,
    cell_type     text
);
END
import-json($json-str, $create-table, $table-name);


sub import-json($json-str, $create-table, $table-name) {
#    say $json-str;
	my $data2import = from-json $json-str;

	$sqlite-db.execute($create-table);

	my %record = $data2import[0];
	my @header = %record.keys;
#    say @header;
#    say %record{@header};


	my $db = $sqlite-db.db;
	my $sth = $db.prepare(qq:to/END/);
		insert into $table-name ({@header.join(",")}) values ({("?" xx @header.elems).join(",")});
	END
	$db.begin;
	$data2import.map(-> %r { $sth.execute(%r{@header}) });
	$db.commit;
	$db.finish;
}

