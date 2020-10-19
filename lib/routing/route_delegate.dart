import 'package:flutter/material.dart';
import 'package:flutter_tracker/routing/route_data.dart';

import '../screens/home/screen.dart';
import 'route_data.dart';
import '../screens/unknown/screen.dart';
import '../screens/workout/screen.dart';

class WorkoutTrackerRouteDelegate
    extends RouterDelegate<WorkoutTrackerRoutePath>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<WorkoutTrackerRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String _selectedWorkout;
  bool _showUnknown;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          key: ValueKey('Home'),
          child: HomeScreen(onTap: this._handleWorkoutTap),
        ),
        if (this._selectedWorkout != null) WorkoutPage(this._selectedWorkout),
        if (this._showUnknown)
          MaterialPage(key: ValueKey('Unknown'), child: UnknownScreen()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages
        this._selectedWorkout = null;
        this._showUnknown = false;
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
      this._selectedWorkout = configuration.workoutId;
      return;
    }

    this._showUnknown = true;
    this._selectedWorkout = null;
  }

  @override
  WorkoutTrackerRoutePath get currentConfiguration =>
      this._selectedWorkout == null
          ? WorkoutTrackerRoutePath.home()
          : WorkoutTrackerRoutePath.workout(this._selectedWorkout);

  _handleWorkoutTap(workout) {
    this._selectedWorkout = workout.toString().replaceAll(' ', '_');
    this.notifyListeners();
  }
}
