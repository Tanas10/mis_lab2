import 'package:flutter/material.dart';
import '../models/meal_detiil.dart';
import '../services/api_service.dart';


class MealDetailScreen extends StatefulWidget {
  final String mealId;

  MealDetailScreen({required this.mealId});

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  MealDetail? meal;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeal();
  }

  Future<void> fetchMeal() async {
    final data = await ApiService().getMealDetail(widget.mealId);
    setState(() {
      meal = data;
      isLoading = false;
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
            if (meal!.strYoutube != null && meal!.strYoutube!.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                },
                child: Text("Watch on YouTube"),
              ),
          ],
        ),
      ),
    );
  }
}
