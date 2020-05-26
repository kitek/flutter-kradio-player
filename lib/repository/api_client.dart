import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'model/station.dart';

/// API HTTP Client.
class ApiClient {
  final http.Client _httpClient;
  static const _baseUrl = 'https://k-radio-player.firebaseio.com';

  /// Requires [httpClient].
  ApiClient({@required http.Client httpClient})
      : assert(null != httpClient),
        _httpClient = httpClient;

  /// Fetches stations from remote JSON API.
  /// Throws exception for non 200 responses.
  Future<List<Station>> listStations() async {
    final url = '$_baseUrl/stations.json';
    final response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('Can\'t fetch stations.');
    }

    try {
      final body = utf8.decode(response.bodyBytes);
      final items = json.decode(body) as Map<String, dynamic>;
      return items.entries.map((item) => Station.fromJson(item.value)).toList();
    } on Exception catch (_) {
      throw Exception('Can\'t parse response.');
    }
  }
}
