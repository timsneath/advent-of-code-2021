import 'package:test/test.dart';

import '../day03/day03.dart';

void main() {
  group('Part 1', () {
    test('Simple example', () {
      final input = <String>['000', '011', '111'];
      final power = calcPowerConsumption(convertRawData(input));
      expect(power, equals(0x03 * 0x04));
    });

    test('Sample input', () {
      final input = <String>[
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
      ];
      final power = calcPowerConsumption(convertRawData(input));
      expect(power, equals(198));
    });
  });

  group('Part 2', () {
    test('Oxygen generator rating', () {
      final input = <String>[
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
      ];
      final o2 = calcOxygenGeneratorRating(convertRawData(input));
      expect(o2, equals(23));
    });

    test('CO2 scrubber rating', () {
      final input = <String>[
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
      ];
      final co2 = calcCO2ScrubberRating(convertRawData(input));
      expect(co2, equals(10));
    });
  });
}
