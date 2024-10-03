import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';
import 'package:koha/features/editor_choices/models/editor_choices.dart';

class EditorChoiceItemWidget extends StatelessWidget {
  final EditorChoice editorChoice;
  final bool isFirst;

  const EditorChoiceItemWidget({
    super.key,
    required this.editorChoice,
    this.isFirst = false,
  });

  Color _parseColor(String? colorString) {
    print('colorString: $colorString');
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
          final identifier = editorChoice.id;
          context.go('/article/$identifier');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFirst && editorChoice.media.isNotEmpty) ...[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Image.network(
                      editorChoice.media.first.auto,
                      width: double.infinity,
                      height: 220,
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
                            _formatDateTime(editorChoice.createdAt),
                            style: const TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  editorChoice.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Avenir LT 55 Roman',
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
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
              ),
              const SizedBox(height: 30),
            ] else
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
                          if (editorChoice.media.isNotEmpty)
                            Image.network(
                              editorChoice.media.first.thumb,
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
                                      _capitalizeFirstLetter(
                                          editorChoice.category.slug),
                                      style: TextStyle(
                                        color: _parseColor(
                                            editorChoice.category.color),
                                        fontSize: 14,
                                        fontFamily: 'Avenir LT 55 Roman',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      ' • ${_formatTime(editorChoice.createdAt)}',
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
                                  editorChoice.title,
                                  style: const TextStyle(
                                    color: Color(0xFFE8E8E8),
                                    fontSize: 16,
                                    fontFamily: 'Avenir LT 55 Roman',
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 33,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                _formatDate(editorChoice.createdAt),
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
                        )),
                  ],
                ),
              ),
          ],
        ));
  }

  String _formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  String _formatDateTime(DateTime date) {
    return DateFormat('d MMM yyyy • HH:mm').format(date);
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
