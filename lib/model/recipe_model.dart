// recipe class
class Recipe {
  final String spoonacularSourceUrl;

  Recipe({required this.spoonacularSourceUrl,});

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      spoonacularSourceUrl: map['spoonacularSourceUrl']
    );
  }
}