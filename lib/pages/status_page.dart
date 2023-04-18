import 'package:flutter/material.dart';
import 'package:mobile_genero_example/service/socket_service.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {

     final socketService = Provider.of<SocketService>(context);
    //  socketService.socket.emit(event)
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server status ${socketService.serverStatus}')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: (){
          socketService.emit('emitir-mensaje',{'name':'Maria Fernanda', 'description':"Cesar Luis", 'description2':"Hola Mundo22"});
        },
      ),
    );
  }
}