import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:koha/features/articles/notifiers/category_article_notifier.dart';

class CategoryArticlesWidget extends ConsumerWidget {
  final int categoryId;

  const CategoryArticlesWidget({Key? key, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesState = ref.watch(categoryArticlesProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryArticlesProvider.notifier).getArticles(categoryId);
    });

    return articlesState.when(
      data: (articles) {
        final currentCategoryArticles = articles
            .where((article) => article.categoryId == categoryId)
            .toList();

        return SizedBox(
          height: 500,
          child: ListView.builder(
            itemCount: currentCategoryArticles.length,
            itemBuilder: (context, index) {
              final article = currentCategoryArticles[index];
              if (index == 0) {
                // First article with larger image
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (article.media.isNotEmpty)
                      Image.network(
                        article.media.first.auto,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_getCategoryName(article.categoryId)} • ${_formatTime(article.publishedAt)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            article.title,
                            style: const TextStyle(
                              color: Color(0xFFE8E8E8),
                              fontSize: 16,
                              fontFamily: 'Avenir LT 55 Roman',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Other articles
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.media.isNotEmpty)
                        Image.network(
                          article.media.first.thumb,
                          width: 62,
                          height: 62,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_getCategoryName(article.categoryId)} • ${_formatTime(article.publishedAt)}',
                              style: const TextStyle(
                                color: Color(0xFF888888),
                                fontSize: 12,
                                fontFamily: 'Avenir LT 55 Roman',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              article.title,
                              style: const TextStyle(
                                color: Color(0xFFE8E8E8),
                                fontSize: 14,
                                fontFamily: 'Avenir LT 55 Roman',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  String _formatTime(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('HH:mm').format(date);
  }

  String _getCategoryName(int categoryId) {
    // Implement proper category lookup here
    return 'Arbëri';
  }
}
