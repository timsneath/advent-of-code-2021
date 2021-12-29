import 'dart:io';

extension Bingo on List<Board> {
  /// Plays a round of bingo on a list of boards. If a board wins, return the
  /// board number, else return -1.
  int playRound(int number) {
    for (var idx = 0; idx < length; idx++) {
      if (this[idx].drawNumber(number)) {
        return idx;
      }
    }

    return -1;
  }

  /// Plays multiple rounds of bingo on a list of boards. If a board wins, return the
  /// board number, else return -1.
  int playRounds(List<int> numbers) {
    for (final number in numbers) {
      final result = playRound(number);
      if (result != -1) return result;
    }

    return -1;
  }
}

class Board {
  // Numbers in the board
  late final List<int> board;

  // Which board entries have been drawn so far
  late final List<bool> drawn;

  Board(List<List<int>> boardList) {
    // Flatten board to a list of integers
    board = [for (var row in boardList) ...row];
    if (board.length != 25) {
      throw ArgumentError('Board should be a 5x5 matrix');
    }

    drawn = List<bool>.generate(board.length, (e) => false);
  }

  bool checkVictory() {
    // Check for a victory based on a row
    for (var row = 0; row < 5; row++) {
      if (drawn.getRange(row * 5, (row * 5) + 5).every((elem) => elem)) {
        return true;
      }
    }

    // Check for a victory based on a column
    for (var i = 0; i < 5; i++) {
      final column = [
        drawn.elementAt(i),
        drawn.elementAt(i + 5),
        drawn.elementAt(i + 10),
        drawn.elementAt(i + 15),
        drawn.elementAt(i + 20),
      ];

      if (column.every((element) => element)) return true;
    }

    return false;
  }

  /// Returns true if this number leads to a winning board.
  bool drawNumber(int number) {
    final indexOfNumber = board.indexOf(number);
    if (indexOfNumber != -1) {
      drawn[board.indexOf(number)] = true;
      return checkVictory();
    } else {
      // Number wasn't found, so the board is no more "winning" than it was
      // before.
      return false;
    }
  }

  int sumUnmarkedNumbers() {
    var sum = 0;
    for (var i = 0; i < drawn.length; i++) {
      if (!drawn[i]) {
        sum += board[i];
      }
    }

    return sum;
  }
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day04/day04.txt';
  final rawData = File(path).readAsLinesSync();

  // Create a queue of bingo numbers in order that they're called
  final randomOrder =
      rawData[0].split(',').map<int>((e) => int.parse(e)).toList();

  // Read bingo boards
  final boards = <Board>[];
  for (var dataRow = 2; dataRow < rawData.length; dataRow += 6) {
    final board = <List<int>>[];
    for (var bingoRow = 0; bingoRow < 5; bingoRow++) {
      final rawRow = rawData[dataRow + bingoRow].trimLeft();
      board.add(rawRow.split(RegExp(r'\s+')).map((e) => int.parse(e)).toList());
    }
    boards.add(Board(board));
  }

  // Play bingo
  for (final number in randomOrder) {
    final winningBoard = boards.playRound(number);
    if (winningBoard >= 0) {
      final score = boards[winningBoard].sumUnmarkedNumbers() * number;
      print('Winning score: $score');
      exit(0);
    }
  }

  print('No winning board');
}
