import 'dart:io';

class Signal {
  final List<String> input;
  final List<String> output;

  const Signal(this.input, this.output);

  int get uniqueSegments {
    return output
        .where((element) => [
              2, // one digit
              4, // four digit
              3, // seven digit
              7, // eight digit
            ].contains(element.length))
        .length;
  }

  factory Signal.fromString(String raw) {
    final splitRow = raw.split(' | ');
    final input = splitRow.first.split(' ');
    final output = splitRow.last.split(' ');
    return Signal(input, output);
  }
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day08/day08.txt';
  final rawData = File(path).readAsLinesSync();
  final signals = rawData.map((e) => Signal.fromString(e));

  final uniqueSegments =
      signals.map((e) => e.uniqueSegments).reduce((v, e) => v + e);
  print('Unique segments in output: $uniqueSegments');
}
