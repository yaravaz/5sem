let WebSocket = require('ws');
let param = process.argv[2];
let clientName = typeof param == 'undefined' ? 'default' : param;

let wsc = new WebSocket('ws://localhost:4000/');

wsc.on('open', () => {
    wsc.on('message', msg => {
        console.log('message ', msg.toString());
    })

    wsc.send(JSON.stringify({client: clientName, timestamp: new Date().toISOString()}, null, 2));
})

wsc.on('error', err => {console.log('error ', err)});