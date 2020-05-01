var http = require('http');
var url = require('url');
var sqlite3 = require('sqlite3').verbose();
var zlib = require('zlib');

http.createServer(function(req, res) {
    res.writeHead(200, {'Content-Type': 'application/json'});
    var output_json = new Array();
    var db = new sqlite3.Database('../data/cFosDB.db');

    let sql = `SELECT * FROM brain_area_annotation`;

    db.all(sql, [], (err, rows) => {
        if (err) {
            throw err;
        }
        rows.forEach((row) => {
            // console.log(row);
            output_json.push(row);
        });
        var buf = new Buffer(JSON.stringify(output_json), "utf-8");
        zlib.gzip(buf, function (_, result) {  // The callback will give you the result
            res.writeHead(200, {
                'Content-Type': 'application/json', 
                'Access-Control-Allow-Origin':'*',
                'Content-Encoding': 'gzip'
            });
            res.end(result);                     // result, so just send it.
        });
    });

    // close the database connection
    db.close();
}).listen(8080);

