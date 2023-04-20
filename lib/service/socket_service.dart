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

  Function get emit => this._socket.emit;

  SocketService() {
    _initConfig();

  }


   void _initConfig() { 
    // Dart client
    this._socket = IO.io('http://192.168.1.1:3000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    this._socket.on('connect', (_) {
      
      print('11111111111111111111111111111111111111111111111');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      print('2222222222222222222222222222222222222222222222222');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    //  this._socket.on('nuevo-mensaje', (payload) {
    //    print('Nuevo mensaje');
    //    print('Nombre: ${payload['name']}');
    //    print('Description: ${payload['description']}');
    //    print(payload.containsKey('description2') ? payload['description2'] : ' No hay mensaje' );
       
    //  });

  }

}