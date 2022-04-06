class Meal{
  final String id;
  final MealItem data;

  Meal({
    required this.id,
    required this.data
});
}


class MealItem{
  final String name;
  final String image;
  final String subTitle;
  final String? description;
  final List<IngredientItem> ingredients;
  final List<RecipeStep> steps;
  final Preparation preparation;

  MealItem({
    required this.name,
    required this.image,
    required this.subTitle,
    this.description,
    required this.ingredients,
    required this.steps,
    required this.preparation
});

  factory MealItem.fromJson(Map<String, dynamic> json) =>
      MealItem(
          name: json["name"],
          image: json["image"],
          subTitle: json["subTitle"],
          description: json["description"],
          ingredients: json['ingredients'] != null
          ? (json['ingredients'] as List)
          .map((value) =>  IngredientItem.fromJson(value))
          .toList()
          : [],
          steps: json['steps'] != null
              ? (json['steps'] as List)
              .map((value) =>  RecipeStep.fromJson(value))
              .toList()
              : [],
        preparation: json['preparation'] != null ? Preparation.fromJson(json['preparation']) : Preparation()
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'subTitle': subTitle,
    'description': description,
  };
}

class Preparation {
  final String? temp;
  final String? prepTime;
  final String? cookingTime;

  Preparation(
      { this.temp,
        this.prepTime,
        this.cookingTime});

  factory Preparation.fromJson(Map<String, dynamic> json) =>
      Preparation(
        temp: json['temp'],
        prepTime: json['prepTime'],
        cookingTime: json['cookingTime'],
      );

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'prepTime': prepTime,
    'cookingTime': cookingTime,
  };
}

class RecipeStep {
  final int? id;
  late String step;
  final String? description;

  RecipeStep({
     this.id,
    required this.step,  this.description});

  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      RecipeStep(
        step: json['step'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
    // 'id': id,
    'step': step,
    'description': description,
  };
}

class IngredientItem {
  final int? id;
  late String name;
  final String? amount;

  IngredientItem({
     this.id,
    required this.name,  this.amount});

  factory IngredientItem.fromJson(Map<String, dynamic> json) =>
      IngredientItem(
        name: json['name'],
        amount: json['amount'],

      );

  Map<String, dynamic> toJson() => {
    'name': name,
    // 'id': id,
    'amount': amount,
  };
}
