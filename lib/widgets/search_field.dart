import 'package:flutter/material.dart';


class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hint;
  const SearchField({Key? key, required this.onChanged, this.hint = 'Search'}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}