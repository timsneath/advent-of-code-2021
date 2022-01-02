import 'dart:io';

class Signal {
  final List<String> input;
  final List<String> output;

  const Signal(this.input, this.output);

  int get uniqueSegments {
    return output
        .where((segment) => [
              2, // one digit
              4, // four digit
              3, // seven digit
              7, // eight digit
            ].contains(segment.length))
        .length;
  }

  // Returns true if `segment` contains all the items in `toMatch`
  bool matchSegments(String digit, String segments) => segments
      .split('')
      .map((segment) => digit.contains(segment))
      .reduce((value, element) => value && element);

  // Take a single segmented digit (e.g. 'acdeg') and return the digit to which it
  // corresponds.
  String? decodeSegment(String segmentedDigit) {
    switch (segmentedDigit.length) {
      case 2:
        return '1';
      case 4:
        return '4';
      case 3:
        return '7';
      case 7:
        return '8';
    }

    final digitOne = input.firstWhere((segment) => segment.length == 2);

    // could be '2' or '3' or '5'
    if (segmentedDigit.length == 5) {
      // A '2' or '5' does not contain all the same segments as a '1'
      if (matchSegments(segmentedDigit, digitOne)) {
        return '3';
      }
      // could be '2' or '5'
      final digitNine = input.firstWhere(
          (element) => (element.length == 6 && decodeSegment(element) == '9'));
      if (matchSegments(digitNine, segmentedDigit)) {
        return '5';
      } else {
        return '2';
      }
    }

    // could be '0' or '6' or '9'
    if (segmentedDigit.length == 6) {
      // A '6' does not contain all the same segments as a '1'
      if (!matchSegments(segmentedDigit, digitOne)) {
        return '6';
      }
      final digitFour = input.firstWhere((segment) => segment.length == 4);
      // A '9' is a '4' with an additional top segment
      if (matchSegments(segmentedDigit, digitFour)) {
        return '9';
      } else {
        return '0';
      }
    }

    return null;
  }

  /// Return the digits representing a specific signal.
  int get decoded {
    final decodedString =
        output.map((segmentedDigit) => decodeSegment(segmentedDigit)).join('');
    return int.parse(decodedString);
  }

  factory Signal.fromString(String raw) {
    final splitRow = raw.split(' | ');
    final input = splitRow.first.split(' ');
    final output = splitRow.last.split(' ');
    return Signal(input, output);
  }
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day08/day08.txt';
  final rawData = File(path).readAsLinesSync();
  final signals = rawData.map((e) => Signal.fromString(e));

  final uniqueSegments =
      signals.map((e) => e.uniqueSegments).reduce((v, e) => v + e);
  print('Unique segments in output: $uniqueSegments');

  final total = signals.map((signal) => signal.decoded).reduce((v, e) => v + e);
  print('Total of all signals: $total');
}
// coverage:ignore-end