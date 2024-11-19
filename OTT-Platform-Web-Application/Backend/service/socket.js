const ws = require("ws");
const wsServer = new ws.Server({ noServer: true });
let sockets = [];
wsServer.on("connection", (socket) => {
  sockets.push(socket);
  socket.on("message", (message) => {
    console.log("messagess", message);

    // setTimeout(() => {
    //   socket.send('meee');
    // }, 2000);
  });
});

module.exports = { sockets, wsServer };
