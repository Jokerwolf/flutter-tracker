abstract class WTRouteDelegateState {
  getData();
}

class HomeState extends WTRouteDelegateState {
  @override
  getData() {
    return null;
  }
}

class UnknownState extends WTRouteDelegateState {
  @override
  getData() {
    return null;
  }
}

class WorkoutState extends WTRouteDelegateState {
  final int _id;

  WorkoutState(this._id);

  @override
  getData() {
    return this._id;
  }
}
