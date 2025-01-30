http = require('http');
database = require('./DB');
fs = require('fs');
url = require('url');

let db = new database.DB();

db.on('GET', (req, res) => {
    db.select().then(data => {
        res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
        res.end(JSON.stringify(data));
    });
})

db.on('POST', (req, res) => {
    req.on('data', data => {
        let c = JSON.parse(data);
        let pattern = /(\d{2})\-(\d{2})\-(\d{4})/;

        if (c.id === '' || c.name === '' || c.dbay === ''){
            res.writeHead(400, {'Content-Type': 'application/json; charset=utf-8'});
            res.end(JSON.stringify({error: 'Заполните все поля'}));
            return;
        }

        let new_date = c.bday.replace(pattern,'$3-$2-$1');

        if (!(new Date(new_date) <= new Date())){
            res.writeHead(400, {'Content-Type': 'application/json; charset=utf-8'});
            res.end(JSON.stringify({error: 'Некорретная дата дня рождения'}));
            return;
        }

        db.insert(c).then(data => {
            res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
            res.end(JSON.stringify(data));
        }).catch(error => {
            res.writeHead(400, {'Content-Type': 'application/json; charset=utf-8'});
            res.end(JSON.stringify(error));
        });
    });
});

db.on('PUT', (req, res) => {
    let data = ''
    req.on('data', str =>{
       data += str
    });

    req.on('end', () => {
        let c = JSON.parse(data);
        let pattern = /(\d{2})\-(\d{2})\-(\d{4})/;

        if (c.id === '' || c.name === '' || c.dbay === ''){
            res.writeHead(400, {'Content-Type': 'application/json; charset=utf-8'});
            res.end(JSON.stringify({error: 'Заполните все поля'}));
            return;
        }

        let new_date = c.bday.replace(pattern,'$3-$2-$1');

        if (!(new Date(new_date) <= new Date())){
            res.writeHead(400, {'Content-Type': 'application/json; charset=utf-8'});
            res.end(JSON.stringify({error: 'Некорретная дата дня рождения'}));
            return;
        }

        db.update(c).then(data => {
            res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
            res.end(JSON.stringify(data));
        }).catch(error => {
            res.writeHead(400, {'Content-Type': 'application/json; charset=utf-8'});
            res.end(JSON.stringify(error));
        });
    });
});

db.on('DELETE', (req, res) => {
    const query = url.parse(req.url, true).query;
    const id = query.id;

    if (!id) {
        res.writeHead(400, {'Content-Type': 'application/json; charset=utf-8'});
        res.end(JSON.stringify({error: 'Поля не могут быть пустыми'}));
        return;
    }

    db.delete(id).then((data) => {
        res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
        res.end(JSON.stringify(data));
    }).catch(error => {
        res.writeHead(400, {'Content-Type': 'application/json; charset=utf-8'});
        res.end(JSON.stringify(error));
    });
});

http.createServer((req, res) => {
    if (url.parse(req.url).pathname === '/') {
        let html = fs.readFileSync("./04-01.html", 'utf8');
        res.writeHead(200, {'Content-Type': 'text/html; charset=utf8'});
        res.end(html);
    } else if (url.parse(req.url).pathname === "/api/db") {
        db.emit(req.method, req, res);
    }
}).listen(5000, () => console.log("http://localhost:5000"));