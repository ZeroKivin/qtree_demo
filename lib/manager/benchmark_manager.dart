import 'dart:math';

import 'package:qtree_demo/model/quad_tree.dart';

final class BenchmarkManager {
  final List<Point> _points;
  final QuadTree _quadTree;

  final Stopwatch stopwatch = Stopwatch();

  BenchmarkManager({
    required List<Point> points,
    required Rectangle boundary,
  })  : _points = points,
        _quadTree = QuadTree(boundary: boundary)..insertAll(points);

  ({List<Point<num>> points, int time}) measureQtree({
    required Rectangle rectangle,
  }) {
    stopwatch.reset();
    stopwatch.start();

    final result = _quadTree.queryRange(rectangle);

    stopwatch.stop();

    return (points: result, time: stopwatch.elapsedMilliseconds);
  }

  ({List<Point<num>> points, int time}) measureArray({
    required Rectangle rectangle,
  }) {
    stopwatch.reset();
    stopwatch.start();

    final result = <Point>[];
    for (final point in _points) {
      if (rectangle.containsPoint(point)) {
        result.add(point);
      }
    }

    stopwatch.stop();

    return (points: result, time: stopwatch.elapsedMilliseconds);
  }
}
