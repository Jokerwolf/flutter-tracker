import 'exercise_data_.dart';

class WorkoutDataModel {
  String title;
  List<ExerciseDataModel> exercises = [];
  final int _id = DateTime.now().millisecondsSinceEpoch;

  WorkoutDataModel(this.title);

  getId() {
    return _id;
  }
}
