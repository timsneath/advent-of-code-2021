import 'package:test/test.dart';

import '../day06/day06.dart';

void main() {
  test('Convert lists of fish into tally represenation', () {
    final fish = LanternFish([3]);
    expect(fish.fishTally, equals([0, 0, 0, 1, 0, 0, 0, 0]));
  });

  test('Follow fish through days', () {
    final fish = LanternFish([3]);
    expect(fish.fishTally, equals([0, 0, 0, 1, 0, 0, 0, 0]));
    fish.addDay();
    expect(fish.fishTally, equals([0, 0, 1, 0, 0, 0, 0, 0]));
    fish.addDay();
    expect(fish.fishTally, equals([0, 1, 0, 0, 0, 0, 0, 0]));
    fish.addDay();
    expect(fish.fishTally, equals([1, 0, 0, 0, 0, 0, 0, 0]));
    fish.addDay();
    expect(fish.fishTally, equals([0, 0, 0, 0, 0, 1, 0, 1]));
    fish.addDay();
    expect(fish.fishTally, equals([0, 0, 0, 0, 1, 0, 1, 0]));
  });

  test('Sample after multiple days', () {
    final fish = LanternFish([3, 4, 3, 1, 2]);

    fish.addDay(); // day 1
    expect(fish, equals(LanternFish([2, 3, 2, 0, 1])));

    fish.addDay(); // day 2
    expect(fish, equals(LanternFish([1, 2, 1, 6, 0, 8])));

    fish.addDay(); // day 3
    expect(fish, equals(LanternFish([0, 1, 0, 5, 6, 7, 8])));

    fish.addDay(); // day 4
    expect(fish, equals(LanternFish([6, 0, 6, 4, 5, 6, 7, 8, 8])));

    fish.addDay(); // day 5
    expect(fish, equals(LanternFish([5, 6, 5, 3, 4, 5, 6, 7, 7, 8])));

    fish.addDay(); // day 6
    expect(fish, equals(LanternFish([4, 5, 4, 2, 3, 4, 5, 6, 6, 7])));

    fish.addDay(); // day 7
    expect(fish, equals(LanternFish([3, 4, 3, 1, 2, 3, 4, 5, 5, 6])));
  });

  test('Sample after 18 days', () {
    final fish = LanternFish([3, 4, 3, 1, 2]);
    fish.addDays(18);

    // fishList == 6, 0, 6, 4, 5, 6, 0, 1, 1, 2, 6, 0, 1,
    //             1, 1, 2, 2, 3, 3, 4, 6, 7, 8, 8, 8, 8
    expect(fish.fishTally, equals([3, 5, 3, 2, 2, 1, 5, 1, 4]));
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
