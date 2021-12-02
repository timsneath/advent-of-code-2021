import 'package:test/test.dart';

import '../day01/day01.dart';

void main() {
  group('Part 1', () {
    test('Empty stream', () async {
      final depths = Stream.fromIterable(<int>[]);
      final increases = await tallyDepthIncreases(depths);
      expect(increases, equals(0));
    });

    test('Increasing depths', () async {
      final depths = Stream.fromIterable([0, 1, 2]);
      final increases = await tallyDepthIncreases(depths);
      expect(increases, equals(2));
    });

    test('Decreasing depths', () async {
      final depths = Stream.fromIterable([2, 1, 0]);
      final increases = await tallyDepthIncreases(depths);
      expect(increases, equals(0));
    });

    test('Descend and increase', () async {
      final depths = Stream.fromIterable([1, 2, 3, 2, 1]);
      final increases = await tallyDepthIncreases(depths);
      expect(increases, equals(2));
    });

    test('Given test', () async {
      final depths = Stream.fromIterable(
          [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]);
      final increases = await tallyDepthIncreases(depths);
      expect(increases, equals(7));
    });
  });

  group('Part 2', () {
    test('Empty stream', () async {
      final depths = Stream.fromIterable(<int>[]);
      final increases = await tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(0));
    });

    test('Increasing depths', () async {
      final depths = Stream.fromIterable([0, 1, 2, 3, 4, 5, 6, 7]);
      final increases = await tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(5));
    });

    test('Decreasing depths', () async {
      final depths = Stream.fromIterable([7, 6, 5, 4, 3, 2, 1, 0]);
      final increases = await tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(0));
    });

    test('Descend and increase', () async {
      final depths = Stream.fromIterable([1, 2, 3, 4, 3, 2, 1]);
      final increases = await tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(2));
    });

    test('Given test', () async {
      final depths = Stream.fromIterable(
          [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]);
      final increases = await tallySlidingWindowDepthIncreases(depths);
      expect(increases, equals(5));
    });
  });
}
