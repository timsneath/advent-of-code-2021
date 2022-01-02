import 'dart:convert';
import 'dart:io';

Future<int> plotCourse(Stream<String> course) async {
  int horizontalPosition = 0;
  int depth = 0;

  await for (final step in course) {
    final stepComponents = step.split(' ');
    final String direction = stepComponents[0];
    final int length = int.parse(stepComponents[1]);

    switch (direction) {
      case 'forward':
        horizontalPosition += length;
        break;
      case 'down':
        depth += length;
        break;
      case 'up':
        depth -= length;
        break;
    }
  }

  return horizontalPosition * depth;
}

Future<int> updatedPlotCourse(Stream<String> course) async {
  int horizontalPosition = 0;
  int depth = 0;
  int aim = 0;

  await for (final step in course) {
    final stepComponents = step.split(' ');
    final String direction = stepComponents[0];
    final int units = int.parse(stepComponents[1]);

    switch (direction) {
      case 'forward':
        horizontalPosition += units;
        depth += aim * units;
        break;
      case 'down':
        aim += units;
        break;
      case 'up':
        aim -= units;
        break;
    }
  }

  return horizontalPosition * depth;
}

// coverage:ignore-start
void main(List<String> args) async {
  final path = args.isNotEmpty ? args[0] : 'day02/day02.txt';
  final course =
      File(path).openRead().transform(utf8.decoder).transform(LineSplitter());

  final courseDistance = await updatedPlotCourse(course);
  print('Course distance: $courseDistance');
}
// coverage:ignore-end