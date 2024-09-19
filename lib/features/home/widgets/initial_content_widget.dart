import 'package:flutter/material.dart';
import 'package:koha/core/widgets/info_row.dart';
import 'package:koha/features/latests/widgets/latests_widgets.dart';
import 'package:koha/features/weather/widget/weather_widget.dart';

class InitialContentWidget extends StatelessWidget {
  const InitialContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LatestNewsByCategoryWidget(),
          const SizedBox(height: 20),
          InfoRow(
            leftWidget: const Text(
              'Karikatura e ditës',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Avenir LT 55 Roman',
                fontWeight: FontWeight.w700,
              ),
            ),
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
            leftWidget: Image.asset('assets/image/koha-ditore-mini-logo.png'),
            rightWidget: const Text(
              'lexo gazeten',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Avenir LT 55 Roman',
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {},
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
