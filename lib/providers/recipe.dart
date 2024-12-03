import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeProvider extends ChangeNotifier {

  bool isLoading = false;
  List<Recipe> recipes = [];


  Future<void> fetchRecipes() async {

    isLoading = true;
    notifyListeners();

    // localhost para Android: 10.0.2.2
    // localhost para iOS: 127.0.0.1
    final url = Uri.parse('http://localhost:3001/recipes');
    try {
      final response = await http.get(url);
      if(response.statusCode == 200)
      {
        final data = jsonDecode(response.body);
        recipes = List<Recipe>.from(data['recipes'].map(
          (recipe) => Recipe.toJson(recipe)
        ));
      } else {
        print('Error ${response.statusCode}');
        recipes = [];
      }
    } catch (e) {
      print('Error in request');
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
    
  } 
}