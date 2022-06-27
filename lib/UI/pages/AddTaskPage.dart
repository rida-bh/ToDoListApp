import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:to_do_list/FileServices/CounterStorage.dart';
import 'package:to_do_list/Models/Task.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key, required this.storage});
  final CounterStorage storage;
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  List<dynamic> MyDB=[];
  Task newtask = Task();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.storage.readCounter().then((value){
      setState((){
        MyDB=value;
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Today's To do's"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/ToDoList");
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.check_box_outlined),
                onPressed: _AddNewTask,
            )
          ]
      ),

      body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Title :"),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value){
                            setState((){
                                newtask.title=value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.blue
                              ),
                            ),
                        ),
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }

  Future<File> _AddNewTask() {
    setState((){
      this.MyDB.add(this.newtask.toJson());
    });
      Navigator.of(context).pop();
      Navigator.pushNamed(context, "/ToDoList");
      return widget.storage.writeCounter(this.MyDB);
  }
}