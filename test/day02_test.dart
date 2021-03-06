import 'package:test/test.dart';

import '../day02/day02.dart';

void main() {
  group('Part 1', () {
    test('Sample input', () {
      final depths = <String>[
        'forward 5',
        'down 5',
        'forward 8',
        'up 3',
        'down 8',
        'forward 2'
      ];
      final courseDistance = plotCourse(depths);
      expect(courseDistance, equals(150));
    });
  });

  group('Part 2', () {
    test('Sample input', () async {
      final depths = <String>[
        'forward 5',
        'down 5',
        'forward 8',
        'up 3',
        'down 8',
        'forward 2'
      ];
      final courseDistance = updatedPlotCourse(depths);
      expect(courseDistance, equals(900));
    });
  });
}
