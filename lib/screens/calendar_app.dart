import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarApp extends StatefulWidget {
  CalendarApp({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CalendarApp createState() => _CalendarApp();
}

class _CalendarApp extends State<CalendarApp> with TickerProviderStateMixin {
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
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
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
          const SizedBox(height: 8.0),
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
            'Calendar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 20.0,
            ),
          ),
          height: 80.0,
          color: Colors.black87,
          padding: EdgeInsets.only(
            left: 16.0,
            top: 40,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
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
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blueAccent[400],
        todayColor: Colors.blue[200],
        markersColor: Colors.black,
        outsideDaysVisible: true,
        weekdayStyle: TextStyle(fontWeight: FontWeight.w500),
        weekendStyle:
            TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFF44336)),
        holidayStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: const Color(0xFFF44336)), // Material red[500]
        selectedStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: const Color(0xFFFAFAFA),
            fontSize: 16.0), // Material grey[50]
        todayStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: const Color(0xFFFAFAFA),
            fontSize: 16.0), // Material grey[50]
        outsideStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9E9E9E)), // Material grey[500]
        outsideWeekendStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: const Color(0xFFEF9A9A)), // Material red[200]
        outsideHolidayStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: const Color(0xFFEF9A9A)), // Material red[200]
        unavailableStyle: TextStyle(
            fontWeight: FontWeight.w500, color: const Color(0xFFBFBFBF)),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
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
        weekdayStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF616161)), // Material grey[700],
        weekendStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF44336)), // Material grey[700],
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
