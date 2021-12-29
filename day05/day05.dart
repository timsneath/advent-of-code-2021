import 'dart:io';

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day05/day05.txt';
  final rawData = File(path).readAsLinesSync();
}
