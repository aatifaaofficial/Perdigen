import 'package:flutter/material.dart';
import 'package:personal_diet_journal/data/meal_repository.dart';
import 'package:personal_diet_journal/widgets/meals/food_item_card.dart';
import 'package:personal_diet_journal/widgets/meals/food_search_bar.dart';

class FoodSelectionPage extends StatefulWidget {
  final MealRepository repository;
  const FoodSelectionPage({super.key, required this.repository});
  @override
  State<FoodSelectionPage> createState() => _FoodSelectionPageState();
}

class _FoodSelectionPageState extends State<FoodSelectionPage> {
  String _query = '';
  String _category = 'All';
  static const categories = [
    'All',
    'Breakfast',
    'Protein',
    'Fruits',
    'Vegetables',
    'Grains',
    'Dairy',
    'Snacks',
  ];
  @override
  Widget build(BuildContext context) {
    final foods = widget.repository.searchFoods(_query, category: _category);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a food'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              FoodSearchBar(
                onChanged: (value) => setState(() => _query = value),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (_, index) => ChoiceChip(
                    label: Text(categories[index]),
                    selected: _category == categories[index],
                    onSelected: (_) =>
                        setState(() => _category = categories[index]),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (_, index) => FoodItemCard(
                    food: foods[index],
                    onTap: () => Navigator.pop(context, foods[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
