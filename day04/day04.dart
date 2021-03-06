import 'dart:io';

import 'package:collection/collection.dart';

class GameSet {
  final List<Board> boards;

  const GameSet(this.boards);

  /// Plays a round of bingo on a list of boards. Return the index of every
  /// board that won on that round.
  List<int> playRound(int number) {
    final winningBoards = <int>[];
    for (var idx = 0; idx < boards.length; idx++) {
      if (boards[idx].drawNumber(number)) {
        winningBoards.add(idx);
      }
    }
    return winningBoards;
  }

  /// Plays multiple rounds of bingo on a list of boards. Return the index of
  /// every board that won during those rounds, in order of victory.
  List<int> playRounds(List<int> numbers) {
    final winningBoards = <int>[];

    for (final number in numbers) {
      final result = playRound(number);
      winningBoards.addAll(result);
    }

    return winningBoards;
  }
}

class Board {
  // Numbers in the board
  late final List<int> board;

  // Which board entries have been drawn so far
  late final List<bool> drawn;

  bool isVictory = false;

  Board(List<List<int>> boardList) {
    // Flatten board to a list of integers
    board = boardList.flattened.toList();
    if (board.length != 25) {
      throw ArgumentError('Board should be a 5x5 matrix');
    }

    resetGame();
  }

  void resetGame() {
    drawn = List<bool>.generate(board.length, (e) => false);
  }

  bool checkVictory() {
    // Check for a victory based on a row
    for (var row = 0; row < 5; row++) {
      if (drawn.getRange(row * 5, (row * 5) + 5).every((elem) => elem)) {
        isVictory = true;
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

      if (column.every((element) => element)) {
        isVictory = true;
        return true;
      }
    }

    return false;
  }

  /// Returns true if this number leads to a new winning board.
  bool drawNumber(int number) {
    // Board was already victorious, so this isn't a new victory
    if (isVictory) return false;

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

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day04/day04.txt';
  final rawData = File(path).readAsLinesSync();

  // Create a queue of bingo numbers in order that they're called
  final calledNumbers = rawData[0].split(',').map<int>(int.parse).toList();

  // Read bingo boards
  final boards = <Board>[];
  for (var dataRow = 2; dataRow < rawData.length; dataRow += 6) {
    final board = <List<int>>[];
    for (var bingoRow = 0; bingoRow < 5; bingoRow++) {
      final rawRow = rawData[dataRow + bingoRow].trimLeft();
      board.add(rawRow.split(RegExp(r'\s+')).map(int.parse).toList());
    }
    boards.add(Board(board));
  }

  // Play bingo
  final gameSet = GameSet(boards);
  var winningBoards = <int>[];
  final winningScores = <int>[];
  for (final calledNumber in calledNumbers) {
    winningBoards = gameSet.playRound(calledNumber);
    for (final board in winningBoards) {
      final score = boards[board].sumUnmarkedNumbers() * calledNumber;
      winningScores.add(score);
    }
  }

  // Print results
  if (winningScores.isEmpty) {
    print('No winning board');
  } else {
    print('First winning score: ${winningScores.first}');
    print('Last winning score: ${winningScores.last}');
  }
}
// coverage:ignore-end
