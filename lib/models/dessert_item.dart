class Dessert {
  final String id;
  final DessertItem data;

  Dessert({required this.id, required this.data});
}

class DessertItem {
  final String dessertName;
  final String dessertImage;
  final String subTitle;
  final String? description;
  final List<IngredientItemDessert> ingredients;
  final List<RecipeStepDessert> steps;
  final PreparationDessert preparation;

  DessertItem(
      {required this.dessertName,
      required this.dessertImage,
      required this.subTitle,
      this.description,
      required this.ingredients,
      required this.steps,
      required this.preparation});

  factory DessertItem.fromJson(Map<String, dynamic> json) => DessertItem(
      dessertName: json["dessertName"],
      dessertImage: json["dessertImage"],
      description: json["description"],
      subTitle: json["subTitle"],
      ingredients: json['ingredients'] != null
          ? (json['ingredients'] as List)
              .map((value) => IngredientItemDessert.fromJson(value))
              .toList()
          : [],
      steps: json['steps'] != null
          ? (json['steps'] as List)
              .map((value) => RecipeStepDessert.fromJson(value))
              .toList()
          : [],
      preparation: json['preparation'] != null
          ? PreparationDessert.fromJson(json['preparation'])
          : PreparationDessert());

  Map<String, dynamic> toJson() => {
        'dessertName': dessertName,
        'dessertImage': dessertImage,
        'subTitle': subTitle,
        'description': description,
      };
}

class PreparationDessert {
  final String? temp;
  final String? prepTime;

  PreparationDessert({this.temp, this.prepTime});

  factory PreparationDessert.fromJson(Map<String, dynamic> json) =>
      PreparationDessert(
        temp: json['temp'],
        prepTime: json['prepTime'],
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'prepTime': prepTime,
      };
}

class RecipeStepDessert {
  final int? id;
  late String step;
  final String? description;

  RecipeStepDessert({this.id, required this.step, this.description});

  factory RecipeStepDessert.fromJson(Map<String, dynamic> json) =>
      RecipeStepDessert(
        step: json['step'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'step': step,
        'description': description,
      };
}

class IngredientItemDessert {
  final int? id;
  late String name;
  final String? amount;

  IngredientItemDessert({this.id, required this.name, this.amount});

  factory IngredientItemDessert.fromJson(Map<String, dynamic> json) =>
      IngredientItemDessert(
        name: json['name'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
      };
}
