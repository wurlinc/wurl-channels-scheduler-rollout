// NOTE: code is not used
// "use strict";
//
// const path = require('path');
// const express = require('express');
//
// const devBuild = process.env.NODE_ENV !== 'production';
// const nodeEnv = devBuild ? 'development' : 'production';
// const redisUrl = process.env.REDIS_URL || 'redis://localhost:6379'
// const websocketPort = process.env.WEBSOCKET_PORT || '3001'
// const INDEX = path.join(__dirname, 'index.html');
//
// console.log('REDIS URL', redisUrl)
// console.log('WEBSOCKET PORT', websocketPort)
//
//
// // connect to redis
// let rtg   = require("url").parse(redisUrl);
// let redis = require('redis').createClient(rtg.port, rtg.hostname)
// if (nodeEnv === 'production') {
//   redis.auth(rtg.auth.split(":")[1]);
// }
//
// // redis subscribes to channel
// redis.subscribe('episode-download');
//
// // create a server, listen to the port
// const server = express()
//   .use((req, res) => {
//     console.log('REQUEST', req);
//     console.log('RESPONSE', res);
//     res.sendFile(INDEX)
//   } )
//   .listen(websocketPort, () => console.log(`Listening on ${ websocketPort }`));
//
// console.log('server', server)
// let io = require('socket.io')(server)
//
// io.on('connection', function(socket){
//   console.log('connected', socket.id)
//   socket.send(socket.id)
//   socket.on('disconnect', function(reason) {
//     console.log('client disconnected', reason)
//   });
// });
//
// redis.on('message', function(channel, message){
//  console.log('message', message)
//  console.log('channel', channel)
//  io.sockets.emit(channel, message);
//  console.log('emit '+ channel);
// });
