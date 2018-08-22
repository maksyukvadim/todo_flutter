import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/todoScreen.dart';
import 'package:flutter_todo/screens/contactsScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
      primarySwatch: Colors.indigo,
      ),
      home: TodoScreen(),
      routes: <String, WidgetBuilder> {
        '/todo': (BuildContext context) => TodoScreen(),
        '/contacts' : (BuildContext context) => ContactsScreen()
      },
    );
  }
}


