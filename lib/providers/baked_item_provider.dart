import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/index.dart';

class BakedItemProvider with ChangeNotifier {
  String searchKey = "";
  int mealPage = 0;
  List<Baked> foodMealList = [];
  // List<MealItem> foodMealList = [];
  List<BakedItem> searchMealList = [];
  bool reLoading = false;

  onSingleRecipePageChange(int page) {
    if (page == 0) {
      mealPage = 0;
    } else {
      mealPage = 1;
    }
    notifyListeners();
  }

  final mealRef = FirebaseFirestore.instance
      .collection('baked')
      .withConverter<BakedItem>(
        fromFirestore: (snapshot, _) => BakedItem.fromJson(snapshot.data()!),
        toFirestore: (meal, _) => meal.toJson(),
      );

  loadAllMeal() async {
    foodMealList.clear();
    List<QueryDocumentSnapshot<BakedItem>> snapshotList =
        await mealRef.get().then((value) => value.docs);

    for (var item in snapshotList) {
      BakedItem i = item.data();
      String id = item.id;
      Baked m = Baked(id: id, data: i);
      print(item.id);
      foodMealList.add(m);
    }

    reLoading = false;

    notifyListeners();
  }

  loadSearch(String key) async {
    final searchRef = FirebaseFirestore.instance
        .collection('baked')
        .where("name", isLessThanOrEqualTo: key)
        .withConverter<BakedItem>(
            fromFirestore: (snapshot, _) =>
                BakedItem.fromJson(snapshot.data()!),
            toFirestore: (meal, _) => meal.toJson());

    List<QueryDocumentSnapshot<BakedItem>> snapshotList =
        await searchRef.get().then((value) => value.docs);

    for (var item in snapshotList) {
      BakedItem i = item.data();
      searchMealList.add(i);
    }
    // reLoading = false;

    notifyListeners();
  }

  deleteMeal(id) async {
    var collection = FirebaseFirestore.instance.collection('baked');
    collection.doc(id).delete();

    notifyListeners();
  }
}
