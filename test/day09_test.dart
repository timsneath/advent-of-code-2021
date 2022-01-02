import 'package:test/test.dart';

import '../day09/day09.dart';

const rawData = <String>[
  '2199943210',
  '3987894921',
  '9856789892',
  '8767896789',
  '9899965678'
];

void main() {
  test('Low points at origin', () {
    final heightMap = HeightMap.fromRawData(rawData);
    expect(heightMap.isLowerEast(0, 0), isTrue);
    expect(heightMap.isLowerWest(0, 0), isFalse);
    expect(heightMap.isLowerNorth(0, 0), isFalse);
    expect(heightMap.isLowerSouth(0, 0), isFalse);
  });

  test('Low points at furthest extent', () {
    final heightMap = HeightMap.fromRawData(rawData);
    expect(heightMap.isLowerEast(9, 4), isFalse);
    expect(heightMap.isLowerWest(9, 4), isTrue);
    expect(heightMap.isLowerNorth(9, 4), isFalse);
    expect(heightMap.isLowerSouth(9, 4), isFalse);
  });

  test('Low point in top right corner', () {
    final heightMap = HeightMap.fromRawData(rawData);
    expect(heightMap.isLowest(9, 0), isTrue);
  });

  test('Lowest points', () {
    final heightMap = HeightMap.fromRawData(rawData);
    expect(heightMap.lowPoints, unorderedEquals(<int>[1, 0, 5, 5]));
  });

  test('Risk levels', () {
    final heightMap = HeightMap.fromRawData(rawData);
    expect(heightMap.riskLevels, unorderedEquals(<int>[2, 1, 6, 6]));
  });

  test('Sum of lowest risk levels', () {
    final heightMap = HeightMap.fromRawData(rawData);
    expect(heightMap.sumOfLowPointRiskLevels, equals(15));
  });

  test('Basins for sample data', () {
    final heightMap = HeightMap.fromRawData(rawData);
    final basins = BasinMap(heightMap);

    expect(basins.basinData.first, equals([0, 0, -1, -1, -1, 3, 3, 3, 3, 3]));
  });

  test('Basin sizes for sample data', () {
    final heightMap = HeightMap.fromRawData(rawData);
    final basins = BasinMap(heightMap);
    final basinSizes = basins.findBasinSizes();

    expect(basinSizes.take(3), equals([14, 9, 9]));
  });
}
