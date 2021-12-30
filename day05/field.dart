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
    final distX = line.to.x - line.from.x;
    final distY = line.to.y - line.from.y;

    final steps = max(distX.abs(), distY.abs());

    final deltaX = (distX / steps).ceil();
    final deltaY = (distY / steps).ceil();

    for (var delta = 0; delta <= steps; delta++) {
      data[line.from.y + (deltaY * delta)][line.from.x + (deltaX * delta)]++;
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
