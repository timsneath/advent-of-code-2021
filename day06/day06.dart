import 'dart:io';

import 'package:collection/collection.dart';

class LanternFish {
  List<int> fishTally;

  LanternFish(this.fishTally) {
    fishTally = List<int>.generate(
        8, (index) => fishTally.where((element) => element == index).length);
  }

  void addDay() {
    fishTally = [...fishTally.skip(1), fishTally.first];
    fishTally[5] += fishTally[7];
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

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day06/day06.txt';
  final rawData = File(path).readAsLinesSync();

  final fishData = rawData[0].split(',').map<int>((e) => int.parse(e)).toList();
  final lanternFish = LanternFish(fishData);

  lanternFish.addDays(80);
  print('After 80 days, there are ${lanternFish.count} fish.');

  lanternFish.addDays(256);
  print('After 256 days, there are ${lanternFish.count} fish.');
}
