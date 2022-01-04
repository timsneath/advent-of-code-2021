import 'dart:io';

import 'package:collection/collection.dart';

class LanternFish {
  // Number of fish at each timer level
  List<int> fishDist;

  LanternFish(List<int> fishTally)
      : fishDist = List<int>.generate(9,
            (index) => fishTally.where((element) => element == index).length);

  void addDay() {
    final spawning = fishDist.first;

    // Rotate entries above 0 down by 1
    fishDist = fishDist.skip(1).toList();

    // After spawning, parent fish have a timer of 6
    fishDist[6] += spawning; // parent
    fishDist.add(spawning); // child
  }

  void addDays(int days) {
    for (var idx = 0; idx < days; idx++) {
      addDay();
    }
  }

  int get count => fishDist.sum;

  @override
  int get hashCode => fishDist.hashCode;

  @override
  bool operator ==(Object other) =>
      other is LanternFish &&
      ListEquality<int>().equals(fishDist, other.fishDist);

  @override
  String toString() => fishDist.toString();
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day06/day06.txt';
  final rawData = File(path).readAsLinesSync();

  final fishData = rawData[0].split(',').map<int>((e) => int.parse(e)).toList();

  final lanternFish = LanternFish(fishData);
  lanternFish.addDays(80);
  print('After 80 days, there are ${lanternFish.count} fish.');

  final moreLanternFish = LanternFish(fishData);
  moreLanternFish.addDays(256);
  print('After 256 days, there are ${moreLanternFish.count} fish.');
}
// coverage:ignore-end
