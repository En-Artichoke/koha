import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/features/categories/notifiers/categories_notifier.dart';
import 'package:koha/features/categories/models/categories.dart';

class CategoryTabs extends ConsumerStatefulWidget {
  const CategoryTabs({Key? key}) : super(key: key);

  @override
  _CategoryTabsState createState() => _CategoryTabsState();
}

class _CategoryTabsState extends ConsumerState<CategoryTabs> {
  int _selectedParentIndex = 0;
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

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 54,
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
            if (parentCategories[_selectedParentIndex].children.isNotEmpty)
              Container(
                height: 40,
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
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedChildIndex == index
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                        ),
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
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _selectedChildIndex != -1
                    ? 'Content for ${parentCategories[_selectedParentIndex].children[_selectedChildIndex].name}'
                    : 'Content for ${parentCategories[_selectedParentIndex].name}',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Avenir LT 55 Roman',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
