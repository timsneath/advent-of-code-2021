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
    final syntax = SyntaxChecker(rawData);
    expect(syntax.syntaxResults.where((res) => res.hasSyntaxError).length,
        equals(5));
  });

  test('Expected number of complete lines', () {
    final syntax = SyntaxChecker(rawData);
    expect(
        syntax.syntaxResults.where((res) => res.isComplete).length, equals(0));
  });

  test('Expected number of incomplete lines', () {
    final syntax = SyntaxChecker(rawData);
    expect(syntax.syntaxResults.where((res) => res.isIncomplete).length,
        equals(5));
  });

  test('Total error syntax score', () {
    final syntaxChecker = SyntaxChecker(rawData);
    expect(syntaxChecker.calculateSyntaxErrorScore(), equals(26397));
  });

  test('Stack for incomplete line', () {
    final syntaxChecker = SyntaxChecker(rawData);
    final lastLineStack = syntaxChecker.syntaxResults.last.stack;
    expect(lastLineStack, equals([']', ')', '}', '>']));
  });

  test('Score for incomplete line', () {
    final syntaxChecker = SyntaxChecker(rawData);
    final lastLineStack = syntaxChecker.syntaxResults.last.stack;

    final autoCompleteScore =
        syntaxChecker.calculateAutocompleteScoreForStack(lastLineStack);
    expect(autoCompleteScore, equals(294));
  });

  test('Score for all lines', () {
    final syntaxChecker = SyntaxChecker(rawData);

    final autoCompleteScore = syntaxChecker.calculateAutocompleteScore();
    expect(autoCompleteScore, equals(288957));
  });
}
