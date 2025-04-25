const http = require('http');

let project = process.env.PROJECT_NAME || 'demo';

console.log(`🚙 Redirecting to project: ${project}`);

const server = http.createServer((req, res) => {
  // Set status code to 302 (temporary redirect)
  res.writeHead(302, {
    'Location': `http://localhost:3500/?folder=/home/workspace/${project}`
  });
  res.end();
});

const PORT = process.env.REDIRECTION_HTTP_PORT || 3501;
server.listen(PORT, () => {
  console.log(`🌍 Redirect server running on port ${PORT}`);
});