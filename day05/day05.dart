import 'dart:io';
import 'dart:math' show max;

import 'plane.dart';
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

  final plane1 = Plane(width, height);
  for (final line in lines) {
    if (line.isHorizontal || line.isVertical) {
      plane1.plotLine(line);
    }
  }
  print('Overlapping points (only horizontal and vertical): '
      '${plane1.countOverlaps()}');

  final plane2 = Plane(width, height);
  plane2.plotLines(lines);

  print('Overlapping points (all): '
      '${plane2.countOverlaps()}');
}
