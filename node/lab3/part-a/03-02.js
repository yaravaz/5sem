http = require('http');
url = require('url');

let factorial = (k) => {
    return k <= 1 ? k : k * factorial(k - 1);
};

http.createServer((req, res) => {
    let path = url.parse(req.url).pathname;
    if (path === '/fact' && req.method === 'GET') {
        let param = url.parse(req.url, true).query.k;
        if (typeof param !== 'undefined') {
            let k = parseInt(param, 10);
            if (Number.isInteger(k)) {
                res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
                res.end(JSON.stringify({k: k, fact: factorial(k)}))
            }
        }
    } else {
        res.writeHead(404, {'Content-Type': 'text/html; charset=utf-8'});
        res.end('<h1>404 Not found</h1>')
    }
}).listen(5000);

console.log('http://localhost:5000');