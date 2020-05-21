import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/model/station.dart';
import '../bloc/station_state.dart';
import '../bloc/stations_bloc.dart';
import '../bloc/stations_event.dart';

/// Widget showing currently playing station.
class PlayerBar extends StatelessWidget {
  /// Currently selected station.
  final Station currentStation;

  /// Current playback status: playing, buffering.
  final PlaybackStatus playbackStatus;

  /// Requires [currentStation], [playbackStatus].
  const PlayerBar({
    Key key,
    @required this.currentStation,
    @required this.playbackStatus,
  })  : assert(null != currentStation),
        assert(null != playbackStatus),
        super(key: key);

  Widget get _playbackWidget {
    switch (playbackStatus) {
      case PlaybackStatus.playing:
        return Icon(Icons.pause, color: Colors.white, size: 48.0);
      case PlaybackStatus.paused:
        return Icon(Icons.play_arrow, color: Colors.white, size: 48.0);
      case PlaybackStatus.error:
        return Icon(Icons.error, color: Colors.red, size: 48.0);
      case PlaybackStatus.buffering:
        return SizedBox(
          width: 48.0,
          height: 48.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(backgroundColor: Colors.white),
          ),
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = currentStation.logoUrl;
    final stationName = currentStation.name;

    return Container(
      height: 64.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[400]),
      child: Row(
        children: [
          SizedBox(
            width: 48.0,
            height: 48.0,
            child: Image.network(imageUrl, fit: BoxFit.contain),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              stationName,
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          FlatButton(
            onPressed: () => BlocProvider.of<StationsBloc>(context)
                .add(StationsTogglePlayback()),
            child: _playbackWidget,
          )
        ],
      ),
    );
  }
}
