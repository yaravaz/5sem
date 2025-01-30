http = require('http');

let curState = "norm";

http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end(`<h1>${curState}</h1>`);
}).listen(5000);

console.log('http://localhost:5000');

process.stdin.setEncoding('utf8');
process.stdout.write(curState + "->");
process.stdin.on('readable', () => {
    let state = null;
    while((state = process.stdin.read()) !== null) {
        switch (state.trim()) {
            case "exit":
                process.exit(0);
            case "norm":
            case "idle":
            case "stop":
            case "test":
                process.stdout.write("reg = " + curState + "--> " + state);
                curState = state.trim();
                break;
            default:
                process.stdout.write(state);
        }
        process.stdout.write(curState + "->");
    }
});