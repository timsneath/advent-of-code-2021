import 'package:test/test.dart';

import '../day13/day13.dart';

const sampleData = '''
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

void main() {
  test('Load data', () {
    final rawData = sampleData.split('\n');
    final boundary = rawData.indexOf('');
    final paper = Paper.fromRawData(rawData.sublist(0, boundary));
    final foldInstructions =
        rawData.sublist(boundary + 1).map(FoldInstruction.fromString);
    expect(paper.visibleDots, equals(18));
    expect(foldInstructions.length, equals(2));
  });

  test('Plot points', () {
    final rawData = sampleData.split('\n');
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
}
