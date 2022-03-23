import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/index.dart';

class RecipeProvider with ChangeNotifier{

  String searchKey = "";
  int mealPage = 0;
  List<MealItem> foodMealList = [];
  List<MealItem> searchMealList = [];
  bool reLoading = false;

  onSingleRecipePageChange(int page){
    if(page == 0){
      mealPage = 0;
    }else{
      mealPage = 1;
    }
    notifyListeners();
  }
  final mealRef = FirebaseFirestore.instance
  .collection('meal')
  .withConverter<MealItem>
  (fromFirestore: (snapshot, _) => MealItem.fromJson(snapshot.data()!),
      toFirestore: (meal, _) => meal.toJson(),
  );

  loadAllMeal() async {
    List<QueryDocumentSnapshot<MealItem>> snapshotList =
    await mealRef.get().then((value) => value.docs);

    for(var item in snapshotList){
      MealItem i = item.data();
      foodMealList.add(i);
    }

    reLoading = false;

    notifyListeners();
  }

  loadSearch(String key) async{
    final searchRef = FirebaseFirestore.instance
        .collection('meal')
        .where("name", isLessThanOrEqualTo: key)
        .withConverter<MealItem>(
        fromFirestore: (snapshot, _) => MealItem.fromJson(snapshot.data()!),
        toFirestore: (meal, _) => meal.toJson()
    );

    List<QueryDocumentSnapshot<MealItem>> snapshotList =
        await searchRef.get().then((value) => value.docs);

    for (var item in snapshotList) {
      MealItem i = item.data();
      searchMealList.add(i);
    }
    // reLoading = false;

    notifyListeners();
  }


}