import 'package:calendar_app/screens/add_calendar.dart';
import 'package:calendar_app/screens/add_event.dart';
import 'package:flutter/material.dart';
import 'package:calendar_app/screens/login.dart';
import 'package:calendar_app/screens/home.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'constants.dart';
import 'data.dart';
import 'package:provider/provider.dart';


void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        title: kAppTitle,
        theme: ThemeData(
          primaryColor: Colors.black,
          //primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/addEvent': (context) => AddEvent(),
          '/addCalendar': (context) => AddCalendar(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/home') {
            final Home args = settings.arguments;
            return MaterialPageRoute(
              builder: (context) {
                return Home(
                  title: args.title,
                );
              },
            );
          }
          return null;
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
