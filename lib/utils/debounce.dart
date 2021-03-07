/// source https://medium.com/fantageek/how-to-debounce-action-in-flutter-ed7177843407
import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer _timer;
  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}


// class Debouncer {
//   final int milliseconds;
//   Function action;
//   Timer _timer;
//   Debouncer({this.milliseconds, this.action});

//   run() {
//     if (_timer != null) {
//       _timer.cancel();
//     }
//     _timer = Timer(Duration(milliseconds: this.milliseconds), this.action);
//   }
// }
