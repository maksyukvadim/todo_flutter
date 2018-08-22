import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_todo/model/contact.dart';

class Api {
 fetchUsers(count) {
    return http.get('https://randomuser.me/api/?results=$count');
  }


 getUsers() async {
   final response = await fetchUsers(10);

   if (response.statusCode == 200) {
     print(json.decode(response.body)['results'] is List);
     final List list = json.decode(response.body)['results'];
     final resultContact = [];
     for(var i=0; i < list.length; i++) {
       resultContact.add( Contact.fromJson(list[i]));
     }
     print(resultContact);
     return resultContact;

   } else {
     throw Exception('Failed to load post');
   }
 }
}