import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/index.dart';

class DessertProvider with ChangeNotifier{

  String searchKey = "";
  int pageDessert = 0;
  List<DessertItem> dessertListProvider = []; //foodMealList
  List<DessertItem> searchDessertList = [];
  bool reLoading = false;

  onSingleRecipePageChange(int page){
    if(page == 0){
      pageDessert = 0;
    }else{
      pageDessert = 1;
    }
    notifyListeners();
  }
  final dessertRef = FirebaseFirestore.instance
      .collection('dessert')
      .withConverter<DessertItem>
    (fromFirestore: (snapshot, _) => DessertItem.fromJson(snapshot.data()!),
    toFirestore: (dessert, _) => dessert.toJson(),
  );

  loadAllDesserts() async {
    dessertListProvider.clear();
    List<QueryDocumentSnapshot<DessertItem>> snapshotList =
    await dessertRef.get().then((value) => value.docs);

    for(var item in snapshotList){
      DessertItem i = item.data();
      dessertListProvider.add(i);
    }

    reLoading = false;

    notifyListeners();
  }

  loadSearch(String key) async{
    final searchRef = FirebaseFirestore.instance
        .collection('dessert')
        .where("name", isLessThanOrEqualTo: key)
        .withConverter<DessertItem>(
        fromFirestore: (snapshot, _) => DessertItem.fromJson(snapshot.data()!),
        toFirestore: (dessert, _) => dessert.toJson()
    );

    List<QueryDocumentSnapshot<DessertItem>> snapshotList =
    await searchRef.get().then((value) => value.docs);

    for (var item in snapshotList) {
      DessertItem i = item.data();
      searchDessertList.add(i);
    }
    // reLoading = false;

    notifyListeners();
  }


}