import 'dart:io';
import 'dart:math' show min, max;

import 'line.dart';

class Field {
  final int width;
  final int height;
  late final List<List<int>> field;

  Field(this.width, this.height) {
    field = List<List<int>>.generate(
        width, (_) => List<int>.generate(height, (_) => 0));
  }

  void plotLine(Line line) {
    if (line.isHorizontal) {
      final length = (line.to.x - line.from.x).abs() + 1;
      final origin = min(line.to.x, line.from.x);
      for (var delta = 0; delta < length; delta++) {
        field[line.from.y][origin + delta]++;
      }
    }

    if (line.isVertical) {
      final length = (line.to.y - line.from.y).abs() + 1;
      final origin = min(line.to.y, line.from.y);
      for (var delta = 0; delta < length; delta++) {
        field[origin + delta][line.from.x]++;
      }
    }
  }

  void plotLines(List<Line> lines) {
    for (final line in lines) {
      plotLine(line);
    }
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    for (final row in field) {
      for (final col in row) {
        if (col == 0) {
          buffer.write('.');
        } else {
          buffer.write(col);
        }
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  int countOverlaps() {
    return ([for (var row in field) ...row]
          ..retainWhere((element) => element > 1))
        .length;
  }
}

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
