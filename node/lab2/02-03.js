let http = require('http');

http.createServer((req, res) => {
    if (req.url === "/api/name" && req.method === 'GET') {
        res.writeHead(200, {"Content-Type": "text/plain; charset=utf-8;"});
        res.end("Вовна Ярослава Руслановна");
    } else {
        res.writeHead(404, {"Content-Type": "text/html; charset=utf-8;"});
        res.end("<h2>404 Not found</h2>");
    }
}).listen(5000);

console.log("http://localhost:5000/api/name");