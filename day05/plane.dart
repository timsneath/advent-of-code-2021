import 'dart:math' show max;

import 'line.dart';

class Plane {
  final int width;
  final int height;

  late final List<List<int>> data;

  Plane(this.width, this.height) {
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

  void plotLines(List<Line> lines) => lines.forEach(plotLine);

  @override
  String toString() {
    final buffer = StringBuffer();
    for (final row in data) {
      for (final col in row) {
        buffer.write(col == 0 ? '.' : col);
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  int countOverlaps() {
    // Flatten the two-dimensional list into a single-dimensional list
    final points = [for (var row in data) ...row];

    points.retainWhere((e) => e > 1);
    return points.length;
  }
}
