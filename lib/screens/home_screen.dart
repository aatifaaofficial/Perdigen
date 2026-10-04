import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/dashboard_data.dart';
import 'package:personal_diet_journal/widgets/bottom_nav_bar.dart';
import 'package:personal_diet_journal/widgets/health_score_card.dart';
import 'package:personal_diet_journal/widgets/insight_card.dart';
import 'package:personal_diet_journal/widgets/meal_card.dart';
import 'package:personal_diet_journal/widgets/metric_card.dart';
import 'package:personal_diet_journal/widgets/nutrition_summary_card.dart';
import 'package:personal_diet_journal/widgets/quick_action_card.dart';
import 'package:personal_diet_journal/widgets/water_tracker_card.dart';
import 'package:personal_diet_journal/widgets/weekly_chart_card.dart';

class HomeScreen extends StatefulWidget {
  final DashboardData data;
  final int currentNavIndex;
  final ValueChanged<int>? onNavigate;

  const HomeScreen({
    super.key,
    required this.data,
    this.currentNavIndex = 0,
    this.onNavigate,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _waterConsumed;

  @override
  void initState() {
    super.initState();
    _waterConsumed = widget.data.waterConsumed;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FBF7),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCF9EA).withValues(alpha: 0.72),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF8F1).withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 110),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildTopBar(),
                    const SizedBox(height: 20),
                    HealthScoreCard(
                      score: widget.data.healthScore,
                      maxScore: widget.data.healthScoreMax,
                      message: widget.data.healthMessage,
                      motivational: widget.data.healthMotivational,
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Today\'s Overview',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17312B),
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 3 : 2,
                        childAspectRatio: isTablet ? 1.18 : 0.82,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: widget.data.metrics.length,
                      itemBuilder: (context, index) {
                        final metric = widget.data.metrics[index];
                        return MetricCard(
                          metric: metric,
                          onTap: () => _showMessage(
                            '${metric.title} details coming soon',
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 22),
                    NutritionSummaryCard(
                      nutrition: widget.data.nutritionBreakdown,
                      calories: widget.data.caloriesConsumed,
                      onViewDetails: () =>
                          _showMessage('Nutrition details coming soon'),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today\'s Meals',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF17312B),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => _showMessage('Add Meal opened'),
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: const Text('Add Meal'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 170,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.data.meals.length + 1,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          if (index == widget.data.meals.length) {
                            return Container(
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: const Color(0xFFEAF8F1),
                                border: Border.all(
                                  color: const Color(0xFFBCE8D2),
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(22),
                                onTap: () {},
                                child: const Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add_circle_rounded,
                                        size: 34,
                                        color: Color(0xFF1C9B60),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '+ Add Meal',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF1C9B60),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          final meal = widget.data.meals[index];
                          return MealCard(
                            meal: meal,
                            onTap: () => _showMessage(
                              '${meal.mealType} details coming soon',
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                    WaterTrackerCard(
                      consumed: _waterConsumed,
                      goal: widget.data.waterTarget,
                      onAdd: _addWater,
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17312B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 3 : 2,
                        childAspectRatio: isTablet ? 1.35 : 1.05,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: widget.data.quickActions.length,
                      itemBuilder: (context, index) {
                        final action = widget.data.quickActions[index];
                        return QuickActionCard(
                          action: action,
                          onTap: () => _handleQuickAction(action.label),
                        );
                      },
                    ),
                    const SizedBox(height: 22),
                    InsightCard(
                      insights: widget.data.insights,
                      onViewInsights: () =>
                          _showMessage('Insights coming soon'),
                    ),
                    const SizedBox(height: 22),
                    WeeklyChartCard(
                      calories: widget.data.weeklyCalories,
                      water: widget.data.weeklyWater,
                      sleep: widget.data.weeklySleep,
                      weight: widget.data.weeklyWeight,
                      mood: widget.data.weeklyMood,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: widget.currentNavIndex,
        onTap: (value) {
          if (widget.onNavigate != null) {
            widget.onNavigate!(value);
            return;
          }
          if (value == 2) {
            _showQuickAddMenu();
          } else {
            return;
          }
        },
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Diet Journal',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1C9B60),
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${widget.data.greeting}, ${widget.data.userName} 👋',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF17312B),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Track Today. Analyze Tomorrow. Live Better Every Day.',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8A9A94),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Let\'s make today a healthy day!',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6F837D),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: Color(0xFF23483F),
                  ),
                  Positioned(
                    top: 9,
                    right: 9,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6B5C),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF94E2A8), Color(0xFF3DBF7A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8FE5AF).withValues(alpha: 0.5),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addWater() {
    if (_waterConsumed >= widget.data.waterTarget) return;
    setState(() => _waterConsumed++);
  }

  void _handleQuickAction(String label) {
    if (label == 'Log Water') {
      _addWater();
      return;
    }
    _showMessage('$label opened');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void _showQuickAddMenu() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 20),
          child: Wrap(
            runSpacing: 8,
            children: widget.data.quickActions
                .map(
                  (action) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: action.color.withValues(alpha: 0.14),
                      child: Icon(action.icon, color: action.color),
                    ),
                    title: Text(
                      action.label,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _handleQuickAction(action.label);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
