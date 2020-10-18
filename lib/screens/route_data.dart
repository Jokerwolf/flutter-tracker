class WorkoutTrackerRoutePath {
  final String _workoutId;
  final bool _showUnknown;

  WorkoutTrackerRoutePath.home()
      : _workoutId = null,
        _showUnknown = false;
  WorkoutTrackerRoutePath.workout(this._workoutId) : this._showUnknown = false;
  WorkoutTrackerRoutePath.unknown()
      : _workoutId = null,
        _showUnknown = true;

  WorkoutTrackerRoutePath get currentConfiguration {
    if (this._showUnknown) {
      return WorkoutTrackerRoutePath.unknown();
    }

    return _workoutId == null
        ? WorkoutTrackerRoutePath.home()
        : WorkoutTrackerRoutePath.workout(this._workoutId);
  }

  bool get isHomePage => !this.isUnknown && this._workoutId == null;

  bool get isWorkoutPage => !this.isUnknown && this._workoutId != null;

  bool get isUnknown => this._showUnknown;
}
