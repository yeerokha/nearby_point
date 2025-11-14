import 'package:flutter/material.dart';
import 'package:nearby_point/domain/entities/poi_entity.dart';

class CategoryFilterButton extends StatelessWidget {
  final Set<POICategory> selectedCategories;
  final Function(POICategory) onCategoryToggle;

  const CategoryFilterButton({
    super.key,
    required this.selectedCategories,
    required this.onCategoryToggle,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<POICategory>(
      icon: const Icon(Icons.filter_list),
      onSelected: onCategoryToggle,
      itemBuilder: (context) => POICategory.values
          .map((category) => PopupMenuItem(
                value: category,
                child: Row(
                  children: [
                    Icon(
                      selectedCategories.contains(category)
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Text(_getCategoryName(category)),
                  ],
                ),
              ))
          .toList(),
    );
  }

  String _getCategoryName(POICategory category) {
    return category.toString().split('.').last;
  }
}
