import 'package:flutter/material.dart';
import 'package:flutter_todo/model/contact.dart';
import 'package:flutter_todo/services/api.dart';

class ContactsScreen extends StatelessWidget {

  _pushRoutes(context) {
    return (index) {
      final routesList = ['/todo', '/contacts'];
      Navigator.of(context).pop(routesList[index]);
    };
  }

  @override
  Widget build(BuildContext context) {
    final api = new Api();
    return Scaffold(
      appBar: AppBar(
        title: Text('CONTACTS'),
          automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder (
          future: api.getUsers(),
          builder: (context, snapshot) {
            print(snapshot.hasData);
            if (snapshot.hasData) {
              return Text(snapshot.data[0].email);
//              return Text(snapshot.data[0].email);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('Work')),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail), title: Text('Contacts')),
        ],
        onTap: _pushRoutes(context),
      ),
    );
  }
}