import 'package:flutter/foundation.dart';

import 'api_client.dart';
import 'model/station.dart';

/// Provides access to radio stations.
class StationRepository {
  final ApiClient _apiClient;

  /// Creates repo. Requires [apiClient].
  StationRepository({@required ApiClient apiClient})
      : assert(null != apiClient),
        _apiClient = apiClient;

  /// Returns list of stations.
  Future<List<Station>> listStations() {
    return _apiClient.listStations();
  }
}
