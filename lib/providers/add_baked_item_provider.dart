import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:food_recipe/index.dart';

class AddBakedItemProvider with ChangeNotifier {
  late File imageFile;
  String? downloadURL;

  pickMealImage(image) {
    imageFile = image;
    notifyListeners();
  }

  Future uploadImageToFirebase(
      {required BuildContext context,
      name,
      description,
      restTime,
      restTemperature,
      cookingTime,
      cookingTemperature,
      ingredients,
      steps}) async {
    try {
      String fileName = basename(imageFile.path);
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putFile(imageFile)
          .then((p0) async {
        downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('uploads/$fileName')
            .getDownloadURL();

        BakedItem mealItem = BakedItem(
            name: name,
            image: downloadURL!,
            ingredients: ingredients,
            description: description,
            steps: steps,
            preparation: BakingPreparation(
                restTime: restTime,
                restTemperature: restTemperature,
                cookingTime: cookingTime,
                cookingTemperature: cookingTemperature));
        saveMealItem(mealItem);

        print(downloadURL);
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> saveMealItem(BakedItem item) {
    CollectionReference meal = FirebaseFirestore.instance.collection('meal');
    List ingredientsList = [];
    List stepList = [];

    for (BakingStep step in item.steps) {
      stepList.add({"step": step.step});
    }

    for (BakingIngredient ing in item.ingredients) {
      ingredientsList.add({"name": ing.name});
    }

    var preparation = {
      'restTime': item.preparation.restTime,
      'restTemperature': item.preparation.restTemperature,
      'cookingTime': item.preparation.cookingTime,
      'cookingTemperature': item.preparation.cookingTemperature,
    };

    return meal
        .add({
          'name': item.name,
          'image': item.image,
          'description': item.description,
          'ingredients': ingredientsList,
          'steps': stepList,
          'preparation': preparation,
        })
        .then((value) => print("Baked Item Added"))
        .catchError((error) => print("Failed to add Baked Item: $error"));
  }
}
