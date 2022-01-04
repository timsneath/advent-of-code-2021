import 'package:test/test.dart';

import '../day01/day01.dart';

void main() {
  group('Part 1', () {
    test('Empty stream', () {
      final depths = <int>[];
      final increases = tallyDepthIncreases(depths);
      expect(increases, equals(0));
    });

    test('Increasing depths', () {
      final depths = <int>[0, 1, 2];
      final increases = tallyDepthIncreases(depths);
      expect(increases, equals(2));
    });

    test('Decreasing depths', () {
      final depths = <int>[2, 1, 0];
      final increases = tallyDepthIncreases(depths);
      expect(increases, equals(0));
    });

    test('Descend and increase', () {
      final depths = <int>[1, 2, 3, 2, 1];
      final increases = tallyDepthIncreases(depths);
      expect(increases, equals(2));
    });

    test('Given test', () {
      final depths = <int>[199, 200, 208, 210, 200, 207, 240, 269, 260, 263];
      final increases = tallyDepthIncreases(depths);
      expect(increases, equals(7));
    });
  });

  group('Part 2', () {
    test('Empty stream', () {
      final depths = <int>[];
      final increases = tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(0));
    });

    test('Increasing depths', () {
      final depths = [0, 1, 2, 3, 4, 5, 6, 7];
      final increases = tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(5));
    });

    test('Decreasing depths', () {
      final depths = [7, 6, 5, 4, 3, 2, 1, 0];
      final increases = tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(0));
    });

    test('Descend and increase', () {
      final depths = [1, 2, 3, 4, 3, 2, 1];
      final increases = tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(2));
    });

    test('Given test', () {
      final depths = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263];
      final increases = tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(5));
    });
  });
}
