import 'dart:math';

final class PointGenerator {
  final _random = Random();

  List<Point> generateRandomPoints(int count, double maxX, double maxY) {
    final List<Point> points = [];

    for (var i = 0; i < count; i++) {
      final x = _random.nextDouble() * maxX;
      final y = _random.nextDouble() * maxY;

      points.add(
        Point(x, y),
      );
    }

    return points;
  }
}
