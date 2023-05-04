// meal model screen
import 'meal_model.dart';

class MealPlan {
  final List<Meal> meals;
  final double calories, carbs, fat, protein;

  MealPlan({
    required this.meals,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  factory MealPlan.fromMap(Map<String, dynamic> map) {
    List<Meal> meals = [];
    if (map['meals'] != null) {
      map['meals'].forEach((mealMap) => meals.add(Meal.fromMap(mealMap)));
    }

    return MealPlan(
      meals: meals,
      calories: map['nutrients']['calories'] ?? 0.0,
      carbs: map['nutrients']['carbohydrates'] ?? 0.0,
      fat: map['nutrients']['fat'] ?? 0.0,
      protein: map['nutrients']['protein'] ?? 0.0,
    );
  }
}