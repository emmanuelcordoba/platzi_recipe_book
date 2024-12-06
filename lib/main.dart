import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:platzi_recipe_book/providers/recipe.dart';
import 'package:platzi_recipe_book/screens/favorites.dart';
import 'package:platzi_recipe_book/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              title: 'Recipe Book',
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate
              ],
              supportedLocales: [
                Locale('en'),
                Locale('es')
              ],
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab( icon: Icon(Icons.home), text: 'Home', ),
                Tab( icon: Icon(Icons.favorite), text: 'Favoritos', )
              ]),
        ),
        body: const TabBarView(children: [
          HomeScreen(),
          FavoritesScreen()
        ]),
      ),
    );
  }
}
