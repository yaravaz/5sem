http = require('http');
database = require('./DB');
fs = require('fs');
url = require('url');

let db = new database.DB();

let timeoutShutdown;
let timeCommit;
let timeStats;
let requestNumber = 0;
let commitNumber = 0;
let timeS = null;
let timeE = null;
let statFlag = false;

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

let handleCommand = (command) => {
    let [cmd, param] = command.split(" ");

    switch(cmd){
        case 'sd':{
            let timeout = Number(param);
            clearTimeout(timeoutShutdown);

            if(!isNaN(timeout)){
                timeoutShutdown = setTimeout(() => {
                    server.close(() => {
                        console.log("Сервер выключен");
                        process.exit(0)
                    })
                }, timeout * 1000).ref();
                console.log(`Сервер будет выключен через ${timeout} секунд`)
            } else {
                console.log('Отмена остановки сервера')
            }
            break;
        }

        case 'sc': {
            let time = Number(param);
            clearInterval(timeCommit);

            if(!isNaN(time)){
                timeCommit = setInterval(async () => {
                    await db.commit();
                    if(statFlag) commitNumber++;
                }, time * 1000).unref()
                console.log("работает автокомит");
            } else {
                console.log("автокомит отключен");
            }
            break;
        }

        case 'ss': {
            
            let time = Number(param);
            clearTimeout(timeStats);
            if(!isNaN(time)){
                statFlag = true;
                requestNumber = 0;
                commitNumber = 0;
                console.log('начало сбора статистики');
                timeS = new Date();
                timeStats = setTimeout(() => {
                    console.log("сбор статистики окончен");
                    statFlag = false;
                }, time * 1000)
            }
            else{
                clearTimeout(timeStats);
            }
            timeE = new Date();

            break;
        }
    }
}
process.stdin.setEncoding('utf8');

process.stdin.on('data', data => {
    let command = data.toString().trim();
    handleCommand(command);
})

let server = http.createServer((req, res) => {
    if(statFlag){
        requestNumber++;
    }
    
    if (url.parse(req.url).pathname === '/') {
        let html = fs.readFileSync("./05-01.html", 'utf8');
        res.writeHead(200, {'Content-Type': 'text/html; charset=utf8'});
        res.end(html);
    } else if (url.parse(req.url).pathname === "/api/db") {
        db.emit(req.method, req, res);
    } else if (url.parse(req.url).pathname === "/api/ss" && req.method === 'GET'){
        let stats = {
            startT: timeS ? timeS.toISOString() : '',
            endT: timeE ? timeE.toISOString() : '',
            requestNumber,
            commitNumber
        }
        res.writeHead(200, {'Content-Type': 'text/html; charset=utf8'});
        res.end(JSON.stringify(stats));
    }
}).listen(5000, () => console.log("http://localhost:5000"));