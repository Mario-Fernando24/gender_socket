import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobile_genero_example/models/band.dart';
import 'package:mobile_genero_example/service/socket_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands =[];

   @override
   void initState() {
       final socketService = Provider.of<SocketService>(context, listen: false);
       socketService.socket.on('active-gender', (gender) {

        this.bands = (gender as List)
        .map((band) => Band.fromMap(band))
        .toList();
        
      setState(() {});
    });
   // TODO: implement initState
     super.initState();
   }

   @override
   void dispose() {
       final socketService = Provider.of<SocketService>(context, listen: false);
       socketService.socket.off('active-gender');
    //  TODO: implement dispose
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {

   final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Musica ${socketService.serverStatus}',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin:EdgeInsets.only(right: 10),
            child: (socketService.serverStatus==ServerStatus.Online) 
            ? Icon(Icons.check_circle,color:Colors.blue[300])
            : Icon(Icons.offline_bolt,color: Colors.red)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( context, i) =>_bandTile(bands[i])
       ),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: () => addNewBand()),
    );
  }

  Widget _bandTile(Band band){

       final socketService = Provider.of<SocketService>(context, listen: false);

       return Dismissible(
         key: Key(band.id.toString()),
         direction: DismissDirection.startToEnd,
         onDismissed: (direction){
            print(direction);
               socketService.emit('delete-gender',{'id': band.id});
         },
         background: Container(
          padding: EdgeInsets.only(left: 8.0) ,
          color: Colors.blue[100],
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Eliminar genero',style: TextStyle(color: Colors.white),),
            
          ),
         ),
         child: ListTile(
              leading: CircleAvatar(
                child: Text(band.name!.substring(0,2)),
                backgroundColor: Colors.blue[100]
                ),
                title: Text(band.name ?? ""),
                trailing: Text('${band.votes}',style: TextStyle(fontSize: 20.0),),
                onTap: () =>{
                  print(band.id),
                  socketService.emit('vote-gender',{'id': band.id})

                } ,
            ),
       );

  }


  addNewBand(){

    final textController = new TextEditingController();

    if(Platform.isAndroid){
    
        return  showDialog(
          context: context, 
          builder: (context){
            return AlertDialog(
              title: Text('Nuevo genero musical'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  child: Text('Agregar'),
                  elevation: 5,
                  textColor: Colors.blue[100],
                  onPressed: (){
                     addBandToList(textController.text);
                  }
                  )
              ],
            );
          },  
        );

    }

    showCupertinoDialog(
      context: context, 
      builder: ( _ ){
         return CupertinoAlertDialog(
          title: Text('Nuevo genero musical'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Agregar'),
              onPressed: ()=>addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
              child: Text('Cancelar'),
              onPressed: ()=>Navigator.pop(context),
              )
          ],
         );
      }
    );


    
    
  
  }


  void addBandToList(String name){
     final socketService = Provider.of<SocketService>(context, listen: false);

    if(name.length>1){
      socketService.emit('add-gender',{'name': name});
      setState(() {});
    }
    Navigator.pop(context);

  }



}