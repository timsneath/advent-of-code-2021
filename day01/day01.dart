import 'dart:collection';
import 'dart:io';

import 'package:collection/collection.dart';

import '../shared/utils.dart';

int tallyDepthIncreases(Iterable<int> depths) {
  int currentDepth = maxInt;
  int count = 0;

  for (final newDepth in depths) {
    if (newDepth > currentDepth) count++;

    currentDepth = newDepth;
  }

  return count;
}

int tallySlidingWindowDepthIncreases(Iterable<int> depths) {
  final window = ListQueue<int>(4);
  int count = 0;

  for (final depth in depths) {
    window.addLast(depth);
    if (window.length < 4) continue;

    final currentWindow = window.take(3).sum;
    final newWindow = window.skip(1).sum;
    if (newWindow > currentWindow) count++;

    window.removeFirst();
  }

  return count;
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day01/day01.txt';
  final rawData = File(path).readAsLinesSync();
  final depths = rawData.map((row) => int.parse(row));

  final depthIncreases = tallyDepthIncreases(depths);
  print('Number of increased depths: $depthIncreases');

  final depthIncreasesSlidingWindow = tallySlidingWindowDepthIncreases(depths);
  print('Number of increased depths: $depthIncreasesSlidingWindow');
}
// coverage:ignore-end
