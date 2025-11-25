import 'package:flutter/material.dart';
import '../models/meal_detiil.dart';
import '../services/api_service.dart';


class RandomMealScreen extends StatefulWidget {
  @override
  _RandomMealScreenState createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  MealDetail? meal;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRandom();
  }

  Future<void> fetchRandom() async {
    final data = await ApiService().fetchRandomMeal();
    setState(() {
      meal = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Meal"),
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
          ],
        ),
      ),
    );
  }
}
