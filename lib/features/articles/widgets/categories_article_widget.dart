import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:koha/core/widgets/dashed_border_lrb.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';
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

        if (categoryId == 5) {
          return _buildSpecialLayout(context, currentCategoryArticles);
        }

        return Column(
          children: [
            const Divider(
              endIndent: 18,
              indent: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
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
      loading: () => const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildSpecialLayout(BuildContext context, List<Article> articles) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return GestureDetector(
                    onTap: () {
                      context.go('/article/${article.id}');
                    },
                    child: _buildSpecialArticleItem(context, article),
                  );
                },
              )),
        ),
      ],
    );
  }

  Color _parseColor(String? colorString) {
    if (colorString == null) return Colors.grey;
    colorString = colorString.replaceAll("#", "");
    if (colorString.length == 6) {
      return Color(int.parse("0xFF$colorString"));
    }
    return Colors.grey;
  }

  Widget _buildSpecialArticleItem(BuildContext context, Article article) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPaint(
              painter: DashedBorderLRB(
                color: Colors.white70,
                strokeWidth: 1,
                dashWidth: 2,
                dashSpace: 2,
                padding: 0,
                cornerGap: 7,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (article.authors.isNotEmpty &&
                        article.authors.first.media.isNotEmpty)
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          article.authors.first.media.first.auto,
                        ),
                      ),
                    const SizedBox(height: 8),
                    if (article.authors.isNotEmpty)
                      Text(
                        article.authors.first.name,
                        style: const TextStyle(
                          color: Color(0xFFE8E8E8),
                          fontSize: 12,
                          fontFamily: 'Avenir LT 55 Roman',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: Colors.white70,
                  strokeWidth: 1,
                  dashWidth: 2,
                  dashSpace: 2,
                  bottomOnly: true,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildArticleTitle(article.title),
                      _buildArticleTitle(article.title),
                      _buildArticleTitle(article.title),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            article.category.name,
                            style: TextStyle(
                              color: _parseColor(article.category.color),
                              fontSize: 12,
                              fontFamily: 'Avenir LT 55 Roman',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            ' • ${_formatTime(article.publishedAt)}',
                            style: const TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 12,
                              fontFamily: 'Avenir LT 55 Roman',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatDate(article.publishedAt),
                            style: const TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 12,
                              fontFamily: 'Avenir LT 55 Roman',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        "$title →",
        style: const TextStyle(
          color: Color(0xFFE8E8E8),
          fontSize: 14,
          fontFamily: 'Avenir LT 55 Roman',
          fontWeight: FontWeight.w400,
        ),
      ),
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
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      article.category.name,
                      style: TextStyle(
                        color: _parseColor(article.category.color),
                        fontFamily: 'Avenir LT 55 Roman',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ' • ${_formatTime(article.publishedAt)}',
                      style: const TextStyle(
                        color: Color(0xFF888888),
                        fontFamily: 'Avenir LT 55 Roman',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
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
                  Row(
                    children: [
                      Text(
                        article.category.name,
                        style: TextStyle(
                          color: _parseColor(article.category.color),
                          fontSize: 12,
                          fontFamily: 'Avenir LT 55 Roman',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        ' • ${_formatTime(article.publishedAt)}',
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 12,
                          fontFamily: 'Avenir LT 55 Roman',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('d MMM yyyy').format(date);
  }

  String _getCategoryName(int categoryId) {
    // Implement proper category lookup here
    return 'Arbëri';
  }
}
