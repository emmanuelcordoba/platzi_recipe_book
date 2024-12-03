class Recipe {
  String name;
  String author;
  String imageLink;
  List<String> steps;

  Recipe({
    required this.name,
    required this.author,
    required this.imageLink,
    required this.steps,
  });

  factory Recipe.toJson( Map<String, dynamic> json){
    return Recipe(
      name: json['name'],
      author: json['author'],
      imageLink: json['image_link'],
      steps: List<String>.from(json['recipe']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'author': author,
      'image_link': imageLink,
      'recipe': steps, 
    };
  }

  @override
  String toString() {
    return 'Recipe{name: $name, author: $author, imageLink: $imageLink, steps: $steps}';
  }
}