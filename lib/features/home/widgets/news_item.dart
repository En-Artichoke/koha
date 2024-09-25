import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/widgets/dashed_circle_painter.dart';
import 'package:koha/features/articles/models/article.dart';
import 'package:koha/features/latests/notifiers/latests_notifier.dart';
import 'package:koha/features/most_read/model/most_read_article.dart';
import 'package:koha/features/most_read/notifier/most_read_notifier.dart';

class NewsWidget extends ConsumerStatefulWidget {
  const NewsWidget({super.key});

  @override
  ConsumerState<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends ConsumerState<NewsWidget> {
  bool isRecentTab = true;
  String selectedCategory = 'Të Gjitha';

  List<String> categories = ['Të Gjitha'];

  @override
  Widget build(BuildContext context) {
    final latestNews = ref.watch(latestNewsProvider);
    final mostRead = ref.watch(mostReadProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTabButton('Të fundit', isRecentTab,
                  () => setState(() => isRecentTab = true)),
              _buildTabButton('Më të lexuarat', !isRecentTab,
                  () => setState(() => isRecentTab = false)),
            ],
          ),
          const SizedBox(height: 16),
          isRecentTab
              ? _buildRecentTab(latestNews)
              : _buildPopularTab(mostRead),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CustomPaint(
            painter: DashedCirclePainter(
              color: Colors.white,
              dashSize: 2,
              gapSize: 2,
            ),
            size: const Size(28, 28),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.red : Colors.white,
              fontSize: 16,
              fontFamily: 'Avenir LT 55 Roman',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTab(AsyncValue<Map<String, List<Article>>> latestNews) {
    return latestNews.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (data) {
        final allArticles = data.values.expand((e) => e).toList();
        return Column(
          children: allArticles
              .take(5)
              .map((article) => _buildRecentNewsItem(article))
              .toList(),
        );
      },
    );
  }

  Widget _buildRecentNewsItem(Article article) {
    final timeElapsed = _getTimeElapsed(article.publishedAt);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 48,
            child: article.media.isNotEmpty
                ? Image.network(article.media.first.thumb, fit: BoxFit.cover)
                : Container(color: Colors.grey[700]),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeElapsed,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                Text(
                  article.title,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeElapsed(String publishedAt) {
    final now = DateTime.now();
    final published = DateTime.parse(publishedAt);
    final difference = now.difference(published);
    final minutes = difference.inMinutes;

    if (minutes < 60) {
      return '$minutes min';
    } else if (minutes < 1440) {
      final hours = difference.inHours;
      return '$hours h';
    } else {
      final days = difference.inDays;
      return '$days d';
    }
  }

  Widget _buildPopularTab(AsyncValue<List<MostReadArticle>> mostRead) {
    return mostRead.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (articles) {
        // Update categories based on the fetched articles
        categories = [
          'Të Gjitha',
          ...articles.map((a) => a.category.name).toSet()
        ];

        return Column(
          children: [
            _buildCategorySelector(),
            const SizedBox(height: 8),
            ...filterAndLimitArticles(articles).asMap().entries.map(
                (entry) => _buildPopularNewsItem(entry.key + 1, entry.value)),
          ],
        );
      },
    );
  }

  List<MostReadArticle> filterAndLimitArticles(List<MostReadArticle> articles) {
    if (selectedCategory == 'Të Gjitha') {
      return articles.take(5).toList();
    } else {
      return articles
          .where((article) => article.category.name == selectedCategory)
          .take(5)
          .toList();
    }
  }

  Widget _buildCategorySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories
          .map((category) => GestureDetector(
                onTap: () => setState(() => selectedCategory = category),
                child: Text(
                  category,
                  style: TextStyle(
                    color: category == selectedCategory
                        ? Colors.red
                        : Colors.grey[400],
                    fontSize: 12,
                    fontWeight: category == selectedCategory
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildPopularNewsItem(int index, MostReadArticle article) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFF888888),
              fontSize: 24,
              fontFamily: 'Avenir LT 65 Medium',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Text(
            article.title,
            style: const TextStyle(
              color: Color(0xFFE8E8E8),
              fontSize: 12,
              fontFamily: 'Avenir LT 55 Roman',
              fontWeight: FontWeight.w400,
            ),
          )),
        ],
      ),
    );
  }
}
