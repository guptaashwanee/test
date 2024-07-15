const express = require("express");
const { createServer } = require("http");
const app = express();

const server = createServer(app);

server.listen(9090, () => {
  console.log("Listening on PORT: 9090");
});
