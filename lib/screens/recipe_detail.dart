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

class _RecipeDetailState extends State<RecipeDetail> with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn)
    )..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();    
  }

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
            icon: const Icon(Icons.arrow_back, color: Colors.white,
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
            icon: ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            //color: Colors.white,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(widget.recipeData.imageLink),
                  const SizedBox(height: 8),
                  Text(widget.recipeData.name, textAlign: TextAlign.center),
                  Text("by ${widget.recipeData.author}")
                ],
              ),
            ),            
            const SizedBox(height: 8),            
            const Text("Pasos:"),
            for(var step in widget.recipeData.steps) Text("- $step")
          ]
        ,),
      ),
    );
  }
}

