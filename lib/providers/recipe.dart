import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeProvider extends ChangeNotifier {

  bool isLoading = false;
  List<Recipe> recipes = [];
  List<Recipe> favorites = [];


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
      print('Error in request $e');
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
    
  }

  Future<void> toggleFavoriteStatus(Recipe recipe) async {
    final isFavorite = favorites.contains(recipe);
    final url = Uri.parse('http://localhost:3001/favorites');

    try {
      final response = isFavorite ? 
        await http.delete(url, body:  json.encode({"id": recipe.id}))
        : await http.post(url, body: json.encode({"id": recipe.id}));
      if(response.statusCode == 200)
      {
        if(isFavorite) {
          favorites.remove(recipe);
        } else {
          favorites.add(recipe);
        }
      } else {
        throw Exception('Failed to update favorite recipes');
      }
    } catch (e) {
      print('Error updating favorite status $e');
    }
  }
}