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

  List<Task> _listTodos = [
     Task(id: 1, title:'first', description:'first first first first', status: false),
     Task(id: 2, title:'second', description:'second second second second', status: false),
     Task(id: 3, title:'third', description:'third third third third', status: false)
  ];

  void addTaskToList(Task newTask) {
    setState(() {
      _listTodos.add(newTask);
    });
  }

  onChangeTask(Task task) {
    print(task.id);
      setState(() {
        for(var i=0; i<_listTodos.length; i++) {
          print(_listTodos[i].id);
          if(_listTodos[i].id == task.id) {
            _listTodos[i] = task;
            print('yyyrrr');
            return;
          }
        }
      });
    }

  void onDeleteTask(taskId) {

  }

  void onDoneTask(taskId) {

  }

  List<CardTask> _buildTasksList() {
    return _listTodos.map((contact) => CardTask(contact, onDoneTask, onChangeTask, onDoneTask))
        .toList();
  }


  Widget build(BuildContext context) {
    final list = _buildTasksList();

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: ListView(
        children: list,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatingTaskScreen('CREATE TASK', addTaskToList, null)),
          );
        },
      ),
    );
  }
}


class CardTask extends StatelessWidget {
  final Task _taskData;
  final Function onDelete;
  final Function onDone;
  final Function onChange;

  CardTask(this._taskData, this.onDone, this.onChange, this.onDelete);

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
                MaterialButton(
                  child: const Text('DELETE'),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: (() => onDelete(_taskData.id)),
                ),
                MaterialButton(
                  child: const Text('CHANGE'),
                  color: Colors.grey,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreatingTaskScreen('EDIT TASK', onChange, _taskData)),
                    );
                  },
                ),
                 MaterialButton(
                  child: const Text('DONE'),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () { onDone(_taskData.id); },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }


class CreatingTaskScreenState extends State<CreatingTaskScreen> {
  TextEditingController _titleController ;
  TextEditingController _descriptionController ;
  final String nameTab;
  final Function addTaskToList;
  final Task task;
  CreatingTaskScreenState(this.nameTab, this.addTaskToList, this.task) : super();

  @override
  void initState() {
    _titleController = TextEditingController.fromValue(TextEditingValue(text: task.title));
    _descriptionController = TextEditingController.fromValue(TextEditingValue(text: task.description));
    super.initState();
  }





  createTask() {
    final id = new DateTime.now();
    addTaskToList(
        Task(title: _titleController.text, description: _descriptionController.text, id:id)
    );
  }

  void editTask() {
    addTaskToList(
        Task(title: _titleController.text, description: _descriptionController.text, id: task.id, status: task.status )
    );
  }

  Function onSave() {
    return task != null ? this.editTask : this.createTask;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$nameTab'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Please enter a name',
            ),
              controller: _titleController,
              autofocus: true,
          ),TextFormField(
              decoration: InputDecoration(
                hintText: 'Please enter a description',
            ),
              controller: _descriptionController,
          ),
            MaterialButton(
              child: const Text('SAVE'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: onSave(),
            )
          ],
        )
      ),
    );
  }
}


class CreatingTaskScreen extends StatefulWidget {
  final String nameTab;
  final Function addTaskToList;
  final Task task;
  CreatingTaskScreen(this.nameTab, this.addTaskToList, this.task) : super();

  @override
  CreatingTaskScreenState createState() => new CreatingTaskScreenState(nameTab, addTaskToList, task);
}
