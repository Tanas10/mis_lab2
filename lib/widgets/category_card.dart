import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/category.dart';


class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  const CategoryCard({Key? key, required this.category, required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: category.strCategoryThumb,
                fit: BoxFit.cover,
                placeholder: (_, __) => Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.strCategory, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(
                    category.strCategoryDescription.length > 80 ? category.strCategoryDescription.substring(0,80) + '...' : category.strCategoryDescription,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}