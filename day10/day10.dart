import 'dart:io';

const illegalCharacterScores = <String, int>{
  ')': 3,
  ']': 57,
  '}': 1197,
  '>': 25137
};

class SyntaxChecker {
  List<String> data;

  SyntaxChecker(this.data);

  int calculateTotalScore() {
    return 0;
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
