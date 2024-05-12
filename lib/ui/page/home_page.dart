import 'package:flutter/material.dart';
import 'package:qtree_demo/ui/page/calculation_page.dart';
import 'package:qtree_demo/ui/page/visualization_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          CalculationPage(),
          VisualizationPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setState(() {
          _index = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart_outlined),
            label: '',
          ),
        ],
      ),
    );
  }
}
