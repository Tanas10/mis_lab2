import 'package:flutter/material.dart';
import '../models/meal_detiil.dart';

import 'favorites_service.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService favSvc = FavoritesService();

  @override
  void initState() {
    super.initState();
    favSvc.init().then((_) {
      setState(() {}); // ensure initial load
    });
    favSvc.favorites.addListener(_onFavChanged);
  }

  void _onFavChanged() => setState(() {});

  @override
  void dispose() {
    favSvc.favorites.removeListener(_onFavChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MealDetail> list = favSvc.favorites.value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Омилени рецепти'),
      ),
      body: list.isEmpty
          ? Center(child: Text('Немаш зачувано омилени рецепти.'))
          : GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.78,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: list.length,
        itemBuilder: (context, i) {
          final m = list[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MealDetailScreen(mealId: m.idMeal)),
            ),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Image.network(m.strMealThumb, fit: BoxFit.cover)),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(m.strMeal, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
