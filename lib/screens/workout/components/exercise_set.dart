import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseSet extends StatelessWidget {
  final Widget inputField = Container(
    width: 55,
    child: Expanded(
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        inputField,
        Container(
          child: Text('\u00d7'),
          margin: EdgeInsets.symmetric(horizontal: 5),
        ),
        inputField,
      ],
    );
  }
}
