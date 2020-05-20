import 'package:flutter/material.dart';
import '../../../repository/model/station.dart';

/// Widget for single item
class StationItem extends StatelessWidget {
  /// Station
  final Station station;

  /// Requires [station] to show.
  const StationItem({Key key, @required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 96.0,
            height: 96.0,
            child: Image.network(station.logoUrl, fit: BoxFit.contain),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 4.0),
                Text(
                  station.genre.join(','),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
