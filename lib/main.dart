import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
      primarySwatch: Colors.blue,
      ),
      home: new MainWidget(),
    );
  }
}



class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => new MainWidgetState();
}


class MainWidgetState extends State<MainWidget> {
  var listTodos = const <Task>[const Task(id: 1, title:'first', description:'first first first first', status: false),
  const Task(id: 2, title:'second', description:'second second second second', status: false),
  const Task(id: 3, title:'third', description:'third third third third', status: false)];

  List<CardTask> _buildTasksList() {
    return listTodos.map((contact) => new CardTask(contact))
        .toList();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: Column(
        children: _buildTasksList(),
      ),
    );
  }
}


class CardTask extends StatelessWidget {
  final Task _taskData;

  CardTask(this._taskData);

  @override
  Widget build(BuildContext context) =>
     Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           ListTile(
            leading: const Icon(Icons.grade, size: 50.0, color: Colors.deepPurpleAccent),
            title: Text(_taskData.title.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
            subtitle: Text(_taskData.description),
          ),
           ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                 FlatButton(
                  child: const Text('DELETE'),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () { /* ... */ },
                ),
                 FlatButton(
                  child: const Text('DONE'),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }