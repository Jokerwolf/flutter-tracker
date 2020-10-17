import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tracker/screens/workout/components/exercise_set.dart';

class Exercise extends StatefulWidget {
  final String name;

  const Exercise({Key key, this.name}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  List<ExerciseSet> _exerciseSets = new List();

  void addExerciseSet() {
    setState(() {
      this._exerciseSets = [...this._exerciseSets, new ExerciseSet()];
    });
  }

  void removeExerciseSet() {
    setState(() {
      this._exerciseSets = List.from(_exerciseSets)..removeLast();
    });
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
      child: Column(
        children: [
          Text('${this.widget.name}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  children: [...this._buildSets()],
                ),
              ),
              addSetButton,
              removeSetButton,
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSets() {
    return this
        ._exerciseSets
        .asMap()
        .map(
          (i, _) => MapEntry(
            i,
            _buildSet(i),
          ),
        )
        .values
        .toList();
  }

  Widget _buildSet(int i) {
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
            child: new ExerciseSet(),
          ),
        ],
      ),
    );
  }
}
