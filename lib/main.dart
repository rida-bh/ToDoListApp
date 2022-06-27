import 'package:flutter/material.dart';
import 'package:to_do_list/FileServices/CounterStorage.dart';
import 'package:to_do_list/UI/pages/AddTaskPage.dart';
import 'package:to_do_list/UI/pages/TodoPage.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/ToDoList":(context)=>TodoPage(storage: CounterStorage()),
        "/AddNewTask":(context) => AddTaskPage(storage: CounterStorage())
      },
      debugShowCheckedModeBanner: false,
      initialRoute: "/ToDoList",
    );
  }
}



