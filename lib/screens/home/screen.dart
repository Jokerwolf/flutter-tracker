import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged onTap;

  const HomeScreen({Key key, @required this.onTap}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _workouts = new List();

  @override
  Widget build(BuildContext context) {
    final Widget addWorkoutButton = FloatingActionButton(
      onPressed: this._addWorkout,
      tooltip: 'Add workout',
      child: Icon(Icons.add),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts tracker'),
      ),
      body: ListView.builder(
        itemCount: this._workouts.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(this._workouts[i]),
          onTap: () => this.widget.onTap(this._workouts[i]),
        ),
      ),
      floatingActionButton: addWorkoutButton,
    );
  }

  // void _onWorkoutTap(BuildContext context, String name) {
  // Navigator.pushNamed(context, '/workout', arguments: name);
  // }

  void _addWorkout() {
    this.setState(() {
      this._workouts = [...this._workouts, 'Workout ${this._workouts.length}'];
    });
  }
}
