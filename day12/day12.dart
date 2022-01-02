import 'dart:io';

class PathFinder {
  final List<String> paths;
  const PathFinder(this.paths);
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day12/day12.txt';
  final rawData = File(path).readAsLinesSync();
  final pathFinder = PathFinder(rawData);
}
// coverage:ignore-end
