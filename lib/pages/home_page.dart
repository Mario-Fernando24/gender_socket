import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobile_genero_example/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands =[
    Band( id: '1',name: 'Champeta',votes: 2),
    Band( id: '2',name: 'Vallenato',votes: 0),
    Band( id: '3',name: 'Salsa',votes: 3),
    Band( id: '4',name: 'Merengue',votes: 1),
    Band( id: '5',name: 'Pop',votes: 1),
    Band( id: '6',name: 'Regueton',votes: 1)
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Musica Colombiana',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 1,
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
       return Dismissible(
         key: Key(band.id.toString()),
         direction: DismissDirection.startToEnd,
         onDismissed: (direction){
            print(direction);
            //llamar el borrado
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
                  print(band.name)
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
                  onPressed: ()=>addBandToList(textController.text)
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

    print("=========================================================");
    print(name);
    print("=========================================================");
    
    if(name.length>1){
     this.bands.add(new Band(id: DateTime.now().toString(), name: name,votes: 0));
      setState(() {});
    }
    Navigator.pop(context);

  }



}