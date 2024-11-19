import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  // DateTime today = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                Padding(
                    padding: EdgeInsets.only(top: 50),

                    // child: Align(
                    // alignment: Alignment.topLeft,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Events',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: Colors.red),
                      ),
                    )
                    // ),
                    ),
                // ),
                Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    // child: Align(
                    //     alignment: Alignment.topLeft,
                    child: Text(
                      'CALENDAR',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Bebas',
                          letterSpacing: 3,
                          fontWeight: FontWeight.w400),
                    )
                    // ),
                    ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.notifications,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //   Padding(
        //     padding: EdgeInsets.only(left: 22.0, bottom: 0.0, top: 49.0),
        //     child: Align(
        //       alignment: Alignment.bottomLeft,
        //       child: Text(
        //         'Events',
        //         style: TextStyle(
        //             fontSize: 15,
        //             fontFamily: 'Roboto',
        //             fontWeight: FontWeight.w300,
        //             color: Colors.red),
        //       ),
        //     ),
        //   ),
        //   Padding(
        //     padding: EdgeInsets.only(right: 20.0, top: 50.0),
        //     child: Icon(
        //       Icons.notifications,
        //       size: 40,
        //     ),
        //   ),
        // ]),
        // Padding(
        //   padding: EdgeInsets.only(left: 20.0),
        //   child: Align(
        //       alignment: Alignment.topLeft,
        //       child: Text(
        //         'CALENDAR',
        //         style: TextStyle(
        //             fontSize: 32,
        //             fontFamily: 'Bebas',
        //             letterSpacing: 2,
        //             fontWeight: FontWeight.w400),
        //       )),
        // ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Container(
            height: 370,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(
              //   color: Colors.grey,
              //   width: 2.0,

              // ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: -3,
                    blurRadius: 20,
                    offset: Offset(0, 0)),
              ],
              gradient: LinearGradient(
                colors: [Color(0xabf8990c), Color(0xadff6d64)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: TableCalendar(
              locale: "en_US",
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2023),
              lastDay: DateTime.utc(2024),
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              rowHeight: 40,
              daysOfWeekHeight: 60,
              headerStyle: HeaderStyle(
                  titleTextStyle: const TextStyle(fontFamily: 'Roboto'),
                  formatButtonTextStyle:
                      TextStyle(color: Colors.red, fontFamily: 'Roboto'),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                  )),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.white),
                  weekdayStyle: TextStyle(color: Colors.black)),
              calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 148, 141),
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'UPCOMING EVENTS',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Bebas',
                  letterSpacing: 2,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Text(
                'Show All',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Roboto', color: Colors.red),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}