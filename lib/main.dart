import 'package:flutter/material.dart';
import 'package:todo_hive/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()async{
//initializing hive
await Hive.initFlutter();

//open a box
var box = await Hive.openBox('mybox');

  runApp(const Myapp());
}
class Myapp extends StatelessWidget{
  const Myapp({super.key});
  @override 
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}