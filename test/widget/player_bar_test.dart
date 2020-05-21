import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kradioplayer/page/stations/bloc/station_state.dart';
import 'package:kradioplayer/page/stations/widget/player_bar.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../mock.dart';
import '../utils.dart';

void main() {
  testWidgets('Should show station name', (tester) async {
    mockNetworkImagesFor(() async {
      // Given
      final coolStation = mockStation.copyWith(name: 'Cool station!');
      final playbackStatus = PlaybackStatus.paused;
      // When
      await tester.pumpWidget(wrapWithMaterial(
        PlayerBar(
          currentStation: coolStation,
          playbackStatus: playbackStatus,
        ),
      ));
      final nameFinder = find.text('Cool station!');
      // Then
      expect(nameFinder, findsOneWidget);
    });
  });
}
