import 'package:test/test.dart';

import '../day04/day04.dart';

const randomOrder = [
  // Numbers "drawn"
  7, 4, 9, 5, 11, 17, 23, 2, 0,
  14, 21, 24, 10, 16, 13, 6, 15,
  25, 12, 22, 18, 20, 8, 19, 3, 26, 1
];

List<Board> initBoards() => [
      Board([
        [22, 13, 17, 11, 0],
        [8, 2, 23, 4, 24],
        [21, 9, 14, 16, 7],
        [6, 10, 3, 18, 5],
        [1, 12, 20, 15, 19],
      ]),
      Board([
        [3, 15, 0, 2, 22],
        [9, 18, 13, 17, 5],
        [19, 8, 7, 25, 23],
        [20, 11, 10, 24, 4],
        [14, 21, 16, 12, 6],
      ]),
      Board([
        [14, 21, 17, 24, 4],
        [10, 16, 15, 9, 19],
        [18, 8, 23, 26, 20],
        [22, 11, 13, 6, 5],
        [2, 0, 12, 3, 7]
      ])
    ];

void main() {
  test('Worked example on a single board', () {
    final board = initBoards()[2];

    int index = 0;
    bool isVictory = false;

    do {
      isVictory = board.drawNumber(randomOrder[index++]);
    } while (!isVictory && index < randomOrder.length);

    expect(randomOrder[index - 1], equals(24));
    expect(board.sumUnmarkedNumbers(), equals(188));
  });

  test('Worked example on all boards', () {
    final boards = initBoards();
    final winningBoard = boards.playRounds(randomOrder);
    expect(winningBoard, equals(2));
  });

  test('Winning column', () {
    final boards = initBoards();
    final winningBoard = boards.playRounds([15, 18, 8, 11, 21]);
    expect(winningBoard, equals(1));
  });

  test('Winning row', () {
    final boards = initBoards();
    final winningBoard = boards.playRounds([21, 9, 6, 14, 0, 16, 2, 7]);
    expect(winningBoard, equals(0));
  });

  test('No winning board', () {
    final boards = initBoards();
    final winningBoard = boards.playRounds([15, 18, 8, 11, 22, 7]);
    expect(winningBoard, equals(-1));
  });
}
