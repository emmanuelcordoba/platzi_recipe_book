import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/models/recipe.dart';
import 'package:platzi_recipe_book/providers/recipe.dart';
import 'package:platzi_recipe_book/screens/recipe_detail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            return Center(child: Text(AppLocalizations.of(context)!.noRecipes));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final recipe = favorites[index];
                return FavoriteRecipeCard(recipe: recipe);
              }),
          );
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
      child: Semantics(
        label: 'Tarjeta de recetas',
        hint: 'Toca para ver dettale de la receta de ${recipe.name}',
        child: Card(
          color: Colors.white,
          child: Row(
              children: [
                SizedBox(
                  height: 125,
                  width: 125,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(recipe.imageLink, 
                      fit: BoxFit.cover
                    )
                  )
                ),
                const SizedBox(width: 14,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(recipe.name),
                  Text("by ${recipe.author}")
                ],),
              ],
            ),
        ),
      ),
    );
  }
}