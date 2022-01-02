import 'package:test/test.dart';

import '../day10/day10.dart';

const rawData = <String>[
  '[({(<(())[]>[[{[]{<()<>>',
  '[(()[<>])]({[<{<<[]>>(',
  '{([(<{}[<>[]}>{[]{[(<()>',
  '(((({<>}<{<{<>}{[]{[]{}',
  '[[<[([]))<([[{}[[()]]]',
  '[{[{({}]{}}([{[{{{}}([]',
  '{<[[]]>}<{[{[{[]{()[[[]',
  '[<(<(<(<{}))><([]([]()',
  '<{([([[(<>()){}]>(<<{{',
  '<{([{{}}[<[[[<>{}]]]>[]]',
];

void main() {
  test('Total error syntax score', () {
    final syntaxChecker = SyntaxChecker(rawData);
    expect(syntaxChecker.calculateTotalScore(), equals(26397));
  });
}
