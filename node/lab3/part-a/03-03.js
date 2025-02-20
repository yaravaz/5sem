http = require('http');
fs = require('fs');
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
    }
    else if (path === '/') {
        let html = fs.readFileSync('./03-03.html', 'utf8');
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end(html);
    }
}).listen(5000);

console.log('http://localhost:5000');