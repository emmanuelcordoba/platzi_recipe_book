import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/screens/recipe_detail.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> FetchRecipes() async {
    // localhost para Android: 10.0.2.2
    // localhost para iOS: 127.0.0.1
    final url = Uri.parse('http://localhost:3001/recipes');
    try {
      final response = await http.get(url);
      if(response.statusCode == 200)
      {
        final data = jsonDecode(response.body);
        return data['recipes'];
      } else {
        print('Error ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error in request');
      return [];
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: FetchRecipes(), 
        builder: (context, snapshop) {
          final recipes = snapshop.data ?? [];
          if(snapshop.connectionState == ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator(),);
          } else if(!snapshop.hasData || snapshop.data!.isEmpty) {
            return const Center(child: Text('No hay recetas.'),);
          } else {
            return ListView.builder(
                itemCount: recipes!.length,
                itemBuilder: (context, index){
                  return _RecipesCard(context, recipes[index]);
              }
            );
          }
          
        }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {    
    return showModalBottomSheet(      
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
        child: Container( 
          height: 500,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: const RecipeForm(),
        ),        
      ),    
    );  
  }

  Widget _RecipesCard(BuildContext context, dynamic recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (builder) => RecipeDetail(recipeName: recipe['name'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                    height: 125,
                    width: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(recipe['image_link'], 
                          fit: BoxFit.cover
                        )
                      )
                    ),
                SizedBox(
                  width: 26,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['name'],
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 2,
                      width: 150,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(recipe['author'],
                        style: TextStyle(fontSize: 14, fontFamily: 'Quicksand')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeImg = TextEditingController();
    final TextEditingController _recipeDescription = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nueva Receta', 
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24
            ),),
            SizedBox(height: 8),
            _buildTextField(
              label: 'Nombre',
              controller: _recipeName , 
              validador: (value) {
                if(value == null || value.isEmpty){
                  return 'Por favor ingrese el nombre de la receta';
                }
                return null;
              }
            ),
            SizedBox(height: 8),
            _buildTextField(
              label: 'Autor',
              controller: _recipeAuthor,               
              validador: (value) {
                if(value == null || value.isEmpty){
                  return 'Por favor ingrese el autor de la receta';
                }
                return null;
              }
            ),
            SizedBox(height: 8),
            _buildTextField(
              label: 'URL Imagen',
              controller: _recipeImg,
              validador: (value) {
                if(value == null || value.isEmpty){
                  return 'Por favor ingrese la URL de la Imagen de la receta';
                }
                return null;
              }
            ),
            SizedBox(height: 8),
            _buildTextField(
              label: 'Receta',
              controller: _recipeDescription, 
              maxLines: 3,              
              validador: (value) {
                if(value == null || value.isEmpty){
                  return 'Por favor ingrese la descripción de la receta';
                }
                return null;
              }
            ),
            SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Text('Guardar', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
            )
          ],
        ),),
    );
  }

  Widget _buildTextField({
      required String label, 
      required TextEditingController controller, 
      required String? Function(String?) validador,
      int maxLines = 1
    }) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.orange
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10)
        )
      ),
      validator: validador      
    );
  }  
}
