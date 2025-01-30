let http = require('http');
let fs = require('fs');

let bound = '---bound--';
let body = `--${bound}\r\n`;
body += 'Content-Disposition: form-data; name="file"; filename="MyFile.png"\r\n';
body += 'Content-Type: image/png\r\n\r\n';

let options = {
    host:'localhost',
    path: '/task7',
    port: 5000,
    method: 'POST',
    headers: { 'Content-Type': `multipart/form-data; boundary=${bound}` }
}

const req = http.request(options, (res) => {
    let data = '';

    res.on('data', chunk => { console.log(`Response body (data): ${data += chunk.toString('utf8')}`); });

    res.on('end', () => {
        console.log(`Response body (end): ${data}\n`);
        console.log(`Response body length: ${Buffer.byteLength(data)}\n`);
    });
});


req.write(body);
let stream = new fs.ReadStream('./static/MyFile.png');
stream.on('data', chunk => {
    req.write(chunk);
    console.log('chunk length = ', Buffer.byteLength(chunk));
})
stream.on('end', () => { req.end(`\r\n--${bound}--`); })

req.on('error', e => { console.log(`${e.message}\n\n`); })