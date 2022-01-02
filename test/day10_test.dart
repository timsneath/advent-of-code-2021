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
  test('Expected number of syntax errors', () {
    final syntaxChecker = SyntaxChecker(rawData);
    expect(
        syntaxChecker.data
            .where((row) => syntaxChecker.hasSyntaxError(row))
            .length,
        equals(5));
  });

  test('Total error syntax score', () {
    final syntaxChecker = SyntaxChecker(rawData);
    expect(syntaxChecker.calculateTotalScore(), equals(26397));
  });
}
