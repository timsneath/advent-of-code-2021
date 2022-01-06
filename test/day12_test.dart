import 'package:test/test.dart';

import '../day12/day12.dart';

void main() {
  test('toString()', () {
    expect(const Edge('start', 'A').toString(), equals('start-A'));
  });

  group('Part 1', () {
    test('Valid paths 1', () {
      const sampleData = <String>[
        'start-A',
        'start-b',
        'A-c',
        'A-b',
        'b-d',
        'A-end',
        'b-end'
      ];

      final caveMap = CaveMap.fromRawData(sampleData, 1);
      final validPaths = caveMap.findPaths();

      expect(validPaths.length, equals(10));
    });

    test('Valid paths 2', () {
      const sampleData = <String>[
        'dc-end',
        'HN-start',
        'start-kj',
        'dc-start',
        'dc-HN',
        'LN-dc',
        'HN-end',
        'kj-sa',
        'kj-HN',
        'kj-dc',
      ];

      final caveMap = CaveMap.fromRawData(sampleData, 1);
      final validPaths = caveMap.findPaths();

      expect(validPaths.length, equals(19));
    });

    test('Valid paths 3', () {
      const sampleData = <String>[
        'fs-end',
        'he-DX',
        'fs-he',
        'start-DX',
        'pj-DX',
        'end-zg',
        'zg-sl',
        'zg-pj',
        'pj-he',
        'RW-he',
        'fs-DX',
        'pj-RW',
        'zg-RW',
        'start-pj',
        'he-WI',
        'zg-he',
        'pj-fs',
        'start-RW',
      ];

      final caveMap = CaveMap.fromRawData(sampleData, 1);
      final validPaths = caveMap.findPaths();

      expect(validPaths.length, equals(226));
    });
  });

  group('Part 2', () {
    test('Valid paths 1', () {
      const sampleData = <String>[
        'start-A',
        'start-b',
        'A-c',
        'A-b',
        'b-d',
        'A-end',
        'b-end'
      ];

      final caveMap = CaveMap.fromRawData(sampleData, 2);
      final validPaths = caveMap.findPaths();

      expect(validPaths.length, equals(36));
    });

    test('Valid paths 2', () {
      const sampleData = <String>[
        'dc-end',
        'HN-start',
        'start-kj',
        'dc-start',
        'dc-HN',
        'LN-dc',
        'HN-end',
        'kj-sa',
        'kj-HN',
        'kj-dc',
      ];

      final caveMap = CaveMap.fromRawData(sampleData, 2);
      final validPaths = caveMap.findPaths();

      expect(validPaths.length, equals(103));
    });

    test('Valid paths 3', () {
      const sampleData = <String>[
        'fs-end',
        'he-DX',
        'fs-he',
        'start-DX',
        'pj-DX',
        'end-zg',
        'zg-sl',
        'zg-pj',
        'pj-he',
        'RW-he',
        'fs-DX',
        'pj-RW',
        'zg-RW',
        'start-pj',
        'he-WI',
        'zg-he',
        'pj-fs',
        'start-RW',
      ];

      final caveMap = CaveMap.fromRawData(sampleData, 2);
      final validPaths = caveMap.findPaths();

      expect(validPaths.length, equals(3509));
    });
  });
}
