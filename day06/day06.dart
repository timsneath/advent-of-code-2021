import 'dart:io';

class LanternFish {
  final List<int> fishList;

  LanternFish(this.fishList);

  void addDay() {
    final startLength = fishList.length;
    for (var idx = 0; idx < startLength; idx++) {
      fishList[idx]--;

      // Spawn new lantern fish
      if (fishList[idx] == -1) {
        fishList[idx] = 6;
        fishList.add(8);
      }
    }
  }

  void addDays(int days) {
    for (var idx = 0; idx < days; idx++) {
      addDay();
    }
  }

  int get count => fishList.length;
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day06/day06.txt';
  final rawData = File(path).readAsLinesSync();

  final fishData = rawData[0].split(',').map<int>((e) => int.parse(e)).toList();
  final lanternFish = LanternFish(fishData);

  lanternFish.addDays(80);

  print('After 80 days, there are ${lanternFish.count} fish.');
}
