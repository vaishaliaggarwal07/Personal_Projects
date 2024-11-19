const ws = require("ws");

const client = new ws("ws://localhost:4000");

client.on("open", () => {
  // Causes the server to print "Hello"
  client.send("Hello");
});
