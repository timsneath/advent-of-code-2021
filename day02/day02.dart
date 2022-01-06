import 'dart:io';

int plotCourse(Iterable<String> course) {
  var horizontalPosition = 0;
  var depth = 0;

  for (final step in course) {
    final stepComponents = step.split(' ');
    final direction = stepComponents[0];
    final length = int.parse(stepComponents[1]);

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

int updatedPlotCourse(Iterable<String> course) {
  var horizontalPosition = 0;
  var depth = 0;
  var aim = 0;

  for (final step in course) {
    final stepComponents = step.split(' ');
    final direction = stepComponents[0];
    final units = int.parse(stepComponents[1]);

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
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day02/day02.txt';
  final course = File(path).readAsLinesSync();

  final courseDistance = plotCourse(course);
  print('Course distance [first algorithm]: $courseDistance');

  final updatedCourseDistance = updatedPlotCourse(course);
  print('Course distance [second algorithm]: $updatedCourseDistance');
}
// coverage:ignore-end
