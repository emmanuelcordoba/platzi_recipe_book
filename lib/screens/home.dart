import 'package:flutter/material.dart';
import 'package:platzi_recipe_book/providers/recipe.dart';
import 'package:platzi_recipe_book/screens/recipe_detail.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  

  @override
  Widget build(BuildContext context) {

    final recipesProvider = Provider.of<RecipeProvider>(context, listen: false);
    recipesProvider.fetchRecipes();

    return Scaffold(
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if(provider.isLoading){
            return const Center(child: CircularProgressIndicator());
          } else if (provider.recipes.isEmpty) {
            return const Center(child: Text('No hay recetas.'),);
          } else {
              return ListView.builder(
                itemCount: provider.recipes.length,
                itemBuilder: (context, index){
                  return _RecipesCard(context, provider.recipes[index]);
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
        Navigator.push(context, MaterialPageRoute(builder: (builder) => RecipeDetail(recipeName: recipe.name)));
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
                        child: Image.network(recipe.imageLink, 
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
                      recipe.name,
                      style: const TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
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
                    Text('By ${recipe.author}',
                        style: const TextStyle(fontSize: 14, fontFamily: 'Quicksand')),
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
