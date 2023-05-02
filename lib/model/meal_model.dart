

class Meal {
  final int id;
  final String title, imgURL;

  Meal({
    this.id,
    this.title,
    this.imgURL,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      imgURL: map['image'] != null
          ? 'https://spoonacular.com/recipeImages/' + map['image']
          : 'default_image_url', // replace 'default_image_url' with the URL of a placeholder image
    );
  }
}
