import 'package:test/test.dart';

import '../day06/day06.dart';

void main() {
  test('Simple example', () {
    final fish = LanternFish([3]);
    fish.addDay();
    expect(fish.fishList, equals([2]));
    fish.addDay();
    expect(fish.fishList, equals([1]));
    fish.addDay();
    expect(fish.fishList, equals([0]));
    fish.addDay();
    expect(fish.fishList, equals([6, 8]));
    fish.addDay();
    expect(fish.fishList, equals([5, 7]));
  });

  test('Sample after 18 days', () {
    final fish = LanternFish([3, 4, 3, 1, 2]);
    fish.addDays(18);

    expect(
        fish.fishList,
        equals([
          6, 0, 6, 4, 5, // first generation
          6, 0, 1, 1, 2, 6, 0, 1, 1, 1, 2, 2, 3, 3, 4, 6, 7, 8, 8, 8, 8
        ]));
    expect(fish.count, equals(26));
  });

  test('Sample after 80 days', () {
    final fish = LanternFish([3, 4, 3, 1, 2]);
    fish.addDays(80);

    expect(fish.count, equals(5934));
  });

  // test('Sample after 256 days', () {
  //   final fish = LanternFish([3, 4, 3, 1, 2]);
  //   fish.addDays(256);

  //   expect(fish.count, equals(26984457539));
  // });
}
