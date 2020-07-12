import http from 'http';
import url from 'url';
import sqlite3 from 'sqlite3';
import zlib from 'zlib';
// add the "type": "module" in "package.json"

http.createServer(function(req, res) {
    // request
    var urlParsed = url.parse(req.url, true);
    var behavior = urlParsed['query']["behavior"];
    var brain_code = urlParsed['query']["brain_code"];
    var gender = urlParsed['query']["gender"];
    var species = urlParsed['query']["species"];

    // console.log(urlParsed['query']);
    res.writeHead(200, {
        'Content-Type': 'application/json', 
        'Access-Control-Allow-Origin':'*',
        'Content-Encoding': 'gzip'
    });

    try {
        var db = new sqlite3.Database('../data/cFosDB.db');
        behavior = behavior.split(',');
        brain_code = brain_code.split(',');
        let sql = `SELECT * FROM brain_area_behavior JOIN brain_area_annotation ON brain_area_behavior.brain_code = brain_area_annotation.brain_code 
    WHERE	
    brain_area_behavior.behavior IN ("` + behavior.join('","') + `") 
        AND 
    brain_area_annotation.brain_code IN ("` + brain_code.join('","') + `") 
        AND
    brain_area_annotation.species = ?
        AND
    brain_area_behavior.gender like ?`;

        var output_json = new Array();

        db.all(sql, [species, gender], (err, rows) => {
            if (err) {
                res.end()
            } else {
                rows.forEach((row) => {
                    output_json.push(row);
                });
                var buf = new Buffer(JSON.stringify(output_json), "utf-8");
                zlib.gzip(buf, function (_, result) {  // The callback will give you the result
                    res.end(result);                     // result, so just send it.
                });
            }
        });
    } 
    catch(err) {
        console.error(err);
        res.end()
    }

    // close the database connection
    db.close();

}).listen(8081);
