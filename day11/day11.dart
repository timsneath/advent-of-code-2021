import 'dart:io';

class Cavern {
  final List<List<int>> grid;
  int flashCount = 0;

  Cavern(this.grid);

  factory Cavern.fromRawData(List<String> rawData) {
    final grid = <List<int>>[];
    for (final row in rawData) {
      grid.add(row.split('').map((c) => int.parse(c)).toList());
    }
    return Cavern(grid);
  }

  @override
  String toString() => grid.map((row) => row.join('')).join('\n');

  int get height => grid.length;
  int get width => grid.first.length;

  int at(int x, int y) => grid[y][x];
  void inc(int x, int y) => grid[y][x]++;
  void reset(int x, int y) => grid[y][x] = 0;

  bool aboutToFlash(int x, int y) => grid[y][x] > 9;
  void markFlashed(int x, int y) => grid[y][x] = -1;
  bool hasFlashed(int x, int y) => grid[y][x] == -1;

  bool notInGrid(int x, int y) =>
      (x < 0 || x >= width) || (y < 0 || y >= height);

  bool get isSynchronizedFlash {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (at(x, y) != 0) return false;
      }
    }
    return true;
  }

  void completeDay() {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (hasFlashed(x, y)) reset(x, y);
      }
    }
  }

  void incrementAll() {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        inc(x, y);
      }
    }
  }

  void addDay() {
    incrementAll();
    int startCount;
    // Keep repeating until we've covered all flashes
    do {
      startCount = flashCount;
      for (var y = 0; y < height; y++) {
        for (var x = 0; x < width; x++) {
          if (at(x, y) > 9) {
            flash(x, y);
          }
        }
      }
    } while (startCount != flashCount);
    completeDay();
  }

  void addDays(int days) {
    for (int x = days; x > 0; x--) {
      addDay();
    }
  }

  int firstSynchronizedFlash() {
    int dayCount = 0;
    do {
      addDay();
      dayCount++;
    } while (!isSynchronizedFlash);
    return dayCount;
  }

  void flash(int x, int y) {
    if (notInGrid(x, y) || hasFlashed(x, y)) return;

    if (aboutToFlash(x, y)) {
      markFlashed(x, y);
      flashCount++;

      flash(x - 1, y);
      flash(x - 1, y - 1);
      flash(x, y - 1);
      flash(x + 1, y - 1);
      flash(x + 1, y);
      flash(x + 1, y + 1);
      flash(x, y + 1);
      flash(x - 1, y + 1);
    } else {
      inc(x, y);
    }
  }
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day11/day11.txt';
  final rawData = File(path).readAsLinesSync();
  final cavern = Cavern.fromRawData(rawData);
  cavern.addDays(100);
  print('There have been ${cavern.flashCount} flashes.');

  final cavern2 = Cavern.fromRawData(rawData);
  final firstSyncEvent = cavern2.firstSynchronizedFlash();
  print('First synchronization event is after $firstSyncEvent days');
}
// coverage:ignore-end
