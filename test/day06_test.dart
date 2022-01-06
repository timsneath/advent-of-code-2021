import 'package:test/test.dart';

import '../day06/day06.dart';

void main() {
  test('Equality match', () {
    final fish = LanternFish.fromFishTally(const [3, 1, 4, 1]);
    final sameFish = LanternFish.fromFishTally(const [3, 1, 4, 1]);
    expect(sameFish, equals(fish));
    expect(sameFish.hashCode, equals(fish.hashCode));

    final newFish = fish.nextDay();
    expect(newFish, isNot(equals(fish)));
    expect(newFish.hashCode, isNot(equals(fish.hashCode)));
  });

  test('Convert lists of fish into tally represenation', () {
    final fish = LanternFish.fromFishTally(const [3]);
    expect(fish.fishDist, equals([0, 0, 0, 1, 0, 0, 0, 0, 0]));
    expect(fish.toString(), equals('[0, 0, 0, 1, 0, 0, 0, 0, 0]'));
  });

  test('Follow fish through days', () {
    var fish = LanternFish.fromFishTally(const [3]);
    expect(fish.fishDist, equals([0, 0, 0, 1, 0, 0, 0, 0, 0]));
    fish = fish.nextDay();
    expect(fish.fishDist, equals([0, 0, 1, 0, 0, 0, 0, 0, 0]));
    fish = fish.nextDay();
    expect(fish.fishDist, equals([0, 1, 0, 0, 0, 0, 0, 0, 0]));
    fish = fish.nextDay();
    expect(fish.fishDist, equals([1, 0, 0, 0, 0, 0, 0, 0, 0]));
    fish = fish.nextDay();
    expect(fish.fishDist, equals([0, 0, 0, 0, 0, 0, 1, 0, 1]));
    fish = fish.nextDay();
    expect(fish.fishDist, equals([0, 0, 0, 0, 0, 1, 0, 1, 0]));
  });

  test('Sample after multiple days', () {
    var fish = LanternFish.fromFishTally(const [3, 4, 3, 1, 2]);
    fish = fish.nextDay(); // day 1
    expect(fish, equals(LanternFish.fromFishTally(const [2, 3, 2, 0, 1])));

    fish = fish.nextDay(); // day 2
    expect(fish, equals(LanternFish.fromFishTally(const [1, 2, 1, 6, 0, 8])));

    fish = fish.nextDay(); // day 3
    expect(
        fish, equals(LanternFish.fromFishTally(const [0, 1, 0, 5, 6, 7, 8])));

    fish = fish.nextDay(); // day 4
    expect(fish,
        equals(LanternFish.fromFishTally(const [6, 0, 6, 4, 5, 6, 7, 8, 8])));

    fish = fish.nextDay(); // day 5
    expect(
        fish,
        equals(
            LanternFish.fromFishTally(const [5, 6, 5, 3, 4, 5, 6, 7, 7, 8])));

    fish = fish.nextDay(); // day 6
    expect(
        fish,
        equals(
            LanternFish.fromFishTally(const [4, 5, 4, 2, 3, 4, 5, 6, 6, 7])));

    fish = fish.nextDay(); // day 7
    expect(
        fish,
        equals(
            LanternFish.fromFishTally(const [3, 4, 3, 1, 2, 3, 4, 5, 5, 6])));
  });

  test('Sample after 18 days', () {
    final fish = LanternFish.fromFishTally(const [3, 4, 3, 1, 2]).nextDays(18);

    // fishTally == 6, 0, 6, 4, 5, 6, 0, 1, 1, 2, 6, 0, 1,
    //              1, 1, 2, 2, 3, 3, 4, 6, 7, 8, 8, 8, 8
    expect(fish.fishDist, equals([3, 5, 3, 2, 2, 1, 5, 1, 4]));
    expect(fish.count, equals(26));
  });

  test('Sample after 80 days', () {
    final fish = LanternFish.fromFishTally(const [3, 4, 3, 1, 2]).nextDays(80);

    expect(fish.count, equals(5934));
  });

  test('Sample after 256 days', () {
    final fish = LanternFish.fromFishTally(const [3, 4, 3, 1, 2]).nextDays(256);

    expect(fish.count, equals(26984457539));
  });
}
