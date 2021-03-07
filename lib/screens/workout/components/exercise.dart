import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tracker/models/exercise_set_data_model.dart';
import 'package:flutter_tracker/models/tracker_model.dart';
import 'package:flutter_tracker/screens/workout/components/exercise_set.dart';
import 'package:provider/provider.dart';

class Exercise extends StatefulWidget {
  final int id;

  const Exercise(this.id);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  void addExerciseSet() {
    Provider.of<TrackerModel>(context, listen: false)
        .addSetFor(exerciseId: this.widget.id);
  }

  void removeExerciseSet() {
    Provider.of<TrackerModel>(context, listen: false)
        .removeSetFor(exerciseId: this.widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final Widget addSetButton = IconButton(
      splashRadius: 20,
      onPressed: this.addExerciseSet,
      icon: Icon(Icons.add),
    );

    final Widget removeSetButton = IconButton(
      splashRadius: 20,
      onPressed: this.removeExerciseSet,
      icon: Icon(Icons.remove),
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child: Consumer<TrackerModel>(builder: (context, model, child) {
        final exercise = model.getExercise(this.widget.id);

        return Column(
          children: [
            Text('${exercise.title}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    children: [...this._buildSets(model)],
                  ),
                ),
                addSetButton,
                removeSetButton,
              ],
            ),
          ],
        );
      }),
    );
  }

  List<Widget> _buildSets(TrackerModel model) {
    final sets = model.getSetsFor(exerciseId: this.widget.id);
    return sets
        .asMap()
        .map(
          (i, el) => MapEntry(
            i,
            _buildSet(i, el),
          ),
        )
        .values
        .toList();
  }

  Widget _buildSet(int i, ExerciseSetDataModel el) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${i + 1}.'),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: new ExerciseSet(el.getId()),
          ),
        ],
      ),
    );
  }
}
