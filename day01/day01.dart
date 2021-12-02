import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import '../shared/utils.dart';

Future<int> tallyDepthIncreases(Stream<int> depths) async {
  int currentDepth = maxInt;
  int count = 0;

  await for (final newDepth in depths) {
    if (newDepth > currentDepth) count++;

    currentDepth = newDepth;
  }

  return count;
}

int sum(int a, int b) => a + b;

Future<int> tallySlidingWindowDepthIncreases(Stream<int> depths) async {
  final window = ListQueue<int>(4);
  int count = 0;

  await for (final depth in depths) {
    window.addLast(depth);
    if (window.length < 4) continue;

    final currentWindow = window.take(3).reduce(sum);
    final newWindow = window.skip(1).reduce(sum);
    if (newWindow > currentWindow) count++;

    window.removeFirst();
  }

  return count;
}

void main(List<String> args) async {
  final path = args.isNotEmpty ? args[0] : 'day01/day01.txt';
  final depthStream = File(path)
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .map((depth) => int.parse(depth));

  final depthIncreases = await tallySlidingWindowDepthIncreases(depthStream);
  print('Number of increased depths: $depthIncreases');
}
