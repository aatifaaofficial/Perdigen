import 'package:flutter/material.dart';

class MetricGoal {
  final String title;
  final String value;
  final String subtitle;
  final double current;
  final double goal;
  final String unit;
  final Color color;
  final IconData icon;
  final bool isMood;
  final bool showTrend;
  final String trendLabel;

  const MetricGoal({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.current,
    required this.goal,
    required this.unit,
    required this.color,
    required this.icon,
    this.isMood = false,
    this.showTrend = false,
    this.trendLabel = '',
  });
}

class NutritionBreakdown {
  final double carbohydrates;
  final double protein;
  final double fat;
  final double fiber;

  const NutritionBreakdown({
    required this.carbohydrates,
    required this.protein,
    required this.fat,
    required this.fiber,
  });
}

class MealEntry {
  final String name;
  final String mealType;
  final String portion;
  final String calories;
  final String emoji;
  final Color accent;

  const MealEntry({
    required this.name,
    required this.mealType,
    required this.portion,
    required this.calories,
    required this.emoji,
    required this.accent,
  });
}

class QuickAction {
  final String label;
  final IconData icon;
  final Color color;

  const QuickAction({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class Insight {
  final String title;
  final String detail;
  final IconData icon;

  const Insight({
    required this.title,
    required this.detail,
    required this.icon,
  });
}

class WeeklyStat {
  final String day;
  final double value;
  final Color color;

  const WeeklyStat({
    required this.day,
    required this.value,
    required this.color,
  });
}

class DashboardData {
  final String greeting;
  final String subtitle;
  final String userName;
  final double healthScore;
  final int healthScoreMax;
  final String healthMessage;
  final String healthMotivational;
  final List<MetricGoal> metrics;
  final int calorieTarget;
  final int caloriesConsumed;
  final int waterTarget;
  final int waterConsumed;
  final double sleepTarget;
  final double sleepDuration;
  final String moodLabel;
  final double moodValue;
  final int exerciseMinutes;
  final int exerciseTarget;
  final double currentWeight;
  final NutritionBreakdown nutritionBreakdown;
  final List<MealEntry> meals;
  final List<QuickAction> quickActions;
  final List<Insight> insights;
  final List<WeeklyStat> weeklyCalories;
  final List<WeeklyStat> weeklyWater;
  final List<WeeklyStat> weeklySleep;
  final List<WeeklyStat> weeklyWeight;
  final List<WeeklyStat> weeklyMood;

  const DashboardData({
    required this.greeting,
    required this.subtitle,
    required this.userName,
    required this.healthScore,
    required this.healthScoreMax,
    required this.healthMessage,
    required this.healthMotivational,
    required this.metrics,
    required this.calorieTarget,
    required this.caloriesConsumed,
    required this.waterTarget,
    required this.waterConsumed,
    required this.sleepTarget,
    required this.sleepDuration,
    required this.moodLabel,
    required this.moodValue,
    required this.exerciseMinutes,
    required this.exerciseTarget,
    required this.currentWeight,
    required this.nutritionBreakdown,
    required this.meals,
    required this.quickActions,
    required this.insights,
    required this.weeklyCalories,
    required this.weeklyWater,
    required this.weeklySleep,
    required this.weeklyWeight,
    required this.weeklyMood,
  });
}
