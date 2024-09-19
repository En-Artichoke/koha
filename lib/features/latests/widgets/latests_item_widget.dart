import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koha/features/articles/models/article.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;
  final bool isFirst;

  const ArticleListItem({
    Key? key,
    required this.article,
    this.isFirst = false,
  }) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFirst && article.media.isNotEmpty)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.network(
                    article.media.first.auto,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${article.category.slug} • ${_formatDateTime(article.publishedAt)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Avenir LT 55 Roman',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          article.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Avenir LT 55 Roman',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article.media.isNotEmpty)
                  Image.network(
                    article.media.first.thumb,
                    width: 62,
                    height: 62,
                    fit: BoxFit.cover,
                  ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${article.category.slug} • ${_formatTime(article.publishedAt)}',
                        style: TextStyle(
                          color: _parseColor(article.category.color),
                          fontSize: 12,
                          fontFamily: 'Avenir LT 55 Roman',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        article.title,
                        style: TextStyle(
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
        ],
      ),
    );
  }

  String _formatTime(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('HH:mm').format(date);
  }

  String _formatDateTime(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('d MMM yyyy • HH:mm').format(date);
  }
}
