import 'package:flutter/material.dart';
import 'package:lab2/screens/favorites_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/random_meal_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(MealApp());
}

class MealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meals App",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),


      home: CategoriesScreen(),


      routes: {
        '/randomMeal': (context) => RandomMealScreen(),
        '/favorites': (context) => FavoritesScreen(),
      },



      onGenerateRoute: (settings) {
        if (settings.name == '/mealDetail') {
          final mealId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => MealDetailScreen(mealId: mealId),
          );
        }

        if (settings.name == '/mealsByCategory') {
          final category = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => MealsScreen(category: category),
          );
        }

        return null;
      },
    );
  }
}
