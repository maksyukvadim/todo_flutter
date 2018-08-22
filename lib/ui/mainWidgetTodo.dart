import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:flutter_todo/ui/creatingTask.dart';
import 'package:flutter_todo/ui/card.dart';

class MainWidgetTodo extends StatefulWidget {
  @override
  MainWidgetTodoState createState() => new MainWidgetTodoState();
}


class MainWidgetTodoState extends State<MainWidgetTodo> {

  List<Task> _listTodos = [
    Task(id: 1, title:'first', description:'first first first first', status: true),
    Task(id: 2, title:'second', description:'second second second second', status: true),
    Task(id: 3, title:'third', description:'third third third third', status: false)
  ];

  void _addTaskToList(Task newTask) {
    setState(() {
      _listTodos.add(newTask);
    });
  }

  _onChangeTask(Task task) {
    setState(() {
      final index = _listTodos.indexWhere((t) => t.id == task.id);
      _listTodos[index] = task;
    });
  }

  void _onDeleteTask(taskId) {
    setState(() {
      final index = _listTodos.indexWhere((t) => t.id == taskId);
      _listTodos.removeAt(index);
    });
  }

  void _onDoneTask(task) {
    print(task.id);
    setState(() {
      final index = _listTodos.indexWhere((t) => t.id == task.id);
      _listTodos[index] = Task(title: task.title,description: task.description, id: task.id, status: true);
    });
  }

  List<CardTask> _buildTasksListAll() {
    return _listTodos
        .map((task) => CardTask(task, _onDoneTask, _onChangeTask, _onDeleteTask))
        .toList();
  }

  List<CardTask> _buildTasksListDone() {
    return _listTodos
        .where((task) => task.status)
        .toList()
        .map((contact) => CardTask(contact, _onDoneTask, _onChangeTask, _onDeleteTask))
        .toList();
  }

  List<CardTask> _buildTasksListOpened() {
    return _listTodos
        .where((task) => !task.status)
        .toList()
        .map((contact) => CardTask(contact, _onDoneTask, _onChangeTask, _onDeleteTask))
        .toList();
  }

  _buildListViewlist(List<CardTask> list) => ListView(children: list);

  _pushRoutes(index) {
    final routesList = ['/todo', '/contacts'];
    Navigator.pushNamedAndRemoveUntil(context, routesList[index],  ModalRoute.withName('/'));
  }

  Widget build(BuildContext context) {
    final listAllTask = _buildListViewlist(_buildTasksListAll());
    final listDoneTask = _buildListViewlist(_buildTasksListDone());
    final listOpenedTask = _buildListViewlist(_buildTasksListOpened());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
          bottom: TabBar(
              tabs: [
                Tab(text: 'DO'),
                Tab(text: 'DONE'),
                Tab(text: 'ALL'),
              ]),
        ),
        body: TabBarView(
          children: [listOpenedTask, listDoneTask, listAllTask],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatingTaskScreen('CREATE TASK', _addTaskToList, null)),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('Work')),
            BottomNavigationBarItem(icon: Icon(Icons.contact_mail), title: Text('Contacts')),
          ],
          onTap: _pushRoutes,
        ),
      ),
    );
  }
}
