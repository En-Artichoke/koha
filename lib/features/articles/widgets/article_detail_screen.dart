import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:koha/features/articles/models/article_details.dart';
import 'package:koha/features/articles/notifiers/article_details_provider.dart';

class ArticleDetailScreen extends ConsumerStatefulWidget {
  final String articleId;

  const ArticleDetailScreen({Key? key, required this.articleId})
      : super(key: key);

  @override
  ConsumerState<ArticleDetailScreen> createState() =>
      _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends ConsumerState<ArticleDetailScreen> {
  bool _isLargeText = false;

  @override
  Widget build(BuildContext context) {
    final articleAsyncValue =
        ref.watch(articleDetailNotifierProvider(widget.articleId));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.push('/home'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isLargeText ? Icons.text_fields : Icons.text_fields_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isLargeText = !_isLargeText;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: () {
              // Implement bookmark functionality
            },
          ),
        ],
      ),
      body: articleAsyncValue.when(
        data: (article) => _buildArticleDetail(context, article),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildArticleDetail(BuildContext context, ArticleDetails article) {
    return SingleChildScrollView(
      child: Column(
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.category.name.toUpperCase(),
                  style: TextStyle(
                    color: _parseColor(article.category.color),
                    fontSize: _isLargeText ? 14 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.title,
                  style: TextStyle(
                    fontSize: _isLargeText ? 28 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                if (article.authors.isNotEmpty)
                  Text(
                    'AUTORI: ${article.authors.first.name}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: _isLargeText ? 14 : 12,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  _formatDateTime(article.publishedAt),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: _isLargeText ? 14 : 12,
                  ),
                ),
                const SizedBox(height: 16),
                Html(
                  data: article.excerpt,
                  style: {
                    "body": Style(
                      fontSize: FontSize(_isLargeText ? 20 : 16),
                      color: Colors.white,
                    ),
                    "a": Style(
                      color: Colors.blue,
                    ),
                  },
                ),
                const SizedBox(height: 16),
                Html(
                  data: article.text,
                  style: {
                    "body": Style(
                      fontSize: FontSize(_isLargeText ? 20 : 16),
                      color: Colors.white,
                    ),
                    "a": Style(
                      color: Colors.blue,
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('d MMMM yyyy HH:mm').format(date);
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
