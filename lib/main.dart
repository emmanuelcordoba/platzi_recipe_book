import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Libro de Recetas',
        home: RecipeBook(),
        debugShowCheckedModeBanner: false);
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
