import 'package:test/test.dart';

import '../day08/day08.dart';

const rawData = '''
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce''';

void main() {
  test('Load raw data', () {
    final signals = rawData.split('\n').map((e) => Signal.fromString(e));
    expect(signals.length, equals(10));
    expect(signals.first.input.length, equals(10));
    expect(signals.first.output.length, equals(4));
  });

  test('Unique segments (first)', () {
    final signals = rawData.split('\n').map((e) => Signal.fromString(e));
    expect(signals.first.uniqueSegments, equals(2));
    expect(signals.first.input.length, equals(10));
    expect(signals.first.output.length, equals(4));
  });

  test('Unique segments', () {
    final signals = rawData.split('\n').map((e) => Signal.fromString(e));
    final uniqueSegments =
        signals.map((e) => e.uniqueSegments).reduce((v, e) => v + e);
    expect(uniqueSegments, equals(26));
  });
}
