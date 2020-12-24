//import 'package:turtlestore/turtlestore.dart' as turtlestore;

import 'dart:io';
import 'dart:async';

void handleMsg(msg) {
  print('Message received: $msg');
}

void main() {
  runZonedGuarded(() async {
    var server = await HttpServer.bind('127.0.0.1', 4040);
    await for (var req in server) {
      if (req.uri.path == '/ws') {
        // Upgrade a HttpRequest to a WebSocket connection.
        var socket = await WebSocketTransformer.upgrade(req);
        socket.listen(handleMsg);
      };
    }
  },
  (e, StackTrace stack) => print('An error occurred. $e $stack'));
}
