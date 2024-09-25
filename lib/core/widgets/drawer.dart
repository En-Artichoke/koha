import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';
import 'package:koha/features/categories/models/categories.dart';
import 'package:koha/features/categories/notifiers/categories_notifier.dart';

class DrawerContent extends ConsumerWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(categoryProvider);

    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFF03070A),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: categoriesAsyncValue.when(
                  data: (categories) {
                    final superCategories = categories
                        .where((category) => category.parentId == null)
                        .toList();
                    return ListView.builder(
                      itemCount: superCategories.length,
                      itemBuilder: (context, index) {
                        final category = superCategories[index];
                        return _buildCategoryItem(context, category);
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).go('/about');
                  },
                  child: const Text(
                    'Impresum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Avenir LT 55 Roman',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).go('/about');
                  },
                  child: const Text(
                    'Marketing',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Avenir LT 55 Roman',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).go('/about');
                  },
                  child: const Text(
                    'Politika e privatësisë',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Avenir LT 55 Roman',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).go('/about');
                  },
                  child: const Text(
                    'Kushtet e përdorimit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Avenir LT 55 Roman',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/image/Koha-logo.png',
                    width: 65,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, Category category) {
    Color categoryColor = Colors.grey;
    if (category.color != null && category.color!.isNotEmpty) {
      try {
        categoryColor =
            Color(int.parse(category.color!.replaceAll('#', '0xFF')));
      } catch (e) {
        print('Error parsing color: ${category.color}');
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CustomPaint(
        painter: DashedBorderPainter(
          strokeWidth: 1,
          dashWidth: 2,
          dashSpace: 2,
          bottomOnly: true,
        ),
        child: ListTile(
          title: Row(
            children: [
              Text(
                category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Avenir LT 55 Roman',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: categoryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            GoRouter.of(context).go('/category/${category.slug}');
          },
        ),
      ),
    );
  }
}
