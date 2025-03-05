import 'package:flutter/material.dart';
import '../widgets/filter_widget.dart';
import 'results_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void applyFilters(Map<String, dynamic> filters) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultsScreen(filters: filters)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بحث متقدم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilterWidget(onApplyFilters: applyFilters),
      ),
    );
  }
}
