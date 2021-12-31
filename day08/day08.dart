import 'dart:io';

class Signal {
  final List<String> input;
  final List<String> output;

  const Signal(this.input, this.output);
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day08/day08.txt';
  final rawData = File(path).readAsLinesSync();
  final signals = <Signal>[];

  for (final row in rawData) {
    final splitRow = row.split(' | ');
    final input = splitRow.first.split(' ');
    final output = splitRow.last.split(' ');
    signals.add(Signal(input, output));
  }

  print(signals.length);
}
