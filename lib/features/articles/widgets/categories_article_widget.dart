import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:koha/features/articles/models/article.dart';
import 'package:koha/features/articles/notifiers/category_article_notifier.dart';

class CategoryArticlesWidget extends ConsumerWidget {
  final int categoryId;

  const CategoryArticlesWidget({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesState = ref.watch(categoryArticlesProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryArticlesProvider.notifier).getArticles(categoryId);
    });

    return articlesState.when(
      data: (articles) {
        final currentCategoryArticles = articles
            .where((article) => article.category.id == categoryId)
            .toList();

        if (currentCategoryArticles.isEmpty) {
          return const Center(
              child: Text('No articles found for this category.'));
        }

        return Column(
          children: [
            const Divider(
              endIndent: 18,
              indent: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: currentCategoryArticles.length,
                  itemBuilder: (context, index) {
                    final article = currentCategoryArticles[index];
                    return GestureDetector(
                      onTap: () {
                        context.go('/article/${article.id}');
                      },
                      child: _buildArticleItem(context, article, index),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article, int index) {
    if (index == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.media.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.network(
                article.media.first.auto,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_getCategoryName(article.category.id)} • ${_formatTime(article.publishedAt)}',
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
                    '${_getCategoryName(article.category.id)} • ${_formatTime(article.publishedAt)}',
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
