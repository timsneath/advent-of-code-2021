import 'dart:io';

import 'package:collection/collection.dart';

class LanternFish {
  // Number of fish at each timer level
  List<int> fishTally;

  LanternFish(this.fishTally) {
    fishTally = List<int>.generate(
        9, (index) => fishTally.where((element) => element == index).length);
  }

  void addDay() {
    final spawning = fishTally.first;

    // Rotate entries above 0 down by 1
    fishTally = fishTally.skip(1).toList();

    // After spawning, parent fish have a timer of 6
    fishTally[6] += spawning; // parent
    fishTally.add(spawning); // child
  }

  void addDays(int days) {
    for (var idx = 0; idx < days; idx++) {
      addDay();
    }
  }

  int get count => fishTally.fold(0, (p, e) => p + e);

  @override
  int get hashCode => fishTally.hashCode;

  @override
  bool operator ==(Object other) =>
      other is LanternFish &&
      ListEquality<int>().equals(fishTally, other.fishTally);

  @override
  String toString() => fishTally.toString();
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
