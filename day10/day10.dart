import 'dart:collection';
import 'dart:io';

const openBrackets = ['(', '[', '{', '<'];
const closeBrackets = [')', ']', '}', '>'];

const illegalCharacterScores = <String, int>{
  ')': 3,
  ']': 57,
  '}': 1197,
  '>': 25137,
};

const autocompleteScores = <String, int>{
  ')': 1,
  ']': 2,
  '}': 3,
  '>': 4,
};

class SyntaxResult {
  final ListQueue<String> stack;
  final String unexpectedChar;

  const SyntaxResult(this.stack, this.unexpectedChar);

  bool get hasSyntaxError => unexpectedChar.isNotEmpty;
  bool get isComplete => unexpectedChar.isEmpty && stack.isEmpty;
  bool get isIncomplete => unexpectedChar.isEmpty && stack.isNotEmpty;
}

class SyntaxChecker {
  final List<String> data;
  late final List<SyntaxResult> syntaxResults;

  SyntaxChecker(this.data) {
    syntaxResults = data.map(checkSyntax).toList();
  }

  /// Check a given line for syntax errors.
  ///
  /// If an error, return the current stack and the ch
  SyntaxResult checkSyntax(String line) {
    final stack = ListQueue<String>();
    for (final char in line.split('')) {
      final bracket = openBrackets.indexOf(char);
      if (bracket != -1) {
        // Open bracket found, so add matching close bracket to the stack
        stack.addFirst(closeBrackets[bracket]);
      } else {
        // No open bracket found, so expect matching close bracket to last open
        // bracket added to the stack.
        final expected = stack.removeFirst();
        if (char != expected) {
          // Line is corrupted, so return the stack and the unexpected character
          return SyntaxResult(stack, char);
        }
      }
    }
    // We're at the end of the line. Return the stack, in case the caller cares
    // about whether the line is incomplete or not.
    return SyntaxResult(stack, '');
  }

  int calculateSyntaxErrorScore() {
    final scores = syntaxResults
        .where((res) => res.hasSyntaxError)
        .map((e) => illegalCharacterScores[e.unexpectedChar]!);
    return scores.reduce((value, element) => value + element);
  }

  int calculateAutocompleteScoreForStack(ListQueue<String> stack) {
    int score = 0;
    for (final char in stack) {
      score *= 5;
      score += autocompleteScores[char]!;
    }
    return score;
  }

  int calculateAutocompleteScore() {
    final incompleteStacks =
        syntaxResults.where((res) => res.isIncomplete).map((e) => e.stack);
    final scores = incompleteStacks
        .map((stack) => calculateAutocompleteScoreForStack(stack))
        .toList()
      ..sort();
    return scores[scores.length ~/ 2];
  }
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day10/day10.txt';
  final rawData = File(path).readAsLinesSync();
  final syntaxChecker = SyntaxChecker(rawData);
  final totalScore = syntaxChecker.calculateSyntaxErrorScore();
  print('Syntax error score: $totalScore');

  final autoCompletionScore = syntaxChecker.calculateAutocompleteScore();
  print('Autocomplete score: $autoCompletionScore');
}
// coverage:ignore-end
