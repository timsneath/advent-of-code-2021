import 'dart:io';

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

  print(boards.length);
}
