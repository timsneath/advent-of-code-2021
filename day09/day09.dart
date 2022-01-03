import 'dart:io';

import 'package:collection/collection.dart';

class BasinMap {
  HeightMap heightMap;
  late final List<List<int?>> basinData;

  int basinCount = 0;

  BasinMap(this.heightMap) {
    // We calculate the current basins in the following way:
    // - We create a two-dimensional array of the same size as the heightmap
    //   itself.
    // - We start with each cell being null (that is, untraversed).
    // - A cell marked with -1 is a boundary (i.e. a 9 value, not part of a
    //   basin).
    // - For other cells, we work top to bottom. When we find an untraversed
    //   cell, we find all other cells that are part of the same basin by
    //   searching in all four directions recursively until we've found all
    //   cells in the same basin.
    // - We continue until there are no remaining untraversed cells.

    basinData = List<List<int?>>.generate(heightMap.height,
        (_) => List<int?>.generate(heightMap.width, (_) => null));

    for (var y = 0; y < heightMap.height; y++) {
      for (var x = 0; x < heightMap.width; x++) {
        if (basinData[y][x] == null) {
          // we've found an untraversed basin
          findBasin(basinCount++, x, y);
        }
      }
    }
  }

  void findBasin(int currentBasin, int x, int y) {
    if ((x < 0 || x >= heightMap.width) || (y < 0 || y >= heightMap.height)) {
      // Out of bounds.
      return;
    }
    if (heightMap.at(x, y) == 9) {
      // This cell is not in a basin.
      basinData[y][x] = -1;
      return;
    }
    if (basinData[y][x] != null) {
      // This cell has already been allocated to a basin. All done.
      return;
    }
    basinData[y][x] = currentBasin;
    findBasin(currentBasin, x - 1, y);
    findBasin(currentBasin, x + 1, y);
    findBasin(currentBasin, x, y - 1);
    findBasin(currentBasin, x, y + 1);
  }

  List<int> findBasinSizes() {
    final flattenedData = basinData.flattened;
    List<int> basinSizes = <int>[];
    for (var basinIndex = 0; basinIndex <= basinCount; basinIndex++) {
      final basinSize = flattenedData.where((e) => e == basinIndex);
      if (basinSize.isNotEmpty) {
        basinSizes.add(basinSize.length);
      }
    }
    basinSizes.sort();
    return basinSizes.reversed.toList();
  }
}

class HeightMap {
  final List<List<int>> data;

  HeightMap(this.data);

  int get width => data.first.length;
  int get height => data.length;

  int at(int x, int y) => data[y][x];

  bool isLowerNorth(int x, int y) => y > 0 && at(x, y - 1) <= at(x, y);
  bool isLowerEast(int x, int y) =>
      x < data.first.length - 1 && at(x + 1, y) <= at(x, y);
  bool isLowerSouth(int x, int y) =>
      y < data.length - 1 && at(x, y + 1) <= at(x, y);
  bool isLowerWest(int x, int y) => x > 0 && at(x - 1, y) <= at(x, y);

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

  List<int> get lowPoints {
    final riskLevels = <int>[];
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (isLowest(x, y)) {
          riskLevels.add(at(x, y));
        }
      }
    }
    return riskLevels;
  }

  Iterable<int> get riskLevels => lowPoints.map((p) => p + 1);

  int get sumOfLowPointRiskLevels => riskLevels.sum;
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day09/day09.txt';
  final rawData = File(path).readAsLinesSync();
  final heightMap = HeightMap.fromRawData(rawData);
  print('Number of low points: ${heightMap.lowPoints.length}');
  print('Sum of lowest risk levels: ${heightMap.sumOfLowPointRiskLevels}');

  final basins = BasinMap(heightMap);
  final basinSizes = basins.findBasinSizes();
  final product = basinSizes.take(3).reduce((v, e) => v * e);
  print('Number of basins: ${basins.basinData.length}');
  print('Product of three largest basin sizes: $product');
}
// coverage:ignore-end
