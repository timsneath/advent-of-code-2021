import 'dart:io';

import 'package:collection/collection.dart';

import '../shared/point.dart';
import '../shared/utils.dart';

enum Axis { x, y }

class FoldInstruction {
  final Axis axis;
  final int foldLine;

  const FoldInstruction(this.axis, this.foldLine);

  factory FoldInstruction.fromString(String string) =>
      string.startsWith('fold along x')
          ? FoldInstruction(Axis.x, int.parse(string.split('=').last))
          : FoldInstruction(Axis.y, int.parse(string.split('=').last));

  @override
  String toString() {
    return 'fold along ${axis.name}=$foldLine';
  }
}

class Paper {
  final int width;
  final int height;

  final List<List<bool>> data;

  Paper(this.width, this.height)
      : data = List<List<bool>>.generate(
            height, (_) => List<bool>.generate(width, (_) => false));

  factory Paper.fromPoints(Iterable<Point> points) {
    final width = points.map((pt) => pt.x).max + 1;
    final height = points.map((pt) => pt.y).max + 1;

    return Paper(width, height)..plotPoints(points);
  }

  factory Paper.fromRawData(List<String> rawData) {
    final points = rawData.map((row) {
      final rawPoints = row.split(',');
      return Point(int.parse(rawPoints.first), int.parse(rawPoints.last));
    });

    return Paper.fromPoints(points);
  }

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
        if (newPaper.data[row][width - idx - 1] && data[row][idx]) {
          print('one less overlap');
        }
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

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day13/day13.txt';
  final rawData = File(path).readAsLinesSync();
  final boundary = rawData.indexOf('');

  final points = rawData.sublist(0, boundary);
  final foldInstructions =
      rawData.sublist(boundary + 1).map(FoldInstruction.fromString).toList();

  final paper = Paper.fromRawData(points);
  print('There are ${foldInstructions.length} fold instructions.');
  print('Paper dimensions: ${paper.width}x${paper.height}');

  print('\nFirst fold:');
  print(foldInstructions.first);
  final firstFold = paper.fold(foldInstructions.first);
  print('New paper dimensions: ${firstFold.width}x${firstFold.height}');
  print('Visible dots after first fold: ${firstFold.visibleDots}');

  print('\nAll folds:');
  final allFold = paper.foldAll(foldInstructions);
  print('New paper dimensions: ${allFold.width}x${allFold.height}');
  print('Visible dots after first fold: ${allFold.visibleDots}');
  print(allFold.toString());
}
// coverage:ignore-end
