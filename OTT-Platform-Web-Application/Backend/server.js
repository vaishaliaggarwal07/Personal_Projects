const mongoose = require("mongoose");
const express = require("express");
const cors = require("cors"); // Import the cors middleware
const {wsServer} = require("./service/socket");
require("dotenv").config();

process.on("uncaughtException", (err) => {
    console.log("UNCAUGHT EXCEPTION! 💥 Shutting down...");
    console.log(err.name, err.message);
    process.exit(1);
});

const app = require("./app");

/*

mongoose
  .connect(process.env.DATABASE, {
    useNewUrlParser: true,
  })
  .then(() => console.log("DB connection successful!"));
 */
mongoose.connect(process.env.DATABASE_CONN_STR, {
    useNewUrlParser: true,
}).then(() => console.log("DB connection successful!")).catch(err => {
    console.error('server:Unable to connect to DB. Shutting down: ', err);
    server.close(() => {
        process.exit(1);
    })
});


const port = process.env.PORT || 4000;
const server = app.listen(port, () => {
    console.log(`App running on port ${port}...`);
});

server.on("upgrade", (request, socket, head) => {
    wsServer.handleUpgrade(request, socket, head, (socket) => {
        wsServer.emit("connection", socket, request);
    });
});

process.on("unhandledRejection", (err) => {
    console.log("UNHANDLED REJECTION! 💥 Shutting down...");
    console.log(err.name, err.message);
    server.close(() => {
        process.exit(1);
    });
});
