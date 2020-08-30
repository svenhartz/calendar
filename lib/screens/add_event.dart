import 'package:calendar_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar_app/data.dart';

class AddEvent extends StatefulWidget {
  AddEvent({Key key}) : super(key: key);
  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  final eventNameController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  DateTime date;
  String eventName, startTime, endTime;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    eventNameController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //_buildTableCalendarWithBuilders(),
                kVerticalSpacer8,
                TextFormField(
                  controller: eventNameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.add_circle),
                    labelText: 'Name of event',
                  ),
                ),
                kVerticalSpacer8,
                TextFormField(
                  controller: dateController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    dateController.text = date.year.toString() + '-' +
                        date.month.toString() + '-' +
                        date.day.toString();
                    print(date);
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Date',
                  ),
                ),
                kVerticalSpacer8,
                TextFormField(
                  controller: startTimeController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    TimeOfDay time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    startTimeController.text = time.hour.toString() + ' : ' + time.minute.toString();
                    print(time);
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.flight_takeoff),
                    labelText: 'Time start',
                  ),
                ),
                kVerticalSpacer8,
                TextFormField(
                  controller: endTimeController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    TimeOfDay time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    endTimeController.text = time.hour.toString() + ' : ' + time.minute.toString();
                    print(time);
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.flight_land),
                    labelText: 'Time end',
                  ),
                ),
                kVerticalSpacer24,
                FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: EdgeInsets.all(14.0),
                  color: Colors.black,
                  onPressed: () {
                    Provider.of<Data>(context, listen: false).addEvent(
                        date, eventNameController.text);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Add event',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
