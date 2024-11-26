import 'package:flutter/material.dart';

void main() { runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hola Mundo', 
      home: RecipeBook(),
      debugShowCheckedModeBanner: false
      ) ;
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Libro de Recetas',
          style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.orange,
      ),);
  }
}