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
  bool _initialContentShown = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryProvider.notifier).getCategories();
    });
  }

  Future<bool> _categoryHasArticles(int categoryId) async {
    await ref.read(categoryArticlesProvider.notifier).getArticles(categoryId);
    final articlesState = ref.read(categoryArticlesProvider);
    final hasArticles = articlesState.maybeWhen(
      data: (articles) => articles
          .where((article) => article.category.id == categoryId)
          .isNotEmpty,
      orElse: () => false,
    );
    return hasArticles;
  }

  Future<void> _selectCategory(Category category,
      {bool isChild = false}) async {
    if (await _categoryHasArticles(category.id)) {
      _updateSelectedCategory(category, isChild);
    } else if (category.children.isNotEmpty) {
      for (var child in category.children) {
        if (await _categoryHasArticles(child.id)) {
          _updateSelectedCategory(child, true);
          break;
        }
      }
    } else {}
  }

  void _updateSelectedCategory(Category category, bool isChild) {
    setState(() {
      _initialContentShown = false;
      if (!isChild) {
        _selectedParentIndex = ref
            .read(categoryProvider)
            .value!
            .indexWhere((c) => c.id == category.id);
        _selectedChildIndex = -1;
      } else {
        _selectedParentIndex = ref
            .read(categoryProvider)
            .value!
            .indexWhere((c) => c.id == category.parentId);
        _selectedChildIndex = ref
            .read(categoryProvider)
            .value!
            .firstWhere((c) => c.id == category.parentId)
            .children
            .indexWhere((c) => c.id == category.id);
      }
    });
    ref.read(categoryArticlesProvider.notifier).getArticles(category.id);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoryProvider);

    return categoriesState.when(
      data: (categories) {
        List<Category> parentCategories =
            categories.where((category) => category.parentId == null).toList();

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
                    onTap: () => _selectCategory(category),
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
                      onTap: () =>
                          _selectCategory(childCategory, isChild: true),
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
            if (_initialContentShown)
              const InitialContentWidget()
            else if (_selectedParentIndex != -1 &&
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
      loading: () => const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
