import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/test.dart';
import '/pages/login.dart';
import 'package:livechatt/livechatt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/calendar': (context) => CalendarPage(title: 'Calendar'),
          '/login': (context) => LoginPage()
        }
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20),
            child: Text('A random word:'),
          ),
          BigCard(pair: pair),
          ElevatedButton(
            onPressed: () {
              appState.getNext();
            },
            child: Text('Next'),
          ),
          ElevatedButton(
            onPressed: () {
              Livechat.beginChat('311d4642-2b1f-4ea4-b9bf-6b83beb50b56', '7d271ba99786bb72f0febd416cde49a8', 'Tina', 'kristina@suitedynamics.io');
            },
            child: Text('Heeey "Calendar" Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context,'/login');
            },
            child: Text('Actual Calander Page'),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Album> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   const Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!.title);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// // import '/pages/calendar.dart';
// import '/pages/word.dart';

// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
//     show CalendarCarousel;
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
// import 'package:intl/intl.dart' show DateFormat;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'dooboolab flutter calendar',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
//         // counter didn't reset back to zero; the application is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Calendar Carousel Example'),
//       routes: {
//         '/': (context) => MyHomePage(title: 'Home'),
//         '/word': (context) => WordPage()
//       }
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   DateTime _currentDate = DateTime(2019, 2, 3);
//   DateTime _currentDate2 = DateTime(2019, 2, 3);
//   String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
//   DateTime _targetDateTime = DateTime(2019, 2, 3);
// //  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
//   static Widget _eventIcon = Container(
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(1000)),
//         border: Border.all(color: Colors.blue, width: 2.0)),
//     child: Icon(
//       Icons.person,
//       color: Colors.amber,
//     ),
//   );

//   EventList<Event> _markedDateMap = EventList<Event>(
//     events: {
//       DateTime(2019, 2, 10): [
//         Event(
//           date: DateTime(2019, 2, 10),
//           title: 'Event 1',
//           icon: _eventIcon,
//           dot: Container(
//             margin: EdgeInsets.symmetric(horizontal: 1.0),
//             color: Colors.red,
//             height: 5.0,
//             width: 5.0,
//           ),
//         ),
//         Event(
//           date: DateTime(2019, 2, 10),
//           title: 'Event 2',
//           icon: _eventIcon,
//         ),
//         Event(
//           date: DateTime(2019, 2, 10),
//           title: 'Event 3',
//           icon: _eventIcon,
//         ),
//       ],
//     },
//   );

//   @override
//   void initState() {
//     /// Add more events to _markedDateMap EventList
//     _markedDateMap.add(
//         DateTime(2019, 2, 25),
//         Event(
//           date: DateTime(2019, 2, 25),
//           title: 'Event 5',
//           icon: _eventIcon,
//         ));

//     _markedDateMap.add(
//         DateTime(2019, 2, 10),
//         Event(
//           date: DateTime(2019, 2, 10),
//           title: 'Event 4',
//           icon: _eventIcon,
//         ));

//     _markedDateMap.addAll(DateTime(2019, 2, 11), [
//       Event(
//         date: DateTime(2019, 2, 11),
//         title: 'Event 1',
//         icon: _eventIcon,
//       ),
//       Event(
//         date: DateTime(2019, 2, 11),
//         title: 'Event 2',
//         icon: _eventIcon,
//       ),
//       Event(
//         date: DateTime(2019, 2, 11),
//         title: 'Event 3',
//         icon: _eventIcon,
//       ),
//     ]);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     /// Example with custom icon
//     final _calendarCarousel = CalendarCarousel<Event>(
//       onDayPressed: (date, events) {
//          setState(() => _currentDate = date);
//         events.forEach((event) => print(event.title));
//       },
//       weekendTextStyle: TextStyle(
//         color: Colors.red,
//       ),
//       thisMonthDayBorderColor: Colors.grey,
// //          weekDays: null, /// for pass null when you do not want to render weekDays
//       headerText: 'Custom Header',
//       weekFormat: true,
//       markedDatesMap: _markedDateMap,
//       height: 200.0,
//       selectedDateTime: _currentDate2,
//       showIconBehindDayText: true,
// //          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
//       customGridViewPhysics: NeverScrollableScrollPhysics(),
//       markedDateShowIcon: true,
//       markedDateIconMaxShown: 2,
//       selectedDayTextStyle: TextStyle(
//         color: Colors.yellow,
//       ),
//       todayTextStyle: TextStyle(
//         color: Colors.blue,
//       ),
//       markedDateIconBuilder: (event) {
//         return event.icon ?? Icon(Icons.help_outline);
//       },
//       minSelectedDate: _currentDate.subtract(Duration(days: 360)),
//       maxSelectedDate: _currentDate.add(Duration(days: 360)),
//       todayButtonColor: Colors.transparent,
//       todayBorderColor: Colors.green,
//       markedDateMoreShowTotal:
//           true, // null for not showing hidden events indicator
// //          markedDateIconMargin: 9,
// //          markedDateIconOffset: 3,
//     );

//     /// Example Calendar Carousel without header and custom prev & next button
//     final _calendarCarouselNoHeader = CalendarCarousel<Event>(
//       todayBorderColor: Colors.green,
//       onDayPressed: (date, events) {
//         setState(() => _currentDate2 = date);
//         events.forEach((event) => print(event.title));
//       },
//       daysHaveCircularBorder: true,
//       showOnlyCurrentMonthDate: false,
//       weekendTextStyle: TextStyle(
//         color: Colors.red,
//       ),
//       thisMonthDayBorderColor: Colors.grey,
//       weekFormat: false,
// //      firstDayOfWeek: 4,
//       markedDatesMap: _markedDateMap,
//       height: 420.0,
//       selectedDateTime: _currentDate2,
//       targetDateTime: _targetDateTime,
//       customGridViewPhysics: NeverScrollableScrollPhysics(),
//       markedDateCustomShapeBorder:
//           CircleBorder(side: BorderSide(color: Colors.yellow)),
//       markedDateCustomTextStyle: TextStyle(
//         fontSize: 18,
//         color: Colors.blue,
//       ),
//       showHeader: false,
//       todayTextStyle: TextStyle(
//         color: Colors.blue,
//       ),
//       // markedDateShowIcon: true,
//       // markedDateIconMaxShown: 2,
//       // markedDateIconBuilder: (event) {
//       //   return event.icon;
//       // },
//       // markedDateMoreShowTotal:
//       //     true,
//       todayButtonColor: Colors.yellow,
//       selectedDayTextStyle: TextStyle(
//         color: Colors.yellow,
//       ),
//       minSelectedDate: _currentDate.subtract(Duration(days: 360)),
//       maxSelectedDate: _currentDate.add(Duration(days: 360)),
//       prevDaysTextStyle: TextStyle(
//         fontSize: 16,
//         color: Colors.pinkAccent,
//       ),
//       inactiveDaysTextStyle: TextStyle(
//         color: Colors.tealAccent,
//         fontSize: 16,
//       ),
//       onCalendarChanged: (DateTime date) {
//         setState(() {
//           _targetDateTime = date;
//           _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//         });
//       },
//       onDayLongPressed: (DateTime date) {
//         print('long pressed date $date');
//       },
//     );

//     return  Scaffold(
//         appBar:  AppBar(
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               //custom icon
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: _calendarCarousel,
//               ), // This trailing comma makes auto-formatting nicer for build methods.
//               //custom icon without header
//               Container(
//                 margin: EdgeInsets.only(
//                   top: 30.0,
//                   bottom: 16.0,
//                   left: 16.0,
//                   right: 16.0,
//                 ),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                         child: Text(
//                       _currentMonth,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24.0,
//                       ),
//                     )),
//                     TextButton(
//                       child: Text('PREV'),
//                       onPressed: () {
//                         setState(() {
//                           _targetDateTime = DateTime(
//                               _targetDateTime.year, _targetDateTime.month - 1);
//                           _currentMonth =
//                               DateFormat.yMMM().format(_targetDateTime);
//                         });
//                       },
//                     ),
//                     TextButton(
//                       child: Text('NEXT'),
//                       onPressed: () {
//                         setState(() {
//                           _targetDateTime = DateTime(
//                               _targetDateTime.year, _targetDateTime.month + 1);
//                           _currentMonth =
//                               DateFormat.yMMM().format(_targetDateTime);
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: _calendarCarouselNoHeader,
//               ), //
//             ],
//           ),
//         ));
//   }
// }
