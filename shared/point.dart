import 'package:meta/meta.dart';

@immutable
class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  factory Point.fromString(String string) {
    final coords = string.split(',');
    return Point(int.parse(coords.first), int.parse(coords.last));
  }

  @override
  int get hashCode => x * y;

  @override
  String toString() {
    return '$x,$y';
  }

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;
}
