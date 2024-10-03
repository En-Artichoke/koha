import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/features/editor_choices/notifiers/editor_notifier.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';
import 'package:koha/features/editor_choices/widget/editor_choices_Item.dart';

class EditorChoicesWidget extends ConsumerWidget {
  const EditorChoicesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorChoicesState = ref.watch(editorChoicesProvider);

    return editorChoicesState.when(
      data: (editorChoices) {
        return Column(
          children: editorChoices.asMap().entries.map((entry) {
            final index = entry.key;
            final editorChoice = entry.value;

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
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: EditorChoiceItemWidget(
                      editorChoice: editorChoice,
                      isFirst: index == 0,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
