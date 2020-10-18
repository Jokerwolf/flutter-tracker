import 'package:flutter/material.dart';
import 'package:flutter_tracker/screens/route_data.dart';

import 'home/screen.dart';
import 'unknown/screen.dart';
import 'workout/screen.dart';

class WorkoutTrackerRouteDelegate extends RouteDelegate<WorkoutTrackerRoutePath>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<WorkoutTrackerRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  String _selectedWorkout;
  bool _showUnknown;

  WorkoutTrackerRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        if (this._showUnknown)
          MaterialPage(key: ValueKey('Unknown'), child: UnknownScreen()),
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
        this._selectedWorkout = null;
        this.notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(WorkoutTrackerRoutePath configuration) async {
    if (configuration.isUnknown) {
      this._showUnknown = true;
      this._selectedWorkout = null;
      return;
    }

    if (configuration.isHomePage) {
      this._showUnknown = false;
      this._selectedWorkout = null;
      return;
    }

    if (configuration.isWorkoutPage) {
      this._showUnknown = false;
      this._selectedWorkout = null;
      return;
    }

    this._showUnknown = true;
    this._selectedWorkout = null;
  }

  _handleWorkoutTap(workout) {
    this._selectedWorkout = workout.toString().replaceAll(' ', '_');
    this.notifyListeners();
  }
}
