

class Meal {
  final int id;
  final String title, imgURL;

  Meal({
    required this.id,
    required this.title,
    required this.imgURL,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      imgURL: map['image'] != null
          ? 'https://spoonacular.com/recipeImages/' + map['image']
          : 'default_image_url',
    );
  }
}
