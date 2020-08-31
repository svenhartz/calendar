import 'package:calendar_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar_app/data.dart';
import 'home.dart';

class AddCalendar extends StatefulWidget {
  AddCalendar({Key key}) : super(key: key);
  @override
  _AddCalendar createState() => _AddCalendar();
}

class _AddCalendar extends State<AddCalendar> {
  String errorMessage = '';
  final calendarNameController = TextEditingController();
  final shareController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    calendarNameController.dispose();
    shareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 40.0,
              bottom: 32.0,
            ),
            color: Colors.black87,
            child: Center(
              child: Text(
                'CALENDAR',
                style: kHeadlineLogin,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //_buildTableCalendarWithBuilders(),
                kVerticalSpacer8,
                Text(
                  'Create your first calendar',
                  style: kH1,
                ),
                kVerticalSpacer16,
                TextFormField(
                  controller: calendarNameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Calendar name',
                  ),
                ),
                kVerticalSpacer16,
                if(errorMessage != '') Container(
                  child: Center(
                    child: Text(
                      errorMessage ?? '',
                      style: kErrorMessage,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                ),
                if(errorMessage != '') kVerticalSpacer24,

                TextFormField(
                  controller: shareController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.supervisor_account),
                    labelText: 'Share with user@mail.com, user2.mail.com...',
                  ),
                ),
                kVerticalSpacer24,
                Container(
                  child: Text(
                    "Registered users will get an in app invite. "
                    "Not registered users have to create a calendar app account first to see the invite. They will get an email with instructions how to create a calendar app account.",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black87),
                  ),
                  padding: EdgeInsets.all(16.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: new BorderRadius.circular(4.0),
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
                    if(calendarNameController.text != ''){
                      Provider.of<Data>(context, listen: false).calendar =
                          calendarNameController.text;
                      Navigator.pushNamed(
                        context,
                        '/home',
                        arguments: Home(
                            title:
                            Provider.of<Data>(context, listen: false).email),
                      );
                    } else{
                      showErrorMessage('Your calendar needs a name :)');
                    }

                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Create calendar',
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
  void showErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });
  }
}
