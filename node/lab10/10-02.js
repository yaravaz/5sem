let WebSocket = require('ws');

let ws = new WebSocket('ws:/localhost:4000/wsserver');

let n = 0;

ws.on('open', () => {
    let intervalId = setInterval(() => {ws.send(`10-01-client: ${++n}`);}, 3000);
    setTimeout(() => {clearInterval(intervalId); ws.close()}, 25000);
})

ws.onclose = (e) => {console.log('onclose')};
ws.onmessage = (m) => {console.log('onmessage', m.data)};
ws.onerror = (err) => {console.log('Error: ' + err.message)};