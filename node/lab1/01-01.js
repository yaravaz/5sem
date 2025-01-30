let http = require('http')

http.createServer((request, response) => {
    response.writeHead(200, {'Content-Type': 'text/html'});
    response.end('<h3>Hello World</h3>');
}).listen(3000)

console.log('http://localhost:3000/');