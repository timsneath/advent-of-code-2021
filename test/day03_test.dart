import 'package:test/test.dart';

import '../day03/day03.dart';

void main() {
  group('Part 1', () {
    test('Simple example', () async {
      final input = Stream.fromIterable(<String>['000', '011', '111']);
      final power = await calcPowerConsumption(input);
      expect(power, equals(0x03 * 0x04));
    });

    test('Sample input', () async {
      final input = Stream.fromIterable(<String>[
        '00100',
        '11110',
        '10110',
        '10111',
        '10101',
        '01111',
        '00111',
        '11100',
        '10000',
        '11001',
        '00010',
        '01010'
      ]);
      final power = await calcPowerConsumption(input);
      expect(power, equals(198));
    });
  });
}
