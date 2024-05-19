// To parse this JSON data, do
//
//     final categoryModal = categoryModalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryModal categoryModalFromJson(String str) => CategoryModal.fromJson(json.decode(str));


class CategoryModal {
    List<Category> categories;

    CategoryModal({
        required this.categories,
    });

    factory CategoryModal.fromJson(Map<String, dynamic> json) => CategoryModal(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

  
}

class Category {
    String name;
    List<String> subcategories;

    Category({
        required this.name,
        required this.subcategories,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategories: List<String>.from(json["subcategories"].map((x) => x)),
    );

   
}
