import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';

class CreatingTaskScreenState extends State<CreatingTaskScreen> {
  TextEditingController _titleController ;
  TextEditingController _descriptionController ;
  final String nameTab;
  final Function addTaskToList;
  final Task task;
  CreatingTaskScreenState(this.nameTab, this.addTaskToList, this.task) : super();

  @override
  void initState() {
    if(task != null) {
      _titleController = TextEditingController.fromValue(TextEditingValue(text: task.title ));
      _descriptionController = TextEditingController.fromValue(TextEditingValue(text: task.description));
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
    super.initState();
  }

  void createTask() {
    final id = new DateTime.now();
    addTaskToList(
        Task(title: _titleController.text, description: _descriptionController.text, id:id, status: false)
    );
    Navigator.pop(context);
  }

  void editTask() {
    addTaskToList(
        Task(title: _titleController.text, description: _descriptionController.text, id: task.id, status: task.status )
    );
    Navigator.pop(context);
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