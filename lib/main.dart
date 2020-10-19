import 'package:flutter/material.dart';

import 'routing/route_delegate.dart';
import 'routing/route_information_parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WorkoutTrackerRouteDelegate _routerDelegate = WorkoutTrackerRouteDelegate();
  WorkoutTrackerRouteInformationParser _routeInformationParser =
      WorkoutTrackerRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Workouts Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
    );
  }
}
