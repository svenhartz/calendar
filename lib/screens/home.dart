import 'package:calendar_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:calendar_app/data.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  final Map<DateTime, List> _holidays = {
    DateTime(2020, 1, 1): ['New Year\'s Day'],
    DateTime(2020, 1, 6): ['Epiphany'],
    DateTime(2020, 2, 14): ['Valentine\'s Day'],
    DateTime(2020, 4, 21): ['Easter Sunday'],
    DateTime(2020, 4, 22): ['Easter Monday'],
  };

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      DateTime.now().subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: getDrawer(),
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildTableCalendar(),
          //_buildTableCalendarWithBuilders(),
          kVerticalSpacer8,
          Expanded(child: _buildEventList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addEvent');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget getDrawer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Text(
            'CALENDAR',
            style: kHeadlineDrawer,
          ),
          height: 80.0,
          color: Colors.black87,
          padding: EdgeInsets.only(
            left: 16.0,
            top: 40,
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Spacer(),
        Row(
          children: [
          FlatButton.icon(
            padding: EdgeInsets.all(14.0),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
            icon: Icon(Icons.power_settings_new),
            label: Text("Logout"),
          ),
          ],
        ),
      ],
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      //events: _events,
      events: Provider.of<Data>(context).events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: kCalSelectedColor,
        todayColor: kCalTodayColor,
        markersColor: kCalMarkersColor,
        outsideDaysVisible: true,
        weekdayStyle: kCalWeekdayTextStyle,
        weekendStyle: kCalWeekendTextStyle,
        holidayStyle: kCalHolidayTextStyle,
        selectedStyle: kCalSelectedTextStyle,
        todayStyle: kCalTodayTextStyle,
        outsideStyle: kCalOutsideTextStyle,
        outsideWeekendStyle: kCalOutsideWeekendTextStyle,
        outsideHolidayStyle: kCalOutsideHolidayTextStyle,
        unavailableStyle: kCalUnavailableTextStyle,
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: kCalTitleTextStyle,
        centerHeaderTitle: true,
        formatButtonVisible: false,
        formatButtonTextStyle: TextStyle().copyWith(
            fontWeight: FontWeight.w500, color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.green[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: kCalDowWeekdayTextStyle,
        weekendStyle: kCalDowWeekendTextStyle,
      ),
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }
          return children;
        },
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.black
            : _calendarController.isToday(date) ? Colors.black : Colors.black54,
      ),
      width: 18.0,
      height: 18.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
