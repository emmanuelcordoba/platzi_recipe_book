import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/models/recipe.dart';
import 'package:platzi_recipe_book/providers/recipe.dart';
import 'package:provider/provider.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipeData;
  const RecipeDetail({
    super.key,
    required this.recipeData
    });

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipeProvider>(context, listen: false)
      .favorites
      .contains(widget.recipeData);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeData.name, style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.orange,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            icon: Icon(Icons.arrow_back, color: Colors.white,
          )
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<RecipeProvider>(context, listen: false).toggleFavoriteStatus(widget.recipeData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

