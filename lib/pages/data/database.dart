import 'package:hive_flutter/hive_flutter.dart';

class toDoDataBase{

  List ToDoList = [];
  //refrence our box
  final _myBox = Hive.box('mybox');

 //run this method if this is 1st time opening this app
  void createInitialData(){
    ToDoList = [
      ['Default Note', false],
      ['Tap to Marked',false],
    ];

  }
  // load the data from data base
  void loadData(){
    ToDoList= _myBox.get("ToDo List");

  }

  //update  the database
  void updateDataBase(){
    _myBox.put('To Do List',ToDoList);

  }

}