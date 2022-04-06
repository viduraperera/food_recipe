import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'add_meal.dart';

class MealList extends StatefulWidget {
  const MealList({Key? key}) : super(key: key);

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> {

  @override
  void initState() {
    super.initState();
    final rpMdl = Provider.of<MealProvider>(context, listen: false);
    rpMdl.loadAllMeal();


  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double r = UIManager.ratio;
    final rpMdl = Provider.of<MealProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewMeal(),
            ),
          );
        },
        child: Icon(Icons.add),

      ),
      body: Shimmer(
        linearGradient: shimmerGradient,
        child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  expandedHeight: h / 4.5,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Row(
                        children: const [
                          Expanded(child: SizedBox()),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              "My Recipe Book",
                              style: TextStyle(color: kGrey4),
                            ),
                          )
                        ],
                      ),
                      background: DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                                colors: <Color>[kGrey5, Colors.transparent])),
                        child: Image(
                          image: AssetImage("assets/images/meal.jpg",
                          ),
                          fit: BoxFit.cover,
                          height: (h / 4) * r,
                        ),
                      )
                  )
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (rpMdl.reLoading) {
                      return ShimmerLoading(
                          isLoading: rpMdl.reLoading,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      width: 250,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    } else {
                      return Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15 * r, vertical: 5 * r),
                        // child: Container(
                        //   height: 200,
                        //   width: 200,
                        //   color: Colors.red,
                        // ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleMealScreen(
                                        mealItem: rpMdl.foodMealList[index])));
                          },
                          child: MealCardLarge(item: rpMdl.foodMealList[index]),
                        ),
                      );
                    }
                  },
                  childCount: rpMdl.reLoading ? 2: rpMdl.foodMealList.length,
                ),
              ),
            ]
        ),
      ),
    );
  }
}


