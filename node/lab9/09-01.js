let http = require('http');

let options = {
    host:'localhost',
    path: '/task1',
    port: 5000,
    method: 'GET'
}

let req = http.request(options, (res) => {
    console.log(`http.response: StatusCode ${res.statusCode}`);
    console.log(`http.response: StatusMessage ${res.statusMessage}`);
    console.log(`http.response: Server IP ${res.socket.remoteAddress}`);
    console.log(`http.response: Server Port ${res.socket.remotePort}`);

    let body = '';
    res.on('data', (chunk) => {
        body += chunk;
    })
    res.on('end', () => {
        console.log(`body: ${body}`);
    })
})

req.on('error', e => {
    console.log(`error: ${e}`);
})
req.end();