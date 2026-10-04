import 'package:flutter/material.dart';
import 'package:personal_diet_journal/data/meal_repository.dart';
import 'package:personal_diet_journal/models/food_item.dart';
import 'package:personal_diet_journal/models/meal.dart';
import 'package:personal_diet_journal/widgets/meals/portion_selector.dart';
import 'food_selection_page.dart';

class AddMealPage extends StatefulWidget {
  final MealRepository repository;
  final DateTime date;
  final Meal? initialMeal;
  final String initialType;

  const AddMealPage({
    super.key,
    required this.repository,
    required this.date,
    this.initialMeal,
    this.initialType = 'Breakfast',
  });

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  late String _type;
  late List<MealFood> _foods;
  bool _saving = false;
  static const types = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  @override
  void initState() {
    super.initState();
    _type = widget.initialMeal?.type ?? widget.initialType;
    _foods = List.of(widget.initialMeal?.foods ?? const []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialMeal == null ? 'Add a Meal' : 'Edit Meal'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Meal type',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF17312B),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: types
                    .map(
                      (type) => ChoiceChip(
                        label: Text(type),
                        selected: _type == type,
                        onSelected: (_) => setState(() => _type = type),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Foods in this meal',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17312B),
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _addFood,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add food'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _foods.isEmpty
                    ? const Center(
                        child: Text(
                          'Start with a food from your journal database.',
                          style: TextStyle(color: Color(0xFF71837D)),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _foods.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (_, index) => _foodTile(index),
                      ),
              ),
              _Summary(foods: _foods),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _foods.isEmpty || _saving ? null : _save,
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check_rounded),
                  label: Text(
                    widget.initialMeal == null ? 'Save Meal' : 'Update Meal',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _foodTile(int index) {
    final item = _foods[index];
    return ListTile(
      tileColor: const Color(0xFFF4F9F6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Text(
        item.food.image ?? '🥗',
        style: const TextStyle(fontSize: 28),
      ),
      title: Text(
        item.food.name,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        '${item.quantity} serving · ${(item.food.calories * item.quantity).round()} kcal',
      ),
      trailing: IconButton(
        onPressed: () => setState(() => _foods.removeAt(index)),
        icon: const Icon(
          Icons.delete_outline_rounded,
          color: Color(0xFFE26D5A),
        ),
      ),
    );
  }

  Future<void> _addFood() async {
    final food = await Navigator.push<FoodItem>(
      context,
      MaterialPageRoute(
        builder: (_) => FoodSelectionPage(repository: widget.repository),
      ),
    );
    if (!mounted || food == null) return;
    final quantity = await showDialog<double>(
      context: context,
      builder: (_) => PortionSelector(food: food),
    );
    if (quantity != null) {
      setState(() => _foods.add(MealFood(food: food, quantity: quantity)));
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final meal = Meal(
      id:
          widget.initialMeal?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      type: _type,
      date: widget.date,
      foods: List.unmodifiable(_foods),
    );
    if (widget.initialMeal == null) {
      await widget.repository.addMeal(meal);
    } else {
      await widget.repository.updateMeal(meal);
    }
    if (mounted) Navigator.pop(context, true);
  }
}

class _Summary extends StatelessWidget {
  final List<MealFood> foods;
  const _Summary({required this.foods});
  @override
  Widget build(BuildContext context) {
    final calories = foods.fold<double>(
      0,
      (sum, item) => sum + item.food.calories * item.quantity,
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '${calories.round()} kcal total  ·  ${foods.length} food${foods.length == 1 ? '' : 's'}',
        style: const TextStyle(
          color: Color(0xFF1C9B60),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
