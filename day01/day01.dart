import 'dart:convert';
import 'dart:io';

import '../shared/utils.dart';

Future<int> tallyDepthIncreases(Stream<int> depths) async {
  int currentDepth = maxInt;
  var depthIncreaseCount = 0;

  await for (final newDepth in depths) {
    if (newDepth > currentDepth) {
      depthIncreaseCount++;
    }
    currentDepth = newDepth;
  }

  return depthIncreaseCount;
}

void main(List<String> args) async {
  final path = args.isNotEmpty ? args[0] : 'day01/day01.txt';
  final depthStream = File(path)
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .map((depth) => int.parse(depth));

  final depthIncreases = await tallyDepthIncreases(depthStream);
  print('Number of increased depths: $depthIncreases');
}
