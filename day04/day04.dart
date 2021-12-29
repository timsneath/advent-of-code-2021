import 'dart:io';

class Board {
  late final List<int> board;
  late final List<bool> drawn;

  Board(List<List<int>> boardList) {
    if (boardList.length != 25) {
      throw ArgumentError('Board should be 5x5 cells');
    }

    board = [for (var row in boardList) ...row];
    drawn = List<bool>.generate(board.length, (e) => false);
  }

  bool checkVictory() {
    // Check for a victory based on a row
    for (var row = 0; row < 5; row++) {
      if (drawn
          .getRange(row * 5, (row * 5) + 5)
          .where((element) => element)
          .isNotEmpty) return true;
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

      if (column.where((element) => element).isNotEmpty) return true;
    }

    return false;
  }

  /// Returns true if this number leads to a winning board.
  bool drawNumber(int number) {
    drawn[board.indexOf(number)] = true;
    return checkVictory();
  }
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day04/day04.txt';
  final rawData = File(path).readAsLinesSync();

  // Read bingo numbers in order that they're called
  final randomOrder = rawData[0].split(',').map((e) => int.parse(e));

  // Read bingo boards
  final boards = <List<List<int>>>[];
  for (var dataRow = 2; dataRow < rawData.length; dataRow += 6) {
    final board = <List<int>>[];
    for (var bingoRow = 0; bingoRow < 5; bingoRow++) {
      final rawRow = rawData[dataRow + bingoRow].trimLeft();
      board.add(rawRow.split(RegExp(r'\s+')).map((e) => int.parse(e)).toList());
    }
    boards.add(board);
  }

  // Play bingo

  print(boards.length);
}
