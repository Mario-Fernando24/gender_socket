import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  SocketService() {
    _initConfig();

  }


  void _initConfig() {
    
    // Dart client
    this._socket = IO.io('http://192.168.1.4:3000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    this._socket.on('connect', (_) {
      
      print('111111111111111111111111111111111111111');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      print('2222222222222222222222222222222222222222222222222');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    _socket.on('conectado', (_) {
      
      print('33333333333333333333333333333333333333333333333333333');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

  }

}