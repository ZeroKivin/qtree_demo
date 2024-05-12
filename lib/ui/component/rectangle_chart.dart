import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RectangleChart extends StatefulWidget {
  final double size;
  final List<Point> points;
  final List<Point> filteredPoints;
  final Rectangle boundary;
  final Rectangle searchBoundary;

  const RectangleChart({
    required this.size,
    required this.points,
    required this.filteredPoints,
    required this.boundary,
    required this.searchBoundary,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RectangleChartState();
}

class _RectangleChartState extends State<RectangleChart> {
  bool _showSearchBoundary = false;

  @override
  Widget build(BuildContext context) {
    final data = _showSearchBoundary ? widget.filteredPoints : widget.points;

    return GestureDetector(
      onTap: () => setState(() {
        _showSearchBoundary = !_showSearchBoundary;
      }),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.size,
          maxWidth: widget.size,
        ),
        child: AspectRatio(
          aspectRatio: widget.boundary.width / widget.boundary.height,
          child: ScatterChart(
            ScatterChartData(
              scatterSpots: [
                ...data.map(
                  (e) => ScatterSpot(
                    e.x.toDouble(),
                    e.y.toDouble(),
                    dotPainter: FlDotCirclePainter(
                      color: Colors.blue,
                      radius: 1,
                    ),
                  ),
                ),
              ],
              minX: widget.boundary.left.toDouble(),
              maxX: (widget.boundary.left + widget.boundary.width).toDouble(),
              minY: widget.boundary.top.toDouble(),
              maxY: (widget.boundary.top + widget.boundary.height).toDouble(),
              borderData: FlBorderData(
                show: true,
              ),
              gridData: const FlGridData(
                show: false,
              ),
              titlesData: const FlTitlesData(
                show: false,
              ),
              scatterTouchData: ScatterTouchData(
                enabled: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
