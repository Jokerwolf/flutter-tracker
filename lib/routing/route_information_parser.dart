import 'package:flutter/material.dart';

import 'route_data.dart';

/// Valid routes:
/// * / - home route
/// * workout/:id - particular workout route
class WTRouteInformationParser extends RouteInformationParser<WTRoutePath> {
  @override
  Future<WTRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return WTRoutePath.home();
    }

    // Handle workout/:id
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'workout' || uri.pathSegments[1] == null)
        return WTRoutePath.unknown();

      final workoiutId = int.tryParse(uri.pathSegments[1]);
      if (workoiutId == null) return WTRoutePath.unknown();

      return WTRoutePath.workout(workoiutId);
    }

    // Handle unknown routes
    return WTRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(WTRoutePath path) {
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
