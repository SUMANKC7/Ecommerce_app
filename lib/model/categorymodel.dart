import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String imagePath;
  final String slug;
 final  Color? color;

  CategoryModel( 
      {required this.name, required this.imagePath, required this.slug,  this.color});
}
