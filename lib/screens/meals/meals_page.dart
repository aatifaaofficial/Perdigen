import 'package:flutter/material.dart';
import 'package:personal_diet_journal/data/meal_repository.dart';
import 'package:personal_diet_journal/models/meal.dart';
import 'package:personal_diet_journal/widgets/bottom_nav_bar.dart';
import 'package:personal_diet_journal/widgets/meals/date_selector.dart';
import 'package:personal_diet_journal/widgets/meals/daily_nutrition_card.dart';
import 'package:personal_diet_journal/widgets/meals/empty_meals_state.dart';
import 'package:personal_diet_journal/widgets/meals/meal_section.dart';
import 'package:personal_diet_journal/widgets/meals/meals_header.dart';
import 'package:personal_diet_journal/screens/meals/add_meal_page.dart';
import 'package:personal_diet_journal/screens/meals/meal_details_page.dart';

class MealsPage extends StatefulWidget {
  final MealRepository repository;
  final ValueChanged<int>? onNavigate;
  const MealsPage({super.key, required this.repository, this.onNavigate});
  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(2026, 9, 20);
  }

  @override
  Widget build(BuildContext context) {
    final meals = widget.repository.getMeals(_selectedDate);
    final totalCalories = meals.fold<double>(
      0,
      (sum, meal) => sum + meal.totalCalories,
    );
    final totalProtein = meals.fold<double>(
      0,
      (sum, meal) => sum + meal.totalProtein,
    );
    final totalCarbs = meals.fold<double>(
      0,
      (sum, meal) => sum + meal.totalCarbohydrates,
    );
    final totalFat = meals.fold<double>(0, (sum, meal) => sum + meal.totalFat);
    final totalFiber = meals.fold<double>(
      0,
      (sum, meal) => sum + meal.totalFiber,
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBF7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MealsHeader(onSearch: _addMeal),
              const SizedBox(height: 12),
              DateSelector(
                selectedDate: _selectedDate,
                onChanged: (date) => setState(() => _selectedDate = date),
              ),
              const SizedBox(height: 10),
              NutritionSummary(
                calories: totalCalories,
                target: 2000,
                protein: totalProtein,
                carbs: totalCarbs,
                fat: totalFat,
                fiber: totalFiber,
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  const Text(
                    "Today's Meals",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17312B),
                    ),
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: _addMeal,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Add Meal'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (meals.isEmpty)
                EmptyMealsState(onAdd: _addMeal)
              else
                ...['Breakfast', 'Lunch', 'Dinner', 'Snack'].map(
                  (type) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: MealSection(
                      type: type,
                      meals: meals.where((meal) => meal.type == type).toList(),
                      onTap: _openDetails,
                      onEdit: _editMeal,
                      onDelete: _deleteMeal,
                      onAdd: () => _addMeal(type: type),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (value) => widget.onNavigate?.call(value),
      ),
    );
  }

  Future<void> _addMeal({String type = 'Breakfast'}) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => AddMealPage(
          repository: widget.repository,
          date: _selectedDate,
          initialType: type,
        ),
      ),
    );
    if (saved == true && mounted) setState(() {});
  }

  Future<void> _editMeal(Meal meal) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => AddMealPage(
          repository: widget.repository,
          date: meal.date,
          initialMeal: meal,
        ),
      ),
    );
    if (saved == true && mounted) setState(() {});
  }

  Future<void> _openDetails(Meal meal) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            MealDetailsPage(meal: meal, repository: widget.repository),
      ),
    );
    if (changed == true && mounted) setState(() {});
  }

  Future<void> _deleteMeal(Meal meal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Meal?'),
        content: const Text(
          "Are you sure you want to remove this meal from today's journal?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await widget.repository.deleteMeal(meal.id);
      if (mounted) setState(() {});
    }
  }
}
