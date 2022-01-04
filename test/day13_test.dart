import 'package:test/test.dart';

import '../day13/day13.dart';

void main() {
  group('Sample data', () {
    const providedSample = '''
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5''';

    test('Load data', () {
      final rawData = providedSample.split('\n');
      final boundary = rawData.indexOf('');
      final paper = Paper.fromRawData(rawData.sublist(0, boundary));
      final foldInstructions =
          rawData.sublist(boundary + 1).map(FoldInstruction.fromString);

      expect(paper.visibleDots, equals(18));
      expect(foldInstructions.length, equals(2));
      expect(foldInstructions.first.toString(), equals('fold along y=7'));
    });

    test('Plot points', () {
      final rawData = providedSample.split('\n');
      final boundary = rawData.indexOf('');
      final paper = Paper.fromRawData(rawData.sublist(0, boundary));
      expect(paper.toString(), equals('''
...#..#..#.
....#......
...........
#..........
...#....#.#
...........
...........
...........
...........
...........
.#....#.##.
....#......
......#...#
#..........
#.#........'''));
    });

    test('Vertical fold', () {
      final rawData = providedSample.split('\n');
      final boundary = rawData.indexOf('');
      final paper = Paper.fromRawData(rawData.sublist(0, boundary));
      final foldInstructions =
          rawData.sublist(boundary + 1).map(FoldInstruction.fromString);
      expect(paper.width, equals(11));
      expect(paper.height, equals(15));

      final newPaper = paper.fold(foldInstructions.first);

      expect(newPaper.toString(), equals('''
#.##..#..#.
#...#......
......#...#
#...#......
.#.#..#.###
...........
...........'''));
      expect(newPaper.width, equals(11));
      expect(newPaper.height, equals(7));
      expect(newPaper.visibleDots, equals(17));
    });

    test('Horizontal fold', () {
      final rawData = providedSample.split('\n');
      final boundary = rawData.indexOf('');
      final foldInstructions = rawData
          .sublist(boundary + 1)
          .map(FoldInstruction.fromString)
          .toList();
      final paper = Paper.fromRawData(rawData.sublist(0, boundary));
      final newPaper = paper.foldAll(foldInstructions);

      expect(newPaper.toString(), equals('''
#####
#...#
#...#
#...#
#####
.....
.....'''));
      expect(newPaper.width, equals(5));
      expect(newPaper.height, equals(7));
      expect(newPaper.visibleDots, equals(16));
    });
  });

  group('Secondary sample', () {
    const providedSample = '''
0,0
7,7
0,7
7,0

fold along y=4
fold along x=4''';

    test('Fold in half', () {
      final rawData = providedSample.split('\n');
      final boundary = rawData.indexOf('');
      final paper = Paper.fromRawData(rawData.sublist(0, boundary));
      final foldInstructions =
          rawData.sublist(boundary + 1).map(FoldInstruction.fromString);

      final folded = paper.fold(foldInstructions.first);
      expect(folded.width, equals(8));
      expect(folded.height, equals(4));
      expect(folded.visibleDots, equals(2));

      final folded2 = folded.fold(foldInstructions.last);
      expect(folded2.width, equals(4));
      expect(folded2.height, equals(4));
      expect(folded2.visibleDots, equals(1));
    });
  });
}
