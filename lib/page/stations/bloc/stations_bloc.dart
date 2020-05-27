import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../../../repository/model/station.dart';
import '../../../repository/station_repository.dart';
import 'station_state.dart';
import 'stations_event.dart';

/// Bloc for StationsPage.
class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final StationRepository _repository;
  final _player = AudioPlayer();

  bool _isPendingPlay = false;
  List<Station> _stations = [];
  Station _selectedStation;
  PlaybackStatus _playbackStatus = PlaybackStatus.buffering;
  StreamSubscription<FullAudioPlaybackState> _streamSubscription;

  /// Requires [repository].
  StationsBloc({@required StationRepository repository})
      : assert(null != repository),
        _repository = repository;

  @override
  StationsState get initialState => StationsLoading();

  @override
  Stream<StationsState> mapEventToState(StationsEvent event) async* {
    if (event is StationsRefresh) {
      yield* _fetchStations();
    } else if (event is StationsSelect) {
      yield* _changeStation(event);
    } else if (event is PlaybackStatusUpdate) {
      yield* _updatePlaybackStatus(event.status);
    } else if (event is StationsTogglePlayback) {
      yield* _togglePlaybackStatus();
    }
  }

  Stream<StationsState> _fetchStations() async* {
    try {
      _stations = await _repository.listStations();
      yield _createLoadedState();
    } on Exception catch (e) {
      yield StationsError(error: e);
    }
  }

  Stream<StationsState> _changeStation(StationsSelect event) async* {
    if (_selectedStation == event.selectedStation) return;

    _selectedStation = event.selectedStation;
    _playbackStatus = PlaybackStatus.buffering;
    yield _createLoadedState();

    _subscribeToStream();

    _isPendingPlay = true;
    await _player.setUrl(event.selectedStation.streamUrl);
  }

  StationsLoaded _createLoadedState() {
    return StationsLoaded(
      stations: _stations,
      selectedStation: _selectedStation,
      playbackStatus: _playbackStatus,
    );
  }

  void _subscribeToStream() {
    if (null == _streamSubscription) {
      _streamSubscription = _player.fullPlaybackStateStream.listen((event) {
        final isBuffering = event.buffering == true;
        final isPaused = [
          AudioPlaybackState.paused,
          AudioPlaybackState.stopped,
        ].contains(event.state);

        if (event.state == AudioPlaybackState.connecting || isBuffering) {
          add(PlaybackStatusUpdate(status: PlaybackStatus.buffering));
        } else if (event.state == AudioPlaybackState.playing) {
          _isPendingPlay = false;
          add(PlaybackStatusUpdate(status: PlaybackStatus.playing));
        } else if (isPaused) {
          add(PlaybackStatusUpdate(status: PlaybackStatus.paused));
          if(_isPendingPlay) {
            _isPendingPlay = false;
            _playbackStatus = PlaybackStatus.playing;
            _player.play();
          }
        }
      }, onError: (_) {
        _isPendingPlay = false;
        add(PlaybackStatusUpdate(status: PlaybackStatus.error));
      });
    }
  }

  Stream<StationsState> _updatePlaybackStatus(PlaybackStatus status) async* {
    if (_playbackStatus == status) return;

    _playbackStatus = status;
    yield _createLoadedState();
  }

  Stream<StationsState> _togglePlaybackStatus() async* {
    if (_playbackStatus == PlaybackStatus.paused) {
      _playbackStatus = PlaybackStatus.playing;
      _player.play();
      yield _createLoadedState();
    } else if (_playbackStatus == PlaybackStatus.playing) {
      _playbackStatus = PlaybackStatus.paused;
      await _player.pause();
      yield _createLoadedState();
    }
  }

  @override
  Future<void> close() async {
    await _disposePlayer();
    return super.close();
  }

  void _disposePlayer() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    await _gracefullyStopPlayer();
    await _player.dispose();
  }

  void _gracefullyStopPlayer() async {
    try {
      await _player.stop();
    } on Exception catch (_) {}
  }
}
