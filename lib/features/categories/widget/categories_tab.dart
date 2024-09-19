import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/features/articles/notifiers/category_article_notifier.dart';
import 'package:koha/features/articles/widgets/categories_article_widget.dart';
import 'package:koha/features/categories/notifiers/categories_notifier.dart';
import 'package:koha/features/categories/models/categories.dart';
import '../../home/widgets/initial_content_widget.dart';

class CategoryTabs extends ConsumerStatefulWidget {
  const CategoryTabs({super.key});

  @override
  _CategoryTabsState createState() => _CategoryTabsState();
}

class _CategoryTabsState extends ConsumerState<CategoryTabs> {
  int _selectedParentIndex = -1;
  int _selectedChildIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryProvider.notifier).getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoryProvider);

    return categoriesState.when(
      data: (categories) {
        List<Category> parentCategories =
            categories.where((category) => category.parentId == null).toList();

        if (ref.read(categoryArticlesProvider).value == null &&
            parentCategories.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref
                .read(categoryArticlesProvider.notifier)
                .getArticles(parentCategories[0].id);
          });
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: parentCategories.length,
                itemBuilder: (context, index) {
                  final category = parentCategories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedParentIndex = index;
                        _selectedChildIndex = -1;
                      });
                      ref
                          .read(categoryArticlesProvider.notifier)
                          .getArticles(category.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedParentIndex == index
                                ? Color(int.parse(
                                    '0xFF${category.color?.substring(1) ?? 'FFFFFF'}'))
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        category.name,
                        style: TextStyle(
                          color: _selectedParentIndex == index
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 16,
                          fontFamily: 'Avenir LT 55 Roman',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_selectedParentIndex != -1 &&
                _selectedParentIndex < parentCategories.length &&
                parentCategories[_selectedParentIndex].children.isNotEmpty)
              Container(
                height: 35,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      parentCategories[_selectedParentIndex].children.length,
                  itemBuilder: (context, index) {
                    final childCategory =
                        parentCategories[_selectedParentIndex].children[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedChildIndex = index;
                        });
                        ref
                            .read(categoryArticlesProvider.notifier)
                            .getArticles(childCategory.id);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Center(
                            child: Text(
                              childCategory.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Avenir LT 55 Roman',
                                fontWeight: _selectedChildIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )),
                    );
                  },
                ),
              ),
            if (_selectedParentIndex == -1) ...[
              const InitialContentWidget(),
            ],
            if (_selectedParentIndex != -1 &&
                _selectedParentIndex < parentCategories.length)
              CategoryArticlesWidget(
                key: ValueKey(
                    '${parentCategories[_selectedParentIndex].id}-$_selectedChildIndex'),
                categoryId: _selectedChildIndex != -1
                    ? parentCategories[_selectedParentIndex]
                        .children[_selectedChildIndex]
                        .id
                    : parentCategories[_selectedParentIndex].id,
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
