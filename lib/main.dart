import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/providers/recipe.dart';
import 'package:platzi_recipe_book/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => RecipeProvider())
          ],
          child: const MaterialApp(
              title: 'Libro de Recetas',
              home: RecipeBook(),
              debugShowCheckedModeBanner: false),
        );
      }
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Libro de Recetas',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                )
              ]),
        ),
        body: TabBarView(children: [HomeScreen()]),
      ),
    );
  }
}
