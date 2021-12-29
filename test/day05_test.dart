import 'package:test/test.dart';

import '../day05/day05.dart';
import '../day05/line.dart';

const rawData = '0,9 -> 5,9\n8,0 -> 0,8\n9,4 -> 3,4\n2,2 -> 2,1\n7,0 -> 7,4\n'
    '6,4 -> 2,0\n0,9 -> 2,9\n3,4 -> 1,4\n0,0 -> 8,8\n5,5 -> 8,2';

void main() {
  test('Read in raw data', () {
    final lines = <Line>[];
    for (final row in rawData.split('\n')) {
      lines.add(Line.fromString(row));
    }

    expect(lines.length, equals(10));
  });

  test('Horizontal and vertical only', () {
    final lines = <Line>[];
    for (final row in rawData.split('\n')) {
      lines.add(Line.fromString(row));
    }

    final field = Field(10, 10);
    for (final line in lines) {
      if (line.isHorizontal || line.isVertical) {
        field.plotLine(line);
      }
    }
    expect(field.countOverlaps(), equals(5));
  });
}
