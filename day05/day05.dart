import 'dart:io';
import 'dart:math' show max;

import 'field.dart';
import 'line.dart';

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day05/day05.txt';
  final rawData = File(path).readAsLinesSync();

  final lines = <Line>[];
  for (final row in rawData) {
    lines.add(Line.fromString(row));
  }

  final width =
      lines.map((e) => max(e.from.y, e.to.y)).reduce((a, b) => max(a, b)) + 1;
  final height =
      lines.map((e) => max(e.from.x, e.to.x)).reduce((a, b) => max(a, b)) + 1;

  final field = Field(width, height);
  field.plotLines(lines);

  final overlaps = field.countOverlaps();
  print('Overlapping points: $overlaps');
}
