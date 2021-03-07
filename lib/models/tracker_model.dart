import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_tracker/models/exercise_set_data_model.dart';
import 'package:flutter_tracker/utils/console_log.dart';

import 'exercise_data_.dart';
import 'workout_data_model.dart';

class TrackerModel extends ChangeNotifier {
  List<WorkoutDataModel> workouts = [];
  HashMap<int, WorkoutDataModel> _workoutsById = new HashMap();
  HashMap<int, ExerciseDataModel> _exercisesById = new HashMap();
  HashMap<int, ExerciseSetDataModel> _setsById = new HashMap();

  getWorkout(int id) {
    return this._workoutsById[id];
  }

  addWorkout() {
    final workout = new WorkoutDataModel('Workout ${this.workouts.length}');
    this.workouts = [...this.workouts, workout];
    this._workoutsById[workout.getId()] = workout;
    this.notifyListeners();
  }

  getExercisesFor({int workoutId}) {
    return this._workoutsById[workoutId].exercises;
  }

  addExerciseFor({int workoutId}) {
    final exercises = this._workoutsById[workoutId].exercises;
    final exercise = new ExerciseDataModel('Exercise ${exercises.length}');
    this._workoutsById[workoutId].exercises = [...exercises, exercise];
    this._exercisesById[exercise.getId()] = exercise;
    this.notifyListeners();
  }

  ExerciseDataModel getExercise(int id) {
    return this._exercisesById[id];
  }

  ExerciseSetDataModel getExerciseSet(int id) {
    return this._setsById[id];
  }

  List<ExerciseSetDataModel> getSetsFor({int exerciseId}) {
    return this._exercisesById[exerciseId].sets;
  }

  addSetFor({int exerciseId}) {
    final sets = this._exercisesById[exerciseId].sets;
    final newSet = new ExerciseSetDataModel();
    this._exercisesById[exerciseId].sets = [...sets, newSet];
    this._setsById[newSet.getId()] = newSet;
    this.notifyListeners();
  }

  // Look
  removeSetFor({@required int exerciseId, int setId}) {
    final sets = this._exercisesById[exerciseId].sets;
    setId == null
        ? sets.removeLast()
        : sets.removeWhere((element) => element.getId() == setId);
    // final i = setId == null
    //     ? sets.length - 1
    //     : sets.indexWhere((element) => element.getId() == setId);

    // final idToRemove = sets[i].getId();

    // this._exercisesById[exerciseId].sets = [
    //   ...sets.sublist(0, i - 1),
    //   ...sets.sublist(i + 1)
    // ];
    // this._setsById.remove(idToRemove);
    this.notifyListeners();
  }

  setWeightFor({int setId, int value}) {
    this._setsById[setId].weight = value;
  }

  setRepsFor({int setId, int value}) {
    this._setsById[setId].reps = value;
  }
}
