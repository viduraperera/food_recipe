import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/index.dart';
import 'package:path/path.dart';

class UpdateBakeItemProvider with ChangeNotifier {
  late File imageFile;
  String? downloadURL;
  bool imageUpdated = false;

  pickMealImage(image) {
    imageFile = image;
    imageUpdated = true;
    notifyListeners();
  }

  Future updateImageToFirebase(
      {required BuildContext context,
      name,
      description,
      restTime,
      restTemperature,
      cookingTime,
      cookingTemperature,
      ingredients,
      steps,
      id,
      img}) async {
    try {
      if (imageUpdated) {
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
          saveMealItem(mealItem, id);
        });
      } else {
        try {
          BakedItem mealItem = BakedItem(
              name: name,
              image: img,
              ingredients: ingredients,
              description: description,
              steps: steps,
              preparation: BakingPreparation(
                  restTime: 'restTime',
                  restTemperature: restTemperature,
                  cookingTime: cookingTime,
                  cookingTemperature: cookingTemperature));
          log('here');
          inspect(mealItem);
          saveMealItem(mealItem, id);
        } catch (e) {
          print(e);
        }
      }
    } on FirebaseException catch (e) {
      print('update $e');
    }
  }

  Future<void> saveMealItem(BakedItem item, id) {
    CollectionReference bakedItem =
        FirebaseFirestore.instance.collection('baked');
    List ingredientsList = [];
    List stepList = [];

    for (BakingStep stp in item.steps) {
      stepList.add({"step": stp.step});
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

    return bakedItem
        .doc(id)
        .update({
          'name': item.name,
          'image': item.image,
          'description': item.description,
          'ingredients': ingredientsList,
          'steps': stepList,
          'preparation': preparation,
        })
        .then((value) => print("Meal Update"))
        .catchError((error) => print("Failed to Update meal: $error"));
  }
}
