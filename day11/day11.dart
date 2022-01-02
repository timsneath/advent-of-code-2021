import 'dart:io';

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day10/day10.txt';
  final rawData = File(path).readAsLinesSync();
}
// coverage:ignore-end
