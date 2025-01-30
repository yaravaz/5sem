const http = require('http');
const fs = require('fs');
const FormData = require('form-data');

const form = new FormData();
form.append('myFile', fs.createReadStream('MyFile.txt'));

const options = {
    host: 'localhost',
    path: '/task6',
    port: 5000,
    method: 'POST',
    headers: form.getHeaders()
};

const req = http.request(options, (res) => {
    res.on('data', (chunk) => {
        console.log(`Body: ${chunk.toString()}`);
    });
});

req.on('error', (err) => {
    console.error(`Error: ${err.message}`);
});

form.pipe(req);