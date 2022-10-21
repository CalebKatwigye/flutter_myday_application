import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_myday_application/clock_pages/alarmpage.dart';
import 'package:flutter_myday_application/pages/clock_view.dart';
import 'package:flutter_myday_application/pages/index_page.dart';

import 'package:intl/intl.dart';

class ClockHomePage extends StatefulWidget {
  const ClockHomePage({super.key});

  @override
  State<ClockHomePage> createState() => _ClockHomePageState();
}

class _ClockHomePageState extends State<ClockHomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    print(timezoneString);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(255, 67, 0, 70),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => IndexPage())));
          },
          label: Text('Homepage')),
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: <Widget>[
          SizedBox(
            width: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildMenuButton('Clock', Icon(Icons.lock_clock_rounded)),
              buildMenuButton('Alarm', Icon(Icons.alarm)),
              buildMenuButton('Timer', Icon(Icons.timer)),
              buildMenuButton('Stopwatch', Icon(Icons.stop)),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          VerticalDivider(
            color: Colors.white24,
            width: 1,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      'Clock',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTime,
                          style: TextStyle(color: Colors.white, fontSize: 54),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Align(
                          alignment: Alignment.center,
                          child: ClockView(
                            size: MediaQuery.of(context).size.height / 4,
                          ))),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Timezone',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.language,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'UTC' + offsetSign + timezoneString,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildMenuButton(String title, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: FloatingActionButton(
        backgroundColor: title == 'Clock'
            ? Color.fromARGB(255, 67, 0, 70)
            : Color(0xFF2D2F41),
        onPressed: () {
          // var menuInfo = Provider.o
          if (title == 'Alarm') {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => AlarmPage())));
          }
          if (title == 'Timer') {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: <Widget>[
            // Image.asset(
            //   image,
            //   scale: 1.5,
            // ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
