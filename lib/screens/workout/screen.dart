import 'package:flutter/material.dart';

import 'components/exercise.dart';

class WorkoutPage extends Page {
  final String workout;

  WorkoutPage(this.workout);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => WorkoutScreen(workout: this.workout),
    );
  }
}

class WorkoutScreen extends StatefulWidget {
  final String workout;

  const WorkoutScreen({Key key, this.workout}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List<String> _exercises = new List();

  @override
  Widget build(BuildContext context) {
    // final name = ModalRoute.of(context).settings.arguments;

    final Widget addExerciseButton = FloatingActionButton(
      onPressed: this._addExercise,
      tooltip: 'Add exercise',
      child: Icon(Icons.add),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.workout),
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

  void _addExercise() {
    this.setState(() {
      this._exercises = [
        ...this._exercises,
        'Exercise ${this._exercises.length}'
      ];
    });
  }
}
