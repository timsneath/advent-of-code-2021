import 'dart:io';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

@immutable
class LanternFish {
  // Number of fish at each timer level
  final List<int> fishDist;

  const LanternFish(this.fishDist);

  factory LanternFish.fromFishTally(List<int> fishTally) =>
      LanternFish(List<int>.generate(
          9, (index) => fishTally.where((element) => element == index).length));

  /// Returns a new fish distribution after a day's cycle has passed.
  LanternFish nextDay() {
    final spawning = fishDist.first;

    // Rotate entries above 0 down by 1
    final newFishDist = fishDist.skip(1).toList();

    // After spawning, parent fish have a timer of 6
    newFishDist[6] += spawning; // parent
    newFishDist.add(spawning); // child

    return LanternFish(newFishDist);
  }

  /// Returns a new fish distribution after the given number of days.
  LanternFish nextDays(int days) {
    var fish = this;
    for (var idx = 0; idx < days; idx++) {
      fish = fish.nextDay();
    }
    return fish;
  }

  int get count => fishDist.sum;

  @override
  int get hashCode => fishDist.reduce((a, b) => (a + 1) * (b + 1));

  @override
  bool operator ==(Object other) =>
      other is LanternFish &&
      const ListEquality<int>().equals(fishDist, other.fishDist);

  @override
  String toString() => fishDist.toString();
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day06/day06.txt';
  final rawData = File(path).readAsLinesSync();

  final fishData = rawData[0].split(',').map<int>(int.parse).toList();

  final fish80Days = LanternFish(fishData).nextDays(80);
  print('After 80 days, there are ${fish80Days.count} fish.');

  final fish256Days = LanternFish(fishData).nextDays(256);
  print('After 256 days, there are ${fish256Days.count} fish.');
}
// coverage:ignore-end
