class Baked {
  final String id;
  final BakedItem data;

  Baked({required this.id, required this.data});
}

class BakedItem {
  final String name;
  final String image;
  final String? description;
  final List<BakingIngredient> ingredients;
  final List<BakingStep> steps;
  final BakingPreparation preparation;

  BakedItem(
      {required this.name,
      required this.image,
      this.description,
      required this.ingredients,
      required this.steps,
      required this.preparation});

  factory BakedItem.fromJson(Map<String, dynamic> json) => BakedItem(
      name: json["name"],
      image: json["image"],
      description: json["description"],
      ingredients: json['ingredients'] != null
          ? (json['ingredients'] as List)
              .map((value) => BakingIngredient.fromJson(value))
              .toList()
          : [],
      steps: json['steps'] != null
          ? (json['steps'] as List)
              .map((value) => BakingStep.fromJson(value))
              .toList()
          : [],
      preparation: json['preparation'] != null
          ? BakingPreparation.fromJson(json['preparation'])
          : BakingPreparation());

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'description': description,
      };
}

class BakingPreparation {
  final String? restTime;
  final String? restTemperature;
  final String? cookingTime;
  final String? cookingTemperature;

  BakingPreparation(
      {this.restTime,
      this.restTemperature,
      this.cookingTime,
      this.cookingTemperature});

  factory BakingPreparation.fromJson(Map<String, dynamic> json) =>
      BakingPreparation(
        restTime: json['restTime'],
        restTemperature: json['restTemperature'],
        cookingTime: json['cookingTime'],
        cookingTemperature: json['cookingTemperature'],
      );

  Map<String, dynamic> toJson() => {
        'restTime': restTime,
        'restTemperature': restTemperature,
        'cookingTime': cookingTime,
        'cookingTemperature': cookingTemperature,
      };
}

class BakingStep {
  final int? id;
  late String step;
  final String? description;

  BakingStep({this.id, required this.step, this.description});

  factory BakingStep.fromJson(Map<String, dynamic> json) => BakingStep(
        step: json['step'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'step': step,
        'description': description,
      };
}

class BakingIngredient {
  final int? id;
  late String name;
  final String? amount;

  BakingIngredient({this.id, required this.name, this.amount});

  factory BakingIngredient.fromJson(Map<String, dynamic> json) =>
      BakingIngredient(
        name: json['name'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        // 'id': id,
        'amount': amount,
      };
}
