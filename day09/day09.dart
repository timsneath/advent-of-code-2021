import 'dart:io';

class HeightMap {
  final List<List<int>> data;

  HeightMap(this.data);

  int at(int x, int y) => data[y][x];

  bool isLowerNorth(int x, int y) => y > 0 && at(x, y - 1) < at(x, y);
  bool isLowerEast(int x, int y) =>
      x < data.first.length - 1 && at(x + 1, y) < at(x, y);
  bool isLowerSouth(int x, int y) =>
      y < data.length - 1 && at(x, y + 1) < at(x, y);
  bool isLowerWest(int x, int y) => x > 0 && at(x - 1, y) < at(x, y);

  bool isLowest(int x, int y) =>
      !isLowerNorth(x, y) &&
      !isLowerEast(x, y) &&
      !isLowerWest(x, y) &&
      !isLowerSouth(x, y);

  factory HeightMap.fromRawData(List<String> rawData) {
    final List<List<int>> converted = [];
    for (final row in rawData) {
      final cols = row.split('').map((e) => int.parse(e)).toList();
      converted.add(cols);
    }
    return HeightMap(converted);
  }

  List<int> get lowPointRiskLevels {
    final riskLevels = <int>[];
    for (var y = 0; y < data.length; y++) {
      for (var x = 0; x < data.first.length; x++) {
        if (isLowest(x, y)) {
          riskLevels.add(at(x, y) + 1);
        }
      }
    }
    return riskLevels;
  }
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day09/day09.txt';
  final rawData = File(path).readAsLinesSync();
  final heightMap = HeightMap.fromRawData(rawData);
  final riskLevels = heightMap.lowPointRiskLevels.reduce((v, e) => v + e);

  print('Sum of lowest risk levels: $riskLevels');
}
