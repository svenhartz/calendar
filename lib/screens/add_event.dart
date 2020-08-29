import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  AddEvent({Key key}) : super(key: key);
  @override
  _AddEvent createState() => _AddEvent();
}


class _AddEvent extends State<AddEvent>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: Text('Add Event'),
    ),
    );
  }
}