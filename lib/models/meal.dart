class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strInstructions;
  final String? strYoutube;
  final Map<String, String> ingredients;


  Meal({required this.idMeal, required this.strMeal, required this.strMealThumb, this.strInstructions, this.strYoutube, required this.ingredients});



  factory Meal.fromFilterJson(Map<String, dynamic> j) => Meal(
    idMeal: j['idMeal'] ?? '',
    strMeal: j['strMeal'] ?? '',
    strMealThumb: j['strMealThumb'] ?? '',
    strInstructions: null,
    strYoutube: null,
    ingredients: {},
  );

  factory Meal.fromLookupJson(Map<String, dynamic> j) {
    final Map<String, String> ingr = {};
    for (var i = 1; i <= 20; i++) {
      final key = 'strIngredient\$i';
      final mKey = 'strMeasure\$i';
      final ingredient = j[key];
      final measure = j[mKey];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingr[ingredient.toString()] = (measure ?? '').toString();
      }
    }
    return Meal(
      idMeal: j['idMeal'] ?? '',
      strMeal: j['strMeal'] ?? '',
      strMealThumb: j['strMealThumb'] ?? '',
      strInstructions: j['strInstructions'],
      strYoutube: j['strYoutube'],
      ingredients: ingr,
    );
  }
}