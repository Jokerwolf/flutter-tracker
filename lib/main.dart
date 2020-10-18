import 'package:flutter/material.dart';
import 'package:flutter_tracker/screens/workout/screen.dart';

import 'screens/home/screen.dart';
import 'screens/workout/screen.dart';
import 'screens/workout/screen.dart';
import 'screens/workout/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workouts Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('Home'),
            child: HomeScreen(onTap: this._handleWorkoutTap),
          ),
          if (this._selectedWorkout != null) WorkoutPage(this._selectedWorkout)
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          // Update the list of pages
          setState(() {
            this._selectedWorkout = null;
          });

          return true;
        },
      ),
    );
  }

  _handleWorkoutTap(workout) {
    setState(() {
      this._selectedWorkout = workout.toString().replaceAll(' ', '_');
    });
  }
}
