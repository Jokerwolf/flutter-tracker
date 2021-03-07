class WTRoutePath {
  final int workoutId;
  final bool _showUnknown;

  WTRoutePath.home()
      : workoutId = null,
        _showUnknown = false;

  WTRoutePath.workout(this.workoutId) : this._showUnknown = false;

  WTRoutePath.unknown()
      : workoutId = null,
        _showUnknown = true;

  WTRoutePath get currentConfiguration {
    if (this._showUnknown) {
      return WTRoutePath.unknown();
    }

    return workoutId == null
        ? WTRoutePath.home()
        : WTRoutePath.workout(this.workoutId);
  }

  bool get isHomePage => !this.isUnknown && this.workoutId == null;

  bool get isWorkoutPage => !this.isUnknown && this.workoutId != null;

  bool get isUnknown => this._showUnknown;
}
