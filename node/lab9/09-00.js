let http = require('http');
let url = require('url');
let parseString = require('xml2js').parseString;
let xmlbuilder = require('xmlbuilder');
let fs = require('fs');
let formidable = require('formidable');
let mp = require('multiparty');
let path = require('path');

let server = http.createServer((req, res) => {
    let task = url.parse(req.url).pathname.split('/')[1];

    switch(task){
        case '':
            res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
            res.end('<p>There are no tasks</p>');
            break;
        case 'task1':
            res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
            res.end('');
            break;
        case 'task2':
            res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
            let X = url.parse(req.url, true).query.x;
            let Y = url.parse(req.url, true).query.y;

            res.end(`<p>task 2: x = ${X}, y = ${Y}</p>`);
            break;
        case 'task3':
            let body = '';

            req.on('data', (chunk) => {
                body += chunk;
            });
            req.on('end', () => {
                res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
                res.end(` ${body}`);
            })
            break;
        case 'task4':{
            let body = '';
            req.on('data', (chunk) => {
                body += chunk;
            });
            req.on('end', () => {
                body = JSON.parse(body);
                res.writeHead(200, {'Content-type': 'application/json; charset=utf-8'});
                let comment = 'Ответ. Лабораторная работа 8/10';
                let resp = {};
                resp.__comment = comment;
                resp.x_plus_y = body.x + body.y;
                resp.Concatenation_s_o = body.s + ': ' + body.o.surname + ', ' + body.o.name;
                resp.Length_m = body.m.length;
                res.end(JSON.stringify(resp));
            });
            break;
        }
        case 'task5': {
            let body = '';
            req.on('data', (chunk) => {
                body += chunk;
            });
            req.on('end', () => {
                parseString(body, (err, result) => {
                    res.writeHead(200, {'Content-type': 'application/xml'});
                    let id = result.request.$.id;
                    let sum = 0;
                    let mess = '';
                    result.request.x.forEach((p) => {
                        sum += parseInt(p.$.value);
                    });
                    result.request.m.forEach((p) => {
                        mess += p.$.value;
                    });

                    let xml = xmlbuilder.create('response')
                    .att('id', +result.request.$.id + 5)
                    .att('request', result.request.$.id);
                    xml.ele('sum', {element: 'x', sum: `${sum}`});
                    xml.ele('concat', {element: 'm', result: `${mess}`});
                    let rc = xml.toString({pretty: true});
                    
                    res.end(rc);
                });
            });
            break;
        }
        case 'task6': {
            let form = new formidable.IncomingForm();

            form.parse(req, (err, fields, files) => {
                if (err) {
                    res.writeHead(400, { 'Content-Type': 'text/plain' });
                    res.end('Error parsing the file.');
                    return;
                }

                let oldPath = files.myFile[0].filepath
                let newPath = './MyFile2.txt';

                fs.copyFile(oldPath, newPath, (err) => {
                    if (err) {
                        res.writeHead(500, { 'Content-Type': 'text/plain' });
                        res.end(`Error saving the file ${err}`);
                        return;
                    }
    
                    fs.unlink(oldPath, (err) => {
                        if (err) {
                            console.error('Error deleting temporary file:', err);
                        }
                        console.log('File received and saved as MyFile2.txt');
                        res.writeHead(200, { 'Content-Type': 'text/plain' });
                        res.end('File received successfully.');
                    });
                });
            });
            break;
        }
        case 'task7':
            let result = '';
            let form = new mp.Form({uploadDir: './static'});

            form.on('field', (name, field) => {
                console.log(field);
                result += `'${name}' = ${field}`;
            });

            form.on('file', (name, file) => {
                console.log(name, file);
                result += `'${name}': Original filename – ${file.originalFilename}, Filepath – ${file.path}`;
            });

            form.on('error', (err) => {
                res.writeHead(500, {'Content-Type': 'text/html'});
                console.log('error', err.message);
                res.end('Form error.');
            });

            form.on('close', () => {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write('Form data:');
                res.end(result);
            });

            form.parse(req);
            break;
        case 'task8': 
            res.writeHead(200, {'Content-Type': 'text/html'});
            let file = fs.readFileSync("./static/MyFileSer.txt");
            res.end(file);
            break;

    }
});


server.listen(5000, () => console.log('http://localhost:5000'));