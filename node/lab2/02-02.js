let http = require('http');
let fs = require('fs');

http.createServer((req, res) => {
    if (req.url === '/png' && req.method == 'GET') {
        const fileName = './pic.png';
        let png = null;

        fs.stat(fileName, (err, stats) => {
            if (err) {
                console.error('error:', err);
            } else {
                png = fs.readFileSync(fileName);
                res.writeHead(200, {'Content-Type': 'image/png', 'Content-Length': stats.size});
                res.end(png, 'binary');
            }
        })
    } else {
        res.writeHead(404, {"Content-Type": "text/html; charset=utf-8;"});
        res.end("<h2>404 Not found</h2>");
    }
}).listen(5000);

console.log("http://localhost:5000/png");