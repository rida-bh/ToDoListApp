import 'dart:io';

import 'package:flutter/material.dart';
import 'package:to_do_list/FileServices/CounterStorage.dart';


class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.storage});
  final CounterStorage storage;
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  var MyDB=[];
  var decoration=TextDecoration.none;
  var color = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      widget.storage.readCounter().then((value) {
        setState((){
          MyDB=value;
        });
      });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.add_box_outlined),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, "/AddNewTask");
                }
            ),
          ],
          title: Text("Today's To do's")),
      body: Center(
          child: Center(
            child: ListView.separated(
                itemBuilder: (context, index) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: MyDB[index]['Status'],
                  onChanged: (bool? value){
                    setState((){
                      MyDB[index]['Status']=value;
                      if(value == true){
                        decoration=TextDecoration.lineThrough;
                        color=Colors.black.withOpacity(0.6);
                      }
                      else {
                        decoration=TextDecoration.none;
                        color =Colors.black;
                      }
                    });
                  },
                  secondary: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                        setState((){
                          this.MyDB.removeAt(index);
                          widget.storage.writeCounter(MyDB);
                        });
                      },
                      color: Colors.red,
                  ),
                  title: Text("${MyDB[index]['title']}",style:TextStyle(decoration: decoration,color: color,fontSize: 25) ),
                ),
                separatorBuilder:(context,index)=>Divider(height: 2,color: Colors.deepOrange,),
                itemCount: MyDB==null?0:MyDB.length),
          )
      ),
    );
  }


}