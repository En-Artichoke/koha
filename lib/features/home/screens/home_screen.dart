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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CategoryTabs(),
              const SizedBox(height: 20),
              InfoRow(
                leftWidget: const Text('Karikatura e ditës',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Avenir LT 55 Roman',
                      fontWeight: FontWeight.w700,
                    )),
                rightWidget: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset('assets/image/karikatura.png'),
                ),
                onTap: () {},
                backgroundColor: const Color(0xFFE64A19),
              ),
              const SizedBox(height: 20),
              const WeatherWidget(),
              const SizedBox(height: 20),
              InfoRow(
                leftWidget:
                    Image.asset('assets/image/koha-ditore-mini-logo.png'),
                rightWidget: const Text('lexo gazeten',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Avenir LT 55 Roman',
                      fontWeight: FontWeight.w700,
                    )),
                onTap: () {},
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
