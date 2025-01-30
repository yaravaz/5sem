let http = require('http');
let xmlbuilder = require('xmlbuilder');

let xml = xmlbuilder.create('request').att('id', 33);
xml.ele('x').att('value', 1);
xml.ele('x').att('value', 2);
xml.ele('x').att('value', 3);
xml.ele('m').att('value', 'a');
xml.ele('m').att('value', 'b');
xml.ele('m').att('value', 'c');

let options = {
    host:'localhost',
    path: '/task5',
    port: 5000,
    method: 'POST',
    headers: {'Content-Type': 'application/xml', 'Accept': 'application/xml'}
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

req.write(xml.toString({pretty: true}));

req.end();