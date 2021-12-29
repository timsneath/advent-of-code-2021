import 'dart:math' show min, max;

import 'line.dart';

class Field {
  final int width;
  final int height;
  late final List<List<int>> data;

  Field(this.width, this.height) {
    data = List<List<int>>.generate(
        width, (_) => List<int>.generate(height, (_) => 0));
  }

  void plotLine(Line line) {
    final lengthX = (line.to.x - line.from.x).abs() + 1;
    final lengthY = (line.to.x - line.from.x).abs() + 1;
    final originX = min(line.to.x, line.from.x);
    final originY = min(line.to.y, line.from.y);

    for (var delta = 0; delta < max(lengthX, lengthY); delta++) {
      final deltaX = line.to.x != line.from.x ? delta : 0;
      final deltaY = line.to.y != line.from.y ? delta : 0;

      data[originY + deltaY][originX + deltaX]++;
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
    for (final row in data) {
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
    return ([for (var row in data) ...row]
          ..retainWhere((element) => element > 1))
        .length;
  }
}
