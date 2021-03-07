import 'package:flutter/material.dart';
import 'package:flutter_tracker/models/tracker_model.dart';
import 'package:flutter_tracker/models/workout_data_model.dart';
import 'package:flutter_tracker/routing/route_data.dart';
import 'package:provider/provider.dart';

import 'route_data.dart';
import 'route_delegate_state.dart';
import '../screens/home/screen.dart';
import '../screens/unknown/screen.dart';
import '../screens/workout/screen.dart';

class WTRouteDelegate extends RouterDelegate<WTRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WTRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  WTRouteDelegateState _state;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        HomePage(this._handleWorkoutTap),
        if (this._state is WorkoutState) WorkoutPage(this._state.getData()),
        if (this._state is UnknownState) UnknownPage()
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages
        this._setState(new HomeState());

        this.notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(WTRoutePath configuration) async {
    if (configuration.isUnknown) {
      this._setState(new UnknownState());
      return;
    }

    if (configuration.isHomePage) {
      this._setState(new HomeState());
      return;
    }

    if (configuration.isWorkoutPage &&
        this._isValidWorkoutRoute(configuration.workoutId)) {
      this._setState(new WorkoutState(configuration.workoutId));
      return;
    }

    this._setState(new UnknownState());
  }

  @override
  WTRoutePath get currentConfiguration => !(this._state is WorkoutState)
      ? WTRoutePath.home()
      : WTRoutePath.workout(this._state.getData());

  _handleWorkoutTap(WorkoutDataModel workout) {
    this._setState(new WorkoutState(workout.getId()));
    this.notifyListeners();
  }

  _isValidWorkoutRoute(int id) {
    return Provider.of<TrackerModel>(navigatorKey.currentContext, listen: false)
            .getWorkout(id) !=
        null;
  }

  _setState(WTRouteDelegateState state) {
    if (this._state != state) this._state = state;
  }
}
