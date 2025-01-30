let http = require('http');
let query = require('querystring');

let parms = query.stringify({x:3, y:4, s:'xxx'});

let options = {
    host:'localhost',
    path: '/task3',
    port: 5000,
    method: 'POST'
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

req.write(parms);
req.end();