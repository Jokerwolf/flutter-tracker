abstract class WorkoutTrackerRouteDelegateState {
  getData();
}

class HomeState extends WorkoutTrackerRouteDelegateState {
  @override
  getData() {
    return null;
  }
}

class UnknownState extends WorkoutTrackerRouteDelegateState {
  @override
  getData() {
    return null;
  }
}

class WorkoutState extends WorkoutTrackerRouteDelegateState {
  final String _data;

  WorkoutState(this._data);

  @override
  getData() {
    return this._data;
  }
}
