import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_detiil.dart';

class FavoritesService {
  static const String _key = 'favorite_meals';
  final ValueNotifier<List<MealDetail>> favorites = ValueNotifier([]);

  FavoritesService._privateConstructor();
  static final FavoritesService _instance = FavoritesService._privateConstructor();
  factory FavoritesService() => _instance;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      try {
        final Map<String, dynamic> map = json.decode(raw);
        final list = map.values.map<MealDetail>((e) => MealDetail.fromJson(e)).toList();
        favorites.value = list;
      } catch (e) {
        favorites.value = [];
      }
    } else {
      favorites.value = [];
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> map = {
      for (var m in favorites.value) m.idMeal: m.toJson()
    };
    await prefs.setString(_key, json.encode(map));
  }

  bool isFavorite(String id) {
    return favorites.value.any((m) => m.idMeal == id);
  }

  Future<void> addFavorite(MealDetail meal) async {
    if (!isFavorite(meal.idMeal)) {
      favorites.value = [...favorites.value, meal];
      await _saveToPrefs();
    }
  }

  Future<void> removeFavorite(String id) async {
    favorites.value = favorites.value.where((m) => m.idMeal != id).toList();
    await _saveToPrefs();
  }

  Future<void> toggleFavorite(MealDetail meal) async {
    if (isFavorite(meal.idMeal)) {
      await removeFavorite(meal.idMeal);
    } else {
      await addFavorite(meal);
    }
  }
}
