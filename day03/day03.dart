import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';

Future<int> calcPowerConsumption(Stream<String> report) async {
  final queue = StreamQueue<String>(report);
  final reportBitLength = (await queue.peek).length;
  final List<int> bitTally = List.filled(reportBitLength, 0);
  int reportEntries = 0;

  // Tally the number of bits in
  while (await queue.hasNext) {
    final entry = await queue.next;
    for (int idx = 0; idx < entry.length; idx++) {
      if (entry[idx] == '1') bitTally[idx]++;
    }
    reportEntries++;
  }

  final bGammaRate = bitTally.map((e) => e * 2 >= reportEntries ? '1' : '0');
  final bEpsilonRate = bitTally.map((e) => e * 2 >= reportEntries ? '0' : '1');

  final gammaRate = int.parse(bGammaRate.join(''), radix: 2);
  final epsilonRate = int.parse(bEpsilonRate.join(''), radix: 2);
  return gammaRate * epsilonRate;
}

void main(List<String> args) async {
  final path = args.isNotEmpty ? args[0] : 'day03/day03.txt';
  final course =
      File(path).openRead().transform(utf8.decoder).transform(LineSplitter());

  final power = await calcPowerConsumption(course);
  print('Power consumption: $power');
}
