import 'dart:collection';
import 'dart:io';

const openBrackets = ['(', '[', '{', '<'];
const closeBrackets = [')', ']', '}', '>'];

const illegalCharacterScores = <String, int>{
  ')': 3,
  ']': 57,
  '}': 1197,
  '>': 25137
};

class SyntaxChecker {
  List<String> data;

  SyntaxChecker(this.data);

  /// Scores a given line for syntax errors.
  ///
  /// Returns the score based on the first illegal character identified. Returns
  /// -1 for an incomplete line. Returns 0 for a well-formed, complete line.
  static int scoreSyntaxErrors(String line) {
    final stack = ListQueue<String>();
    for (final char in line.split('')) {
      final bracket = openBrackets.indexOf(char);
      if (bracket != -1) {
        // Open bracket found, so add matching close bracket to the stack
        stack.addLast(closeBrackets[bracket]);
      } else {
        // No open bracket found, so expect matching close bracket to last open
        // bracket added to the stack.
        final expected = stack.removeLast();
        if (char != expected) {
          // Line is corrupted, so return score for unexpected character
          return illegalCharacterScores[char]!;
        }
      }
    }
    // We're at the end of the line. If there are any entries left in the stack,
    // the line is not well-formed.
    if (stack.isEmpty) {
      return 0;
    } else {
      return -1; // incomplete line
    }
  }

  static bool hasSyntaxError(String line) => scoreSyntaxErrors(line) > 0;
  static bool isComplete(String line) => scoreSyntaxErrors(line) == 0;
  static bool isIncomplete(String line) => scoreSyntaxErrors(line) == -1;

  int calculateTotalScore() {
    final scores = data.map(scoreSyntaxErrors).where((score) => score > 0);
    return scores.reduce((value, element) => value + element);
  }
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day10/day10.txt';
  final rawData = File(path).readAsLinesSync();
  final syntaxChecker = SyntaxChecker(rawData);
  final totalScore = syntaxChecker.calculateTotalScore();
  print('Total score: $totalScore');
}
// coverage:ignore-end
