import 'dart:io';

import 'package:collection/collection.dart';

import '../shared/point.dart';
import '../shared/utils.dart';

class Paper {
  final int width;
  final int height;

  late final List<List<bool>> data;

  Paper(this.width, this.height) {
    data = List<List<bool>>.generate(
        height, (_) => List<bool>.generate(width, (_) => false));
  }
  factory Paper.fromPoints(Iterable<Point> points) {
    final width = points.map((pt) => pt.x).max + 1;
    final height = points.map((pt) => pt.y).max + 1;

    return Paper(width, height)..plotPoints(points);
  }
  factory Paper.fromRawData(List<String> rawData) =>
      Paper.fromPoints(rawData.map((row) {
        final rawPoints = row.split(',');
        return Point(int.parse(rawPoints.first), int.parse(rawPoints.last));
      }));

  void plotPoints(Iterable<Point> points) => points.forEach(plotPoint);
  void plotPoint(Point point) => data[point.y][point.x] = true;

  int get visibleDots => data.flattened.where((e) => e).length;
}

enum Axis { x, y }

class FoldInstruction {
  Axis axis;
  int foldLine;

  FoldInstruction(this.axis, this.foldLine);

  factory FoldInstruction.fromString(String string) {
    final split = string.split('=');
    if (split.first[11] == 'x') {
      return FoldInstruction(Axis.x, int.parse(split.last));
    } else if (split.first[11] == 'y') {
      return FoldInstruction(Axis.y, int.parse(split.last));
    } else {
      throw ArgumentError(
          'Fold instruction is not in the form "fold along x=3"');
    }
  }
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day13/day13.txt';
  final rawData = File(path).readAsLinesSync();
  final boundary = rawData.indexOf('\n');

  final paper = Paper.fromRawData(rawData.sublist(0, boundary));
  final foldInstructions =
      rawData.sublist(boundary + 1).map(FoldInstruction.fromString);
  print('Paper dimensions: ${paper.width}x${paper.height}');
  print('# fold instructions: ${foldInstructions.length}');
}
// coverage:ignore-end
