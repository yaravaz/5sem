let http = require('http');

let getHeaders = (request) => {
    let headers = '';
    for(let i in request.headers){
        headers += '<h5>' + i + '| ' + request.headers[i] + '</h5>';
    }
    return headers;
}

http.createServer((request, response) => {
    let body = '';
    request.on('data', (data) => {
        body += data;
    })

    response.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
    request.on('end', () =>
        response.end(
            '<!DOCTYPE html>' +
            '<html lang="ru">' +
            '<head>' +
            '<title></title>' +
            '</head>' +
            '<body>' +
            '<h2>Содержимое запроса:</h2>' +
            '<h3>метод - ' + request.method + '</h3>' +
            '<h3>uri - ' + request.url + '</h3>' +
            '<h3>версия - ' + request.httpVersion + '</h3>' +
            '<h3>заголовки - ' + getHeaders(request) + '</h3>' +
            '<h3>тело: ' + body + '</h3>' +
            '</body>' +
            '</html>'
        ))
}).listen(3000)

console.log('http://localhost:3000/');

