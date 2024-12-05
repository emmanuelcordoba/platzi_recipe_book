import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/models/recipe.dart';
import 'package:platzi_recipe_book/providers/recipe.dart';
import 'package:platzi_recipe_book/screens/recipe_detail.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipeProvider>(
        builder: (context, recipeProvider, child) {
          final favorites = recipeProvider.favorites;
          if(favorites.isEmpty)
          {
            return Center(child: Text('No hay favoritos'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final recipe = favorites[index];
              return FavoriteRecipeCard(recipe: recipe);
            });
        },
      ),
    );
  }
}

class FavoriteRecipeCard extends StatelessWidget {

  final Recipe recipe;
  const FavoriteRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => RecipeDetail(recipeData: recipe)
        ));
      },
      child: Card(
        color: Colors.white,
        child: Column(children: [
          Text(recipe.name),
          Text(recipe.author)
        ],),
      ),
    );
  }
}