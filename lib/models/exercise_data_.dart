import 'exercise_set_data_model.dart';

class ExerciseDataModel {
  String title;
  int _id;
  List<ExerciseSetDataModel> sets = [];

  ExerciseDataModel(this.title) {
    this._id = DateTime.now().millisecondsSinceEpoch;
  }

  getId() {
    return this._id;
  }

  @override
  String toString() {
    return '{id: $_id, title: $title}';
  }
}
