import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tracker/models/tracker_model.dart';
import 'package:flutter_tracker/utils/debounce.dart';
import 'package:provider/provider.dart';

class ExerciseSet extends StatelessWidget {
  final int _id;

  final debouncedWeightOnChange = new Debouncer(milliseconds: 500);
  final debouncedRepsOnChange = new Debouncer(milliseconds: 500);

  ExerciseSet(this._id);

  Widget inputFieldBuilder(
          {void Function(String) onChanged,
          TextEditingController controller}) =>
      Container(
        width: 55,
        child: Expanded(
          child: TextField(
            controller: controller,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackerModel>(
      builder: (context, model, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            inputFieldBuilder(
                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text:
                            model.getExerciseSet(this._id).weight.toString())),
                onChanged: (value) => this.debouncedWeightOnChange.run(() =>
                    model.setWeightFor(
                        setId: this._id, value: int.parse(value)))),
            Container(
              child: Text('\u00d7'),
              margin: EdgeInsets.symmetric(horizontal: 5),
            ),
            inputFieldBuilder(
                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: model.getExerciseSet(this._id).reps.toString())),
                onChanged: (value) => this.debouncedRepsOnChange.run(() => model
                    .setRepsFor(setId: this._id, value: int.parse(value)))),
          ],
        );
      },
    );
  }
}
