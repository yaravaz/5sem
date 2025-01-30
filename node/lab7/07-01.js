let http = require('http');
let stat = require('./m07_01')('./static');

let http_handler = (req, res) => {
    if     (stat.isStatic('html', req.url)) stat.sendFile(req, res, {'Content-Type': 'text/html; charset=utf-8'});
    else if(stat.isStatic('css',  req.url)) stat.sendFile(req, res, {'Content-Type': 'text/css; charset=utf-8'});
    else if(stat.isStatic('js',   req.url)) stat.sendFile(req, res, {'Content-Type': 'text/js; charset=utf-8'});
    else if(stat.isStatic('png',  req.url)) stat.sendFile(req, res, {'Content-Type': 'image/png'});
    else if(stat.isStatic('docx', req.url)) stat.sendFile(req, res, {'Content-Type': 'application/msword'});
    else if(stat.isStatic('json', req.url)) stat.sendFile(req, res, {'Content-Type': 'application/json'});
    else if(stat.isStatic('xml',  req.url)) stat.sendFile(req, res, {'Content-Type': 'application/xml'});
    else if(stat.isStatic('mp4',  req.url)) stat.sendFile(req, res, {'Content-Type': 'video/mp4'});
    else stat.writeHTTP404(res);
}

server = http.createServer();
server.listen(3000, (v) => {console.log('server.listen(3000)')})
      .on('error',  (e) => {console.log('server.listen(3000): error: ', e.code)})
      .on('request', http_handler);