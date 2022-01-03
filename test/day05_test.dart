import 'package:test/test.dart';

import '../day05/plane.dart';
import '../shared/line.dart';
import '../shared/point.dart';

const rawData = '0,9 -> 5,9\n8,0 -> 0,8\n9,4 -> 3,4\n2,2 -> 2,1\n7,0 -> 7,4\n'
    '6,4 -> 2,0\n0,9 -> 2,9\n3,4 -> 1,4\n0,0 -> 8,8\n5,5 -> 8,2';

void main() {
  group('Primitives', () {
    test('Line', () {
      final line1 = Line(Point(0, 0), Point(3, 2));
      expect(line1.toString(), equals('0,0 -> 3,2'));

      final line2 = Line(Point(0, 0), Point(3, 2));
      expect(line2.hashCode, equals(line1.hashCode));
      expect(line2, equals(line1));

      final line3 = Line(Point(3, 2), Point(0, 0));
      expect(line3, isNot(equals(line2)));
    });
  });

  test('Read in raw data', () {
    final lines = <Line>[];
    for (final row in rawData.split('\n')) {
      lines.add(Line.fromString(row));
    }

    expect(lines.length, equals(10));
  });

  test('Horizontal line', () {
    final plane = Plane(3, 3);
    plane.plotLine(Line(Point(0, 2), Point(2, 2)));
    expect(
        plane.data,
        equals([
          [0, 0, 0],
          [0, 0, 0],
          [1, 1, 1],
        ]));
  });

  test('Vertical line', () {
    final plane = Plane(3, 3);
    plane.plotLine(Line(Point(0, 0), Point(0, 2)));
    expect(
        plane.data,
        equals([
          [1, 0, 0],
          [1, 0, 0],
          [1, 0, 0],
        ]));
  });

  test('Diagonal line 1', () {
    final plane = Plane(3, 3);
    plane.plotLine(Line(Point(0, 0), Point(2, 2)));
    expect(
        plane.data,
        equals([
          [1, 0, 0],
          [0, 1, 0],
          [0, 0, 1],
        ]));
  });

  test('Diagonal line 2', () {
    final plane = Plane(3, 3);
    plane.plotLine(Line(Point(2, 0), Point(0, 2)));
    expect(
        plane.data,
        equals([
          [0, 0, 1],
          [0, 1, 0],
          [1, 0, 0],
        ]));
  });

  test('Cross', () {
    final plane = Plane.fromLines(
        [Line(Point(0, 0), Point(2, 2)), Line(Point(2, 0), Point(0, 2))]);

    expect(
        plane.data,
        equals([
          [1, 0, 1],
          [0, 2, 0],
          [1, 0, 1],
        ]));

    expect(plane.toString(), equals('1.1\n.2.\n1.1\n'));
  });

  test('Horizontal and vertical only', () {
    final lines = <Line>[];
    for (final row in rawData.split('\n')) {
      lines.add(Line.fromString(row));
    }

    final plane = Plane(10, 10);
    for (final line in lines) {
      if (line.isHorizontal || line.isVertical) {
        plane.plotLine(line);
      }
    }
    expect(plane.countOverlaps(), equals(5));
  });

  test('Include diagonals', () {
    final lines = <Line>[];
    for (final row in rawData.split('\n')) {
      lines.add(Line.fromString(row));
    }

    final plane = Plane(10, 10);
    plane.plotLines(lines);
    expect(plane.countOverlaps(), equals(12));
  });
}
