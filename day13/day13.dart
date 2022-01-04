import 'dart:io';

import 'package:collection/collection.dart';
import 'package:test/expect.dart';

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

  @override
  String toString() =>
      data.map((row) => row.map((cell) => cell ? '#' : '.').join()).join('\n');

  Paper foldHorizontally(int foldLine) {
    final newPaper = Paper(width, foldLine);
    for (var row = 0; row < foldLine; row++) {
      for (var idx = 0; idx < width; idx++) {
        newPaper.data[row][idx] = data[row][idx];
      }
    }
    for (var row = height - 1; row > foldLine; row--) {
      for (var idx = 0; idx < width; idx++) {
        newPaper.data[height - row - 1][idx] |= data[row][idx];
      }
    }
    return newPaper;
  }

  Paper foldVertically(int foldLine) {
    final newPaper = Paper(foldLine, height);
    for (var row = 0; row < height; row++) {
      for (var idx = 0; idx < foldLine; idx++) {
        newPaper.data[row][idx] = data[row][idx];
      }
    }
    for (var row = 0; row < height; row++) {
      for (var idx = foldLine + 1; idx < width; idx++) {
        newPaper.data[row][width - idx - 1] |= data[row][idx];
      }
    }
    return newPaper;
  }

  Paper fold(FoldInstruction foldInstruction) => foldInstruction.axis == Axis.y
      ? foldHorizontally(foldInstruction.foldLine)
      : foldVertically(foldInstruction.foldLine);

  Paper foldAll(List<FoldInstruction> foldInstructions) {
    Paper paper = this;
    for (final foldInstruction in foldInstructions) {
      paper = paper.fold(foldInstruction);
    }
    return paper;
  }
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

  @override
  String toString() {
    return 'fold along ${axis.name}=$foldLine';
  }
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day13/day13.txt';
  final rawData = File(path).readAsLinesSync();
  final boundary = rawData.indexOf('');

  final paper = Paper.fromRawData(rawData.sublist(0, boundary));
  final foldInstructions =
      rawData.sublist(boundary + 1).map(FoldInstruction.fromString);
  print('There are ${foldInstructions.length} fold instructions.');
  print('Paper dimensions: ${paper.width}x${paper.height}');
  final newPaper = paper.fold(foldInstructions.first);
  print(foldInstructions.first);
  print('New paper dimensions: ${newPaper.width}x${newPaper.height}');
  print('Visible dots after first fold: ${newPaper.visibleDots}');
}
// coverage:ignore-end
