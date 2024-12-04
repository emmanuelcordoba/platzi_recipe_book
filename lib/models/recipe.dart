class Recipe {
  int id;
  String name;
  String author;
  String imageLink;
  List<String> steps;

  Recipe({
    required this.id,
    required this.name,
    required this.author,
    required this.imageLink,
    required this.steps,
  });

  factory Recipe.toJson( Map<String, dynamic> json){
    return Recipe(
      id: json['id'],
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
    return 'Recipe{id: $id, name: $name, author: $author, imageLink: $imageLink, steps: $steps}';
  }
}