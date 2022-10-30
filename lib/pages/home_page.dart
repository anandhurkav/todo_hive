

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/pages/data/database.dart';
import 'package:todo_hive/utilities/dialog_box.dart';
import 'package:todo_hive/utilities/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //refrence the hive box
  final _myBox =Hive.box('mybox');
toDoDataBase db = toDoDataBase();

@override
  void initState() {
   
   //if the app first ever opening ,then create default data
   if(_myBox.get("To Do List")==null){
    db.createInitialData();
   }else{
    //there already exists data
    db.loadData();
       }
    super.initState();
  }

  // text controller
  final _controller =TextEditingController();
  //list of to do tasks
 
    //check box was tapped
    void checkBoxChanged(bool? value, int index){
      setState(() {
        db.ToDoList[index][1] =!db.ToDoList[index][1];
      });
      db.updateDataBase();

    }
  //save new task
  void saveNewTask(){
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
     db.updateDataBase();
  }

   // create a new task
   void createNewTask(){
    showDialog(context: context,
     builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: (() => Navigator.of(context).pop()
        ));
     }
     );
   } 
   // delete task
   void deleteTask(int index){
    setState(() {
      db.ToDoList.removeAt(index);
    });
     db.updateDataBase();

   }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 221, 116),
      appBar: AppBar(centerTitle: true,
        title: Text('To Do'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:createNewTask,
        child: Icon(Icons.add), ),
      body:ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
        return ToDoList(
          taskName: db.ToDoList[index][0], 
          taskCompleted: db.ToDoList[index][1], 
          onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask,
          );
      },
      ),
      );
  }
  

  
  
  

}