import 'package:kradioplayer/repository/api_client.dart';
import 'package:kradioplayer/repository/model/station.dart';
import 'package:mockito/mockito.dart';

final Station mockStation = Station(
  name: 'Awesome station',
  streamUrl: 'http://awesome-station-stream.com/',
  logoUrl: 'http://awesome-station.com/logo.png',
  genre: ['pop', 'rock'],
);

final List<Station> mockStations = [mockStation, mockStation];

class MockApiClient extends Mock implements ApiClient {}

extension StationCopy on Station {
  Station copyWith({
    String name,
    String streamUrl,
    String logoUrl,
    List<String> genre,
  }) {
    return Station(
      name: name ?? this.name,
      streamUrl: streamUrl ?? this.streamUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      genre: genre ?? this.genre,
    );
  }
}
