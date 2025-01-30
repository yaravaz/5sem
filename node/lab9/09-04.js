let http = require('http');

const json = JSON.stringify({
    "__comment": "Запрос. Лабораторная работа 8/10",
    "x": 1,
    "y": 2,
    "s": "Сообщение",
    "m": ["a", "b", "c", "d"],
    "o": { "surname": "Иванов", "name": "Иван"}
});

let options = {
    host:'localhost',
    path: '/task4',
    port: 5000,
    method: 'POST',
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
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

req.end(json);