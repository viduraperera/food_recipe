import 'package:food_recipe/index.dart';

class DessertItem {
  final String? id;
  final String dessertName;
  final String dessertImage;
  final String subTitle;
  final String? description;
  final List<IngredientItem> ingredients;
  final List<RecipeStep> steps;
  final Preparation preparation;

  DessertItem(
      {this.id,
      required this.dessertName,
      required this.dessertImage,
      required this.subTitle,
      this.description,
      required this.ingredients,
      required this.steps,
      required this.preparation});

  factory DessertItem.fromJson(Map<String, dynamic> json) => DessertItem(
      dessertName: json["name"],
      dessertImage: json["image"],
      subTitle: json["subTitle"],
      ingredients: json['ingredients'] != null
          ? (json['ingredients'] as List)
              .map((value) => IngredientItem.fromJson(value))
              .toList()
          : [],
      steps: json['steps'] != null
          ? (json['steps'] as List)
              .map((value) => RecipeStep.fromJson(value))
              .toList()
          : [],
      preparation: json['preparation'] != null
          ? Preparation.fromJson(json['preparation'])
          : Preparation());

  Map<String, dynamic> toJson() => {
        'name': dessertName,
        'image': dessertImage,
        'subTitle': subTitle,
        'description': description,
      };
}

// class Preparation {
//   final String? temp;
//   final String? prepTime;

//   Preparation(
//       { this.temp,
//         this.prepTime});

//   factory Preparation.fromJson(Map<String, dynamic> json) =>
//       Preparation(
//         temp: json['temp'],
//         prepTime: json['prepTime'],
//       );

//   Map<String, dynamic> toJson() => {
//     'temp': temp,
//     'prepTime': prepTime,
//   };
// }

// class RecipeStep {
//   // final int id;
//   final String step;
//   final String description;

//   RecipeStep({
//     // required this.id,
//     required this.step, required this.description});

//   factory RecipeStep.fromJson(Map<String, dynamic> json) =>
//       RecipeStep(
//         // id: json['id'],
//         step: json['step'],
//         description: json['description'],
//       );

//   Map<String, dynamic> toJson() => {
//     // 'id': id,
//     'step': step,
//     'description': description,
//   };
// }

// class IngredientItem {
//   // final int id;
//   final String name;
//   final String amount;

//   IngredientItem({
//     // required this.id,
//     required this.name, required this.amount});

//   factory IngredientItem.fromJson(Map<String, dynamic> json) =>
//       IngredientItem(
//         name: json['name'],
//         // id: json['id'],
//         amount: json['amount'],

//       );

//   Map<String, dynamic> toJson() => {
//     'name': name,
//     // 'id': id,
//     'amount': amount,
//   };
// }
