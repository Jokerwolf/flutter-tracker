class ExerciseSetDataModel {
  final int _id = DateTime.now().millisecondsSinceEpoch;
  int weight;
  int reps;

  ExerciseSetDataModel({this.weight, this.reps});

  getId() {
    return _id;
  }

  @override
  String toString() {
    return '{id: $_id}';
  }
}
