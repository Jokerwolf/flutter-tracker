import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_tracker/models/tracker_model.dart';
import 'package:provider/provider.dart';
import 'components/exercise.dart';

class WorkoutPage extends Page {
  final int workoutId;

  WorkoutPage(this.workoutId) : super(key: ValueKey(workoutId));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) {
        return WorkoutScreen(this.workoutId);
      },
    );
  }
}

class WorkoutScreen extends StatefulWidget {
  final int workoutId;

  const WorkoutScreen(this.workoutId);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus) focusScopeNode.unfocus();
      },
      child: Consumer<TrackerModel>(
        builder: (BuildContext context, model, Widget child) {
          final exercises =
              model.getExercisesFor(workoutId: this.widget.workoutId);
          return Scaffold(
            appBar: AppBar(
              title: Text(model.getWorkout(widget.workoutId).title),
            ),
            body: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, i) => ListTile(
                title: Exercise(exercises[i].getId()),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: this._addExercise,
              tooltip: AppLocalizations.of(context).addExercise_tooltip,
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _addExercise() {
    Provider.of<TrackerModel>(context, listen: false)
        .addExerciseFor(workoutId: this.widget.workoutId);
  }
}
