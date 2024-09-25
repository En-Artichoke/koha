import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';
import 'package:koha/features/articles/models/article.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;
  final bool isFirst;

  const ArticleListItem({
    super.key,
    required this.article,
    this.isFirst = false,
  });

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
    return Column(
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
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDateTime(article.publishedAt),
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              article.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Avenir LT 55 Roman',
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/image/arrow-info.svg',
                            color: Colors.white,
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        else
          CustomPaint(
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
                      if (article.media.isNotEmpty)
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
      ],
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

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('d MMM yyyy').format(date);
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
