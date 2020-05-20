import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../repository/model/station.dart';

/// Generic class for states.
abstract class StationsState extends Equatable {
  ///
  const StationsState();

  @override
  List<Object> get props => [];
}

/// State for loading.
class StationsLoading extends StationsState {
  ///
  const StationsLoading();
}

/// Loaded stations state with additional info.
class StationsLoaded extends StationsState {
  /// List of loaded stations.
  final List<Station> stations;

  /// Currently selected station.
  final Station selectedStation;

  /// Currently playback status: playing, buffering, etc.
  final PlaybackStatus playbackStatus;

  /// Flag for currently selected station.
  bool get hasSelectedStation => null != selectedStation;

  /// Requires list of [stations].
  /// Default [playbackStatus] is [PlaybackStatus.buffering].
  const StationsLoaded({
    @required this.stations,
    this.playbackStatus = PlaybackStatus.buffering,
    this.selectedStation,
  });

  @override
  List<Object> get props => [stations, selectedStation, playbackStatus];

  @override
  String toString() => 'StationsLoaded('
      'selectedStation: $selectedStation, '
      'stations: $stations,'
      'playbackStatus: $playbackStatus)';
}

/// State for errors.
class StationsError extends StationsState {
  /// Error what cause this state.
  final Exception error;

  /// Requires [error].
  const StationsError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'StationsError(error: $error)';
}

/// Playback status.
enum PlaybackStatus {
  /// Playing.
  playing,

  /// Paused.
  paused,

  /// Buffering.
  buffering,

  /// Error.
  error,
}
