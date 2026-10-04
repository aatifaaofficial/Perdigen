import 'package:flutter/material.dart';
import 'package:personal_diet_journal/data/mock_dashboard_data.dart';
import 'package:personal_diet_journal/data/mock_meal_repository.dart';
import 'package:personal_diet_journal/screens/home_screen.dart';
import 'package:personal_diet_journal/screens/meals/meals_page.dart';
import 'package:personal_diet_journal/theme/app_theme.dart';

void main() {
  runApp(const PersonalDietJournalApp());
}

class PersonalDietJournalApp extends StatelessWidget {
  const PersonalDietJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Diet Journal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _AppShell(),
    );
  }
}

class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  final _repository = MockMealRepository();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final page = _selectedIndex == 1
        ? MealsPage(repository: _repository, onNavigate: _navigate)
        : HomeScreen(
            data: mockDashboardData,
            currentNavIndex: _selectedIndex,
            onNavigate: _navigate,
          );

    return page;
  }

  void _navigate(int index) {
    if (index == 2) {
      _showQuickAdd();
      return;
    }
    if (index > 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This journal view is coming soon.')),
      );
      return;
    }
    setState(() => _selectedIndex = index);
  }

  void _showQuickAdd() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.restaurant_rounded),
              title: const Text('Add Meal'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 1);
              },
            ),
            const ListTile(
              leading: Icon(Icons.water_drop_rounded),
              title: Text('Log Water'),
            ),
            const ListTile(
              leading: Icon(Icons.mood_rounded),
              title: Text('Log Mood'),
            ),
          ],
        ),
      ),
    );
  }
}
