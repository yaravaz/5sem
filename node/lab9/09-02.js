let http = require('http');
let query = require('querystring');

let parms = query.stringify({x:3, y:4});
let path = `/task2?${parms}`;

let options = {
    host:'localhost',
    path: path,
    port: 5000,
    method: 'GET'
}

let req = http.request(options, (res) => {
    let data = '';
    console.log(`http.response: StatusCode ${res.statusCode}`);
    res.on('data', (chunk) => {
        console.log('res.body: ', data += chunk.toString('utf-8'));
    });
});
req.on('error', e => {
    console.log(`error: ${e}`);
})
req.end();