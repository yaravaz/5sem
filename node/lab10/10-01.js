let http = require('http');
let WebSocket = require('ws');

let server = http.createServer((req, res) => {
    if(req.method === 'GET' && req.url == '/start'){
        res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
        res.end(require('fs').readFileSync('10-01.html'));
    }
    else if(req.url !== '/favicon.ico') {
        res.writeHead(400, {'Content-Type': 'text/html; charset-utf-8'});
        res.end('<p>Not suitable request</p>');
    }
})

server.listen(3000, () => console.log('http://localhost:3000/start'));

let n = 0;
let wsserver = new WebSocket.Server({port: 4000, host: 'localhost', path: '/wsserver'});
wsserver.on('connection', (ws) => {
    let k;
    ws.on('message', message => {
        let msg = message.toString();
        console.log(msg);
        k = msg.split(' ')[1];
    })
    
    let intervalId = setInterval(() => {ws.send(`10-01-server: ${k}->${++n}`)}, 5000);

    ws.on('close', () => {clearInterval(intervalId);});
})
wsserver.on('error', (e) => {console.log(`error: ${e}`)});
setTimeout(() => {wsserver.close();}, 25000);
console.log(`ws server: host - ${wsserver.options.host}, port - ${wsserver.options.port}, path - ${wsserver.options.path}`);