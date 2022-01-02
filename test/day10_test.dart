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
    expect(rawData.where(SyntaxChecker.hasSyntaxError).length, equals(5));
  });

  test('Expected number of complete lines', () {
    expect(rawData.where(SyntaxChecker.isComplete).length, isZero);
  });

  test('Expected number of incomplete lines', () {
    expect(rawData.where(SyntaxChecker.isIncomplete).length, equals(5));
  });

  test('Total error syntax score', () {
    final syntaxChecker = SyntaxChecker(rawData);
    expect(syntaxChecker.calculateTotalScore(), equals(26397));
  });
}
