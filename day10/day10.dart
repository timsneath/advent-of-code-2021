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

  int scoreSyntaxErrors(String line) {
    final stack = ListQueue<String>();
    for (final char in line.split('')) {
      final bracket = openBrackets.indexOf(char);
      if (bracket != -1) {
        // Bracket found, so add matching close bracket to the stack
        stack.addLast(closeBrackets[bracket]);
      } else {
        final expected = stack.removeLast();
        if (char != expected) {
          // Line is corrupted, so return score for unexpected character
          return illegalCharacterScores[char]!;
        }
      }
    }
    return 0;
  }

  bool hasSyntaxError(String line) => scoreSyntaxErrors(line) > 0;

  int calculateTotalScore() {
    final scores = data.map(scoreSyntaxErrors);
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
