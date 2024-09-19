import 'package:flutter/material.dart';
import 'package:koha/features/categories/widget/categories_tab.dart';
import 'package:koha/core/widgets/info_row.dart';
import 'package:koha/features/weather/widget/weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: ListView(
          children: [
            const Expanded(
              child: CategoryTabs(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
