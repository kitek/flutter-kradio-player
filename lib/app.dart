import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'page/stations/bloc/stations_bloc.dart';
import 'page/stations/bloc/stations_event.dart';
import 'page/stations/stations_page.dart';
import 'repository/station_repository.dart';

/// Top level widget.
class App extends StatelessWidget {
  final StationRepository _repository;

  /// Requires [repository].
  const App({Key key, @required StationRepository repository})
      : assert(null != repository),
        _repository = repository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kRadio Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<StationsBloc>(
        create: (context) =>
            StationsBloc(repository: _repository)..add(StationsRefresh()),
        child: StationsPage(),
      ),
    );
  }
}
