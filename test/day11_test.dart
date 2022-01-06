import 'package:test/test.dart';

import '../day11/day11.dart';

const simpleData = <String>[
  '00000',
  '00000',
  '00100',
  '00000',
  '00000',
];

const readyToFlashData = <String>[
  '11111',
  '19991',
  '19191',
  '19991',
  '11111',
];

const sampleData = <String>[
  '5483143223',
  '2745854711',
  '5264556173',
  '6141336146',
  '6357385478',
  '4167524645',
  '2176841721',
  '6882881134',
  '4846848554',
  '5283751526',
];

void main() {
  test('toString()', () {
    final cavern = Cavern.fromRawData(sampleData);
    expect(cavern.toString(), startsWith('5483143223\n2745854711'));
  });

  test('Simple example', () {
    final cavern = Cavern.fromRawData(simpleData)..addDay();
    expect(cavern.toString(), equals('''
11111
11111
11211
11111
11111'''));
  });

  test('Adjacent flashes', () {
    final cavern = Cavern.fromRawData(readyToFlashData)..addDay();
    expect(cavern.toString(), equals('''
34543
40004
50005
40004
34543'''));

    cavern.addDay();
    expect(cavern.toString(), equals('''
45654
51115
61116
51115
45654'''));
  });

  test('day 1', () {
    final cavern = Cavern.fromRawData(sampleData)..addDay();
    expect(cavern.toString(), equals('''
6594254334
3856965822
6375667284
7252447257
7468496589
5278635756
3287952832
7993992245
5957959665
6394862637'''));
  });

  test('day 2', () {
    final cavern = Cavern.fromRawData(sampleData)..addDays(2);
    expect(cavern.toString(), equals('''
8807476555
5089087054
8597889608
8485769600
8700908800
6600088989
6800005943
0000007456
9000000876
8700006848'''));
  });

  test('day 3', () {
    final cavern = Cavern.fromRawData(sampleData)..addDays(3);
    expect(cavern.toString(), equals('''
0050900866
8500800575
9900000039
9700000041
9935080063
7712300000
7911250009
2211130000
0421125000
0021119000'''));
  });

  test('day 10', () {
    final cavern = Cavern.fromRawData(sampleData)..addDays(10);
    expect(cavern.toString(), equals('''
0481112976
0031112009
0041112504
0081111406
0099111306
0093511233
0442361130
5532252350
0532250600
0032240000'''));
  });

  test('day 10 flashcount', () {
    final cavern = Cavern.fromRawData(sampleData)..addDays(10);
    expect(cavern.flashCount, equals(204));
  });

  test('day 100 flashcount', () {
    final cavern = Cavern.fromRawData(sampleData)..addDays(100);
    expect(cavern.flashCount, equals(1656));
  });

  test('day 195 flashes', () {
    final cavern = Cavern.fromRawData(sampleData)..addDays(195);
    expect(cavern.grid, everyElement(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
  });

  test('first synchronized count', () {
    final cavern = Cavern.fromRawData(sampleData);
    expect(cavern.firstSynchronizedFlash(), equals(195));
  });
}
