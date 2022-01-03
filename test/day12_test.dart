import 'package:test/test.dart';

import '../day12/day12.dart';

final sampleData = <String>[
  'start-A',
  'start-b',
  'A-c',
  'A-b',
  'b-d',
  'A-end',
  'b-end',
];

void main() {
  test('toString()', () {
    final caveMap = CaveMap.fromRawData(sampleData);
    expect(caveMap.toString(), equalsIgnoringWhitespace(sampleData.join('\n')));
  });

  test('Start edges', () {
    final caveMap = CaveMap.fromRawData(sampleData);
    expect(caveMap.startEdges.length, equals(2));
  });

  test('Valid paths', () {
    final caveMap = CaveMap.fromRawData(sampleData);
    final validPaths = caveMap.findPaths();

    expect(validPaths.length, equals(10));
  });
}
