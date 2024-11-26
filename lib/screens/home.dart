import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_RecipesCard(context), _RecipesCard(context)],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext context){
    return showModalBottomSheet(
      context: context, 
      builder: (context) => Container(
        height: 500,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: RecipeForm(),
      ));
  }

  Widget _RecipesCard(BuildContext context) {
    return Padding(
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
                      child: Image(
                        image: AssetImage('assets/images/Perfil-LinkedIn-E.jpg'),
                        fit: BoxFit.fitHeight,
                      ))),
              SizedBox(
                width: 26,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Milanesa Napolitana',
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
                  Text('Emmanuel Córdoba',
                      style: TextStyle(fontSize: 14, fontFamily: 'Quicksand')),
                ],
              )
            ],
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        //key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nueva Receta', 
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24
            ),),
            SizedBox(height: 16),
            _buildTextField(label: 'Nombre'),
            SizedBox(height: 16),
            _buildTextField(label: 'Autor'),
            SizedBox(height: 16),
            _buildTextField(label: 'URL Imagen'),
            SizedBox(height: 16),
            _buildTextAreaField(label: 'Receta'),
          ],
        ),),
    );
  }

  Widget _buildTextField({required String label}) {
    return TextFormField(
      decoration: InputDecoration(
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
    );
  }

  Widget _buildTextAreaField({required String label}) {
    return TextField(
      minLines: 4,
      maxLines: 4,
      keyboardType: TextInputType.multiline,
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
    );
  }
}
