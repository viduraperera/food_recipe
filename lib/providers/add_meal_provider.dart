

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:food_recipe/index.dart';

class AddMealProvider with ChangeNotifier{
  late File imageFile;
  String? downloadURL;

  pickMealImage(image){
    imageFile = image;
    notifyListeners();
  }

  Future uploadImageToFirebase(
      {required BuildContext context,
        name,
        sub,
        des,
        temp,
        pre,
        cook,
        ing,
        stp}) async{
    try{
      String fileName = basename(imageFile.path);
      await firebase_storage.FirebaseStorage.instance
      .ref('uploads/$fileName')
      .putFile(imageFile)
      .then((p0) async{
        downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('uploads/$fileName')
            .getDownloadURL();

        MealItem mealItem = MealItem(
          name: name,
          image: downloadURL!,
          subTitle: sub,
          ingredients: ing,
          description: des,
          steps: stp,
          preparation:
            Preparation(temp: temp, cookingTime: cook, prepTime: pre));
        saveMealItem(mealItem);

        print(downloadURL);
      });
    } on FirebaseException catch (e){
      print(e);
    }
  }

  Future<void> saveMealItem(MealItem item){
    CollectionReference meal = FirebaseFirestore.instance.collection('meal');
    List ingList = [];
    List stpList = [];

    for(RecipeStep ing in item.steps){
      stpList.add({
        "step" : ing.step
      });
    }

    for(IngredientItem ing in item.ingredients){
      ingList.add({
        "name" : ing.name
      });
    }

    var preparation = {
      'cookingTime': item.preparation.cookingTime,
      'prepTime': item.preparation.prepTime,
      'temp': item.preparation.temp,
    };


    return meal
        .add({
      'name':item.name,
      'image':item.image,
      'subTitle': item.subTitle,
      'description' : item.description,
      'ingredients': ingList,
      'steps' : stpList,
      'preparation': preparation,

    })

        .then((value) => print("Meal Added"))
        .catchError((error) => print("Failed to add meal: $error"));
  }
}