import 'package:flutter/material.dart';

import 'route_data.dart';

class WorkoutTrackerRouteInformationParser
    extends RouteInformationParser<WorkoutTrackerRoutePath> {
  @override
  Future<WorkoutTrackerRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return WorkoutTrackerRoutePath.home();
    }

    // Handle workout/:id
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'workout')
        return WorkoutTrackerRoutePath.unknown();
      final id = uri.pathSegments[1];

      if (id == null) return WorkoutTrackerRoutePath.unknown();
      return WorkoutTrackerRoutePath.workout(id);
    }

    // Handle unknown routes
    return WorkoutTrackerRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(WorkoutTrackerRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isWorkoutPage) {
      return RouteInformation(location: '/workout/${path.workoutId}');
    }
    return null;
  }
}
