import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../repository/model/station.dart';
import 'station_state.dart';

/// Generic class for all events.
abstract class StationsEvent extends Equatable {
  ///
  const StationsEvent();

  @override
  List<Object> get props => [];
}

/// Reloads current stations.
class StationsRefresh extends StationsEvent {
  ///
  const StationsRefresh();
}

/// Triggered when User select station.
class StationsSelect extends StationsEvent {
  /// Selected station.
  final Station selectedStation;

  /// Requires [selectedStation].
  const StationsSelect({@required this.selectedStation});

  @override
  List<Object> get props => [selectedStation];

  @override
  String toString() => 'StationsPlay(station: $selectedStation)';
}

/// Updates playback status.
/// It's needed for internal updates for example: buffering -> playing.
class PlaybackStatusUpdate extends StationsEvent {
  /// New status.
  final PlaybackStatus status;

  /// Requires [status].
  const PlaybackStatusUpdate({@required this.status});

  @override
  List<Object> get props => [status];

  @override
  String toString() => 'PlaybackStatusUpdate(status: $status)';
}

/// Triggered when User press "play" or "pause".
class StationsTogglePlayback extends StationsEvent {
  ///
  const StationsTogglePlayback();
}
