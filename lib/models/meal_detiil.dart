class MealDetail {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String strInstructions;
  final String? strYoutube;


  final Map<int, String> ingredients;
  final Map<int, String> measures;

  MealDetail({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strInstructions,
    required this.strYoutube,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    Map<int, String> ingredients = {};
    Map<int, String> measures = {};


    for (int i = 1; i <= 20; i++) {
      final ingredient = json["strIngredient$i"];
      final measure = json["strMeasure$i"];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          ingredient != "") {
        ingredients[i] = ingredient.toString();
      }

      if (measure != null &&
          measure.toString().trim().isNotEmpty &&
          measure != "") {
        measures[i] = measure.toString();
      }
    }

    return MealDetail(
      idMeal: json["idMeal"],
      strMeal: json["strMeal"],
      strMealThumb: json["strMealThumb"],
      strInstructions: json["strInstructions"],
      strYoutube: json["strYoutube"],
      ingredients: ingredients,
      measures: measures,
    );
  }
}
