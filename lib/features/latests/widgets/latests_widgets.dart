import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/features/latests/notifiers/latests_notifier.dart';
import 'package:koha/features/latests/widgets/latests_item_widget.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';

class LatestNewsByCategoryWidget extends ConsumerWidget {
  const LatestNewsByCategoryWidget({super.key});

  Color _parseColor(String? colorString) {
    if (colorString == null) return Colors.black;
    colorString = colorString.replaceAll("#", "");
    if (colorString.length == 6) {
      return Color(int.parse("0xFF$colorString"));
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestNewsState = ref.watch(latestNewsProvider);

    return latestNewsState.when(
      data: (articlesByCategory) {
        return Column(
          children:
              articlesByCategory.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final categoryName = entry.value.key;
            final articles = entry.value.value;

            return CustomPaint(
              painter: DashedBorderPainter(
                color: Colors.grey,
                strokeWidth: 1,
                dashWidth: 5,
                dashSpace: 3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, articleIndex) {
                      return Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: ArticleListItem(
                            article: articles[articleIndex],
                            isFirst: index == 0 && articleIndex == 0,
                          ));
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
      loading: () => const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
