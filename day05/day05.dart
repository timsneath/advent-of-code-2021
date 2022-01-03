import 'dart:io';

import 'plane.dart';
import '../shared/line.dart';

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day05/day05.txt';
  final rawData = File(path).readAsLinesSync();

  final lines = <Line>[];
  for (final row in rawData) {
    lines.add(Line.fromString(row));
  }

  final nonDiagonalLines =
      lines.where((line) => line.isHorizontal || line.isVertical);
  final plane = Plane.fromLines(nonDiagonalLines);
  print('Overlapping points (only horizontal and vertical): '
      '${plane.countOverlaps()}');

  final allPlane = Plane.fromLines(lines);
  print('Overlapping points (all): ${allPlane.countOverlaps()}');
}
// coverage:ignore-end
