import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/station_state.dart';
import 'bloc/stations_bloc.dart';
import 'bloc/stations_event.dart';
import 'widget/player_bar.dart';
import 'widget/station_item.dart';
import 'widget/stations_app_bar.dart';

/// Page for stations list.
class StationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StationsAppBar(),
      body: BlocBuilder<StationsBloc, StationsState>(
        builder: (context, state) {
          if (state is StationsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StationsError) {
            return Center(child: Text('Error'));
          } else if (state is StationsLoaded) {
            return ListView.builder(
              itemCount: state.stations.length,
              itemBuilder: (context, index) {
                final station = state.stations[index];
                return InkWell(
                  child: StationItem(station: station),
                  onTap: () => BlocProvider.of<StationsBloc>(context)
                      .add(StationsSelect(selectedStation: station)),
                );
              },
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<StationsBloc, StationsState>(
        builder: (context, state) {
          final currentStation =
              state is StationsLoaded ? state.selectedStation : null;
          final playbackStatus =
              state is StationsLoaded ? state.playbackStatus : null;

          if (null != currentStation) {
            return PlayerBar(
              currentStation: currentStation,
              playbackStatus: playbackStatus,
            );
          } else {
            return const SizedBox(width: 0, height: 0);
          }
        },
      ),
    );
  }
}
