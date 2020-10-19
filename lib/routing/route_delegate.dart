import 'package:flutter/material.dart';
import 'package:flutter_tracker/routing/route_data.dart';

import '../screens/home/screen.dart';
import 'route_data.dart';
import '../screens/unknown/screen.dart';
import '../screens/workout/screen.dart';
import 'route_delegate_state.dart';

class WorkoutTrackerRouteDelegate
    extends RouterDelegate<WorkoutTrackerRoutePath>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<WorkoutTrackerRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  WorkoutTrackerRouteDelegateState _state;
  // String _selectedWorkout;
  // bool _showUnknown;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          key: ValueKey('Home'),
          child: HomeScreen(onTap: this._handleWorkoutTap),
        ),
        if (this._state is WorkoutState) WorkoutPage(this._state.getData()),
        if (this._state is UnknownState)
          MaterialPage(key: ValueKey('Unknown'), child: UnknownScreen()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages
        this._setState(new HomeState());
        // this._showUnknown = false;
        this.notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(WorkoutTrackerRoutePath configuration) async {
    if (configuration.isUnknown) {
      this._setState(new UnknownState());
      return;
    }

    if (configuration.isHomePage) {
      this._setState(new HomeState());
      return;
    }

    if (configuration.isWorkoutPage) {
      this._setState(new WorkoutState(configuration.workoutId));
      return;
    }

    this._setState(new UnknownState());
  }

  @override
  WorkoutTrackerRoutePath get currentConfiguration =>
      !(this._state is WorkoutState)
          ? WorkoutTrackerRoutePath.home()
          : WorkoutTrackerRoutePath.workout(this._state.getData());

  _handleWorkoutTap(workout) {
    this._setState(new WorkoutState(workout.toString().replaceAll(' ', '_')));
    this.notifyListeners();
  }

  _setState(WorkoutTrackerRouteDelegateState state) {
    if (this._state != state) this._state = state;
  }
}
