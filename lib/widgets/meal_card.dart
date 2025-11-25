import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/meal.dart';


class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  const MealCard({Key? key, required this.meal, required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: meal.strMealThumb,
                fit: BoxFit.cover,
                placeholder: (_, __) => Center(child: CircularProgressIndicator()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(meal.strMeal, maxLines: 2, overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    );
  }
}