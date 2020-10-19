class WorkoutTrackerRoutePath {
  final String workoutId;
  final bool _showUnknown;

  WorkoutTrackerRoutePath.home()
      : workoutId = null,
        _showUnknown = false;
  WorkoutTrackerRoutePath.workout(this.workoutId) : this._showUnknown = false;
  WorkoutTrackerRoutePath.unknown()
      : workoutId = null,
        _showUnknown = true;

  WorkoutTrackerRoutePath get currentConfiguration {
    if (this._showUnknown) {
      return WorkoutTrackerRoutePath.unknown();
    }

    return workoutId == null
        ? WorkoutTrackerRoutePath.home()
        : WorkoutTrackerRoutePath.workout(this.workoutId);
  }

  bool get isHomePage => !this.isUnknown && this.workoutId == null;

  bool get isWorkoutPage => !this.isUnknown && this.workoutId != null;

  bool get isUnknown => this._showUnknown;
}
