import 'package:flutter/material.dart';

import 'components/exercise.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List<String> _exercises = new List();

  void _addExercise() {
    this.setState(() {
      this._exercises = [
        ...this._exercises,
        'Exercise ${this._exercises.length}'
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context).settings.arguments;

    final Widget addExerciseButton = FloatingActionButton(
      onPressed: this._addExercise,
      tooltip: 'Add exercise',
      child: Icon(Icons.add),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: ListView.builder(
        itemCount: this._exercises.length,
        itemBuilder: (context, i) => ListTile(
          title: Exercise(name: _exercises[i]),
        ),
      ),
      floatingActionButton: addExerciseButton,
    );
  }
}
