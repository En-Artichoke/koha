import 'package:flutter/material.dart';
import 'package:koha/core/widgets/info_row.dart';
import 'package:koha/features/categories/widget/latest_category_articles_widget.dart';
import 'package:koha/features/editor_choices/widget/editor_choices.dart';
import 'package:koha/features/home/widgets/news_item.dart';
import 'package:koha/features/weather/widget/weather_widget.dart';

class InitialContentWidget extends StatelessWidget {
  const InitialContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const EditorChoicesWidget(),
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
          const NewsWidget(),
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
          const SizedBox(height: 20),
          const LatestCategoryArticlesWidget(),
          const SizedBox(height: 20),
          const WeatherWidget(),
        ],
      ),
    );
  }
}
