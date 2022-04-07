import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/index.dart';
import 'package:path/path.dart';

class UpdateDessertProvider with ChangeNotifier{
  late File imageFile;
  String? downloadURL;
  bool imageUpdated = false;

  pickMealImage(image){
    imageFile = image;
    imageUpdated = true;
    notifyListeners();
  }
  Future updateImageToFirebase(
      {required BuildContext context,
        name,
        sub,
        des,
        temp,
        pre,
        ing,
        stp,
        id,
        img
      }) async{
    try{
      if(imageUpdated){
        String fileName = basename(imageFile.path);
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/$fileName')
            .putFile(imageFile)
            .then((p0) async{
          downloadURL = await firebase_storage.FirebaseStorage.instance
              .ref('uploads/$fileName')
              .getDownloadURL();

          DessertItem dessertItem = DessertItem(
              name: name,
              image: downloadURL!,
              subTitle: sub,
              ingredients: ing,
              description: des,
              steps: stp,
              preparation:
              Preparation(temp: temp, prepTime: pre));
          saveDessertItem(dessertItem, id);

          print(downloadURL);
        });
      }else{
        DessertItem dessertItem = DessertItem(
            name: name,
            image: img,
            subTitle: sub,
            ingredients: ing,
            description: des,
            steps: stp,
            preparation:
            Preparation(temp: temp, prepTime: pre));
        saveDessertItem(dessertItem, id);
      }


    } on FirebaseException catch (e){
      print(e);
    }
  }

  Future<void> saveMealItem(DessertItem item, id){
    CollectionReference meal = FirebaseFirestore.instance.collection('dessert');
    List ingList = [];
    List stpList = [];

    print(id);

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
      'prepTime': item.preparation.prepTime,
      'temp': item.preparation.temp,
    };
    return dessert.doc(id).update
      ({
      'name':item.name,
      'image':item.image,
      'subTitle': item.subTitle,
      'description' : item.description,
      'ingredients': ingList,
      'steps' : stpList,
      'preparation': preparation,
    })

        .then((value) => print("Dessert Recipe Update"))
        .catchError((error) => print("Failed to Update Dessert Recipe: $error"));
  }
}