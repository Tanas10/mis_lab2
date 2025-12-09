import 'package:flutter/material.dart';
import '../models/meal_detiil.dart';
import '../services/api_service.dart';
import 'favorites_service.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  MealDetailScreen({required this.mealId});

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  MealDetail? meal;
  bool isLoading = true;
  final FavoritesService favSvc = FavoritesService();
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    fetchMeal();
  }

  Future<void> fetchMeal() async {
    final data = await ApiService().getMealDetail(widget.mealId);
    setState(() {
      meal = data;
      isFav = favSvc.isFavorite(meal!.idMeal);
      isLoading = false;
    });
  }

  Future<void> _toggleFavorite() async {
    if (meal == null) return;
    await favSvc.toggleFavorite(meal!);
    setState(() {
      isFav = favSvc.isFavorite(meal!.idMeal);
    });
  }

  List<String> getIngredients(MealDetail meal) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = meal.ingredients[i];
      final measure = meal.measures[i];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add("$ingredient - ${measure ?? ''}");
      }
    }
    return ingredients;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal?.strMeal ?? "Loading..."),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal!.strMealThumb),
            SizedBox(height: 12),
            Text(
              meal!.strMeal,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Instructions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(meal!.strInstructions),
            SizedBox(height: 20),
            Text(
              "Ingredients",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...getIngredients(meal!).map((text) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text("• $text"),
            )),
            SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (meal!.strYoutube != null && meal!.strYoutube!.isNotEmpty)
                  ElevatedButton.icon(
                    icon: Icon(Icons.video_library),
                    label: Text("Watch on YouTube"),
                    onPressed: () => {},
                  ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                  label: Text(isFav ? "Favorited" : "Favorite"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFav ? Colors.green : Colors.grey,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
