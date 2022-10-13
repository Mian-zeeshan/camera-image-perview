import 'package:flutter/material.dart';
import 'package:image_preview/image_preview4.dart';
import 'package:provider/provider.dart';

import 'image provider/image_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return MultiProvider (
      
      providers: [
       
        ChangeNotifierProvider (create:(context) => customprovider2(),),
       
      ],
   
    
    
    
    child:  MaterialApp( 
      
     
      debugShowCheckedModeBanner: false,
      home: mycamera4(),
      
    ),
  
    );
    }
}