import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detiil.dart';


class ApiService {
  static const String _base = 'https://www.themealdb.com/api/json/v1/1';


  Future<List<Category>> fetchCategories() async {
    final res = await http.get(Uri.parse('$_base/categories.php'));
    if (res.statusCode != 200) throw Exception('Failed to load categories');
    final data = jsonDecode(res.body);
    final list = data['categories'] as List;
    return list.map((e) => Category.fromJson(e)).toList();
  }


  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final res = await http.get(Uri.parse('$_base/filter.php?c=\$category'.replaceAll('\$category', Uri.encodeQueryComponent(category))));
    if (res.statusCode != 200) throw Exception('Failed to load meals');
    final data = jsonDecode(res.body);
    final list = data['meals'] as List;
    return list.map((e) => Meal.fromFilterJson(e)).toList();
  }


  Future<List<Meal>> searchMeals(String query) async {
    final res = await http.get(Uri.parse('$_base/search.php?s=\$query'.replaceAll('\$query', Uri.encodeQueryComponent(query))));
    if (res.statusCode != 200) throw Exception('Failed to search meals');
    final data = jsonDecode(res.body);
    final list = data['meals'];
    if (list == null) return [];
    return (list as List).map((e) => Meal.fromLookupJson(e)).toList();
  }


  Future<Meal> lookupMealById(String id) async {
    final res = await http.get(Uri.parse('$_base/lookup.php?i=\$id'.replaceAll('\$id', id)));
    if (res.statusCode != 200) throw Exception('Failed to load meal');
    final data = jsonDecode(res.body);
    final list = data['meals'] as List;
    return Meal.fromLookupJson(list.first);
  }


  Future<MealDetail> fetchRandomMeal() async {
    final res = await http.get(Uri.parse('$_base/random.php'));
    if (res.statusCode != 200) throw Exception('Failed to load random meal');
    final data = jsonDecode(res.body);
    final list = data['meals'] as List;
    return MealDetail.fromJson(list.first);
  }

  Future<MealDetail> getMealDetail(String id) async {
    final response = await http.get(Uri.parse(
        '$_base/lookup.php?i=$id'));

    final data = json.decode(response.body);
    return MealDetail.fromJson(data["meals"][0]);
  }
}