import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:flutter_todo/ui/creatingTask.dart';

class CardTask extends StatelessWidget {
  final Task _taskData;
  final Function onDelete;
  final Function onDone;
  final Function onChange;

  CardTask(this._taskData, this.onDone, this.onChange, this.onDelete);

  getDeleteButton() {
    return MaterialButton(
      child: const Text('DELETE'),
      color: Colors.red,
      textColor: Colors.white,
      onPressed: (() => onDelete(_taskData.id)),
    );
  }

  getChangeButton(context) {
    return MaterialButton(
      child: const Text('CHANGE'),
      color: Colors.grey,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreatingTaskScreen('EDIT TASK', onChange, _taskData)),
        );
      },
    );
  }

  getDoneButton() {
    return MaterialButton(
      child: const Text('DONE'),
      color: Colors.green,
      textColor: Colors.white,
      onPressed: () { onDone(_taskData); },
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = <Widget>[getDeleteButton()];
    var colorLabel = Colors.red;
    if(!_taskData.status) {
      list.add(getChangeButton(context));
      list.add(getDoneButton());
    } else {
      colorLabel = Colors.green;
    }

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.grade, size: 50.0, color: colorLabel),
            title: Text(_taskData.title.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
            subtitle: Text(_taskData.description),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: list,
            ),
          ),
        ],
      ),
    );
  }

}