import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';
import 'package:koha/features/categories/models/latest_category_article.dart';
import 'package:koha/features/categories/notifiers/latest_category_articles.dart';

class LatestCategoryArticlesWidget extends ConsumerStatefulWidget {
  const LatestCategoryArticlesWidget({Key? key}) : super(key: key);

  @override
  LatestCategoryArticlesWidgetState createState() =>
      LatestCategoryArticlesWidgetState();
}

class LatestCategoryArticlesWidgetState
    extends ConsumerState<LatestCategoryArticlesWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(latestCategoryArticlesProvider.notifier).getLatestArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final articlesState = ref.watch(latestCategoryArticlesProvider);

    return articlesState.when(
      data: (articles) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategorySection('Arbëri', articles['18'] ?? []),
            _buildCategorySection('Sport', articles['6'] ?? []),
            _buildCategorySection('Botë', articles['21'] ?? []),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildCategorySection(
      String title, List<LatestCategoryArticle> articles) {
    final categoryColor = articles.isNotEmpty
        ? _parseColor(articles.first.category.color)
        : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: categoryColor,
            ),
          ),
        ),
        ...articles.map(
            (article) => LatestCategoryArticleItemWidget(article: article)),
        const Divider(color: Colors.grey),
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
}

class LatestCategoryArticleItemWidget extends StatelessWidget {
  final LatestCategoryArticle article;

  const LatestCategoryArticleItemWidget({super.key, required this.article});

  Color _parseColor(String? colorString) {
    if (colorString == null) return Colors.grey;
    colorString = colorString.replaceAll("#", "");
    if (colorString.length == 6) {
      return Color(int.parse("0xFF$colorString"));
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final identifier = article.id;
        context.go('/article/$identifier');
      },
      child: CustomPaint(
        painter: DashedBorderPainter(
          topOnly: true,
          strokeWidth: 1,
          dashWidth: 2,
          dashSpace: 2,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    article.media.first.thumb,
                    width: 80,
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
                              _capitalizeFirstLetter(article.category.slug),
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
                            fontSize: 16,
                            fontFamily: 'Avenir LT 55 Roman',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  Text(
                    _formatDate(article.publishedAt),
                    style: const TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border,
                        color: Colors.white, size: 24),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
