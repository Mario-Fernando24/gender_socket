import 'package:flutter/material.dart';
import 'package:mobile_genero_example/pages/home_page.dart';
import 'package:mobile_genero_example/pages/status_page.dart';
import 'package:mobile_genero_example/service/socket_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
       return  MultiProvider(
         providers: [
          ChangeNotifierProvider(create: ( _ ) => SocketService())
         ],
         child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material AfrSpp',
            initialRoute: 'status',
            routes: {
              'home':(_)=> HomePage(),
              'status':(_)=> StatusPage()
            },
               
             
         ),
       );
  }
}