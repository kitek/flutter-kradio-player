import 'package:flutter_test/flutter_test.dart';
import 'package:kradioplayer/repository/station_repository.dart';
import 'package:mockito/mockito.dart';

import '../mock.dart';

void main() {
  group('StationRepository', () {
    test('should return list of stations', () async {
      // Given
      final mockedClient = MockApiClient();
      when(mockedClient.listStations())
          .thenAnswer((_) => Future.value(mockStations));
      final repo = StationRepository(apiClient: mockedClient);
      // When
      final stations = await repo.listStations();
      // Then
      expect(stations, mockStations);
    });
  });
}
