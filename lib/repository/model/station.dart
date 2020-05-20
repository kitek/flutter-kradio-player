import 'package:equatable/equatable.dart';

/// Radio Station model representation.
class Station extends Equatable {
  /// Name of the radio station.
  final String name;

  /// URL to stream.
  final String streamUrl;

  /// URL to image.
  final String logoUrl;

  /// List of genre.
  final List<String> genre;

  ///
  const Station({
    this.name,
    this.streamUrl,
    this.logoUrl,
    this.genre,
  });

  /// Creates Station from JSON map.
  static Station fromJson(dynamic json) {
    return Station(
      name: json['name'] as String ?? '',
      streamUrl: json['streamUrl'] as String ?? '',
      logoUrl: json['logoUrl'] as String ?? '',
      genre: (json['genre'] as Map<String, dynamic>).keys.toList(),
    );
  }

  @override
  List<Object> get props => [name, streamUrl, logoUrl, genre];

  @override
  String toString() => 'Station(name: $name)';
}
