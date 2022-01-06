import 'package:meta/meta.dart';

import 'point.dart';

@immutable
class Line {
  final Point from;
  final Point to;

  const Line(this.from, this.to);

  bool get isHorizontal => from.y == to.y;
  bool get isVertical => from.x == to.x;

  factory Line.fromString(String string) {
    final points = string.split(' -> ');
    return Line(Point.fromString(points.first), Point.fromString(points.last));
  }

  @override
  int get hashCode => from.hashCode * to.hashCode;

  @override
  String toString() {
    return '$from -> $to';
  }

  @override
  bool operator ==(Object other) =>
      other is Line && other.from == from && other.to == to;
}
