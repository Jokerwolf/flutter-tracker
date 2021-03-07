import 'package:flutter/material.dart';

import 'package:flutter_tracker/models/tracker_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_tracker/models/workout_data_model.dart';
import 'package:provider/provider.dart';

class HomePage extends Page {
  final void Function(WorkoutDataModel) onWorkoutTap;

  HomePage(this.onWorkoutTap) : super(key: ValueKey('Home'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => HomeScreen(this.onWorkoutTap),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final void Function(WorkoutDataModel) onWorkoutTap;

  const HomeScreen(this.onWorkoutTap);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TrackerModel>(
      builder: (BuildContext context, model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).appTitle),
          ),
          body: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: model.workouts.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(model.workouts[i].title),
              onTap: () => this.widget.onWorkoutTap(model.workouts[i]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: context.read<TrackerModel>().addWorkout,
            tooltip: AppLocalizations.of(context).addWorkout_tooltip,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
