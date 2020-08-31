import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  String email;
  String calendar = '';
  bool firstLogin = true;
  Map <String,String> users = {
    'mail@sven.com': '123',
    'mail@elonmusk.com': '666',
  };


  Map<DateTime, List> events = {
    DateTime.now().subtract(Duration(days: 300)): [
      'Event A0',
    ],
  };

  void addEvent(DateTime date, String eventName) {
    if (events[date] == null) {
      events[date] = [eventName];
    } else {
      events[date].add(eventName);
    }
    notifyListeners();
    print(events);
  }

  void setEmail(String email) {
    this.email = email;
  }

  bool auth(String email, String password){
    if(email != '' && email != null && password != '' && password != null){
      if ([email] != null && users[email] == password){
        return true;
      }
      return false;
    }
  }

  bool signup(String email, String password){
    if(email != '' && email != null && password != '' && password != null){
      if (userNameAvailable(email)){
        users[email] = password;
        return true;
      }
    }
    return false;
  }

  //db check if user exists
  bool userNameAvailable(String user){
    if(users[user]==null){
      return true;
    }
    return false;
  }
}
