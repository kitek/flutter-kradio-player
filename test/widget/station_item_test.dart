import 'package:flutter_test/flutter_test.dart';
import 'package:kradioplayer/page/stations/widget/station_item.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../mock.dart';
import '../utils.dart';

void main() {
  testWidgets('Should show station name', (tester) async {
    mockNetworkImagesFor(() async {
      // Given
      final awesomeStation = mockStation;
      // When
      await tester.pumpWidget(wrapWithMaterial(
        StationItem(station: awesomeStation),
      ));
      final nameFinder = find.text('Awesome station');
      // Then
      expect(nameFinder, findsOneWidget);
    });
  });

  testWidgets('Should show station genre', (tester) async {
    mockNetworkImagesFor(() async {
      // Given
      final awesomeStation = mockStation;
      // When
      await tester.pumpWidget(wrapWithMaterial(
        StationItem(station: awesomeStation),
      ));
      final genreFinder = find.text('pop, rock');
      // Then
      expect(genreFinder, findsOneWidget);
    });
  });
}
