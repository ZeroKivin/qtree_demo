import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qtree_demo/manager/benchmark_manager.dart';

import '../../manager/point_generator.dart';

class CalculationPage extends StatefulWidget {
  const CalculationPage({
    super.key,
  });

  @override
  State<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  int _bruteforceTime = 0;
  int _qtreeTime = 0;

  final TextEditingController _countController = TextEditingController();
  final TextEditingController _maxXController = TextEditingController();
  final TextEditingController _maxYController = TextEditingController();
  final TextEditingController _topController = TextEditingController();
  final TextEditingController _leftController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

  final PointGenerator _pointGenerator = PointGenerator();

  @override
  void dispose() {
    _countController.dispose();
    _maxXController.dispose();
    _maxYController.dispose();
    _topController.dispose();
    _leftController.dispose();
    _heightController.dispose();
    _widthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _Gap.height(),
                Text('Bruteforce array time: $_bruteforceTime'),
                const _Gap.height(),
                Text('Qtree time: $_qtreeTime'),
                const _Gap.height(),
                const Text(
                  'Points boundary',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const _Gap.height(),
                _TextField(
                  controller: _countController,
                  title: 'Count',
                ),
                const _Gap.height(),
                _TextField(
                  controller: _maxXController,
                  title: 'Max X',
                ),
                const _Gap.height(),
                _TextField(
                  controller: _maxYController,
                  title: 'Max Y',
                ),
                const _Gap.height(),
                const Text(
                  'Search boundary',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const _Gap.height(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _TextField(
                        controller: _topController,
                        title: 'Top',
                      ),
                    ),
                    const _Gap.width(),
                    Expanded(
                      child: _TextField(
                        controller: _leftController,
                        title: 'Left',
                      ),
                    ),
                    const _Gap.width(),
                    Expanded(
                      child: _TextField(
                        controller: _heightController,
                        title: 'Height',
                      ),
                    ),
                    const _Gap.width(),
                    Expanded(
                      child: _TextField(
                        controller: _widthController,
                        title: 'Width',
                      ),
                    ),
                  ],
                ),
                const _Gap.height(),
                ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity, 48),
                  ),
                  child: const Center(
                    child: Text('Calculate'),
                  ),
                ),
                const _Gap.height(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _calculate() async {
    final points = _pointGenerator.generateRandomPoints(
      int.parse(_countController.text),
      double.parse(_maxXController.text),
      double.parse(_maxYController.text),
    );
    final benchmarkManager = BenchmarkManager(
      points: points,
      boundary: Rectangle(
        0,
        0,
        double.parse(_maxXController.text),
        double.parse(_maxYController.text),
      ),
    );
    final searchBoundary = Rectangle(
      double.parse(_leftController.text),
      double.parse(_topController.text),
      double.parse(_widthController.text),
      double.parse(_heightController.text),
    );

    final arrayResult = benchmarkManager.measureArray(
      rectangle: searchBoundary,
    );
    final qtreeResult = benchmarkManager.measureQtree(
      rectangle: searchBoundary,
    );

    setState(() {
      _bruteforceTime = arrayResult.time;
      _qtreeTime = qtreeResult.time;
    });
  }
}

class _TextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const _TextField({
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(title),
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}

class _Gap extends StatelessWidget {
  final double? height;
  final double? width;

  const _Gap.height()
      : height = 20,
        width = null;

  const _Gap.width()
      : width = 20,
        height = null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
