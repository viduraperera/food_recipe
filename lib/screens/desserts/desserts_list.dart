import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:food_recipe/screens/desserts/single_dessert.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../providers/dessert_provider.dart';
import 'add_dessert.dart';

class DessertList extends StatefulWidget {
  const DessertList({Key? key}) : super(key: key);

  @override
  State<DessertList> createState() => _DessertListState();
}

class _DessertListState extends State<DessertList> {

  @override
  void initState() {
    super.initState();
    final rpDessertdl = Provider.of<DessertProvider>(context, listen: false);
    rpDessertdl.loadAllDesserts();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double r = UIManager.ratio;
    final rpDessertdl = Provider.of<DessertProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewDessert(),
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
                              style: TextStyle(color: kGrey),
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
                                colors: <Color>[kPurple, Colors.transparent])),
                        child: Stack( children: [
                          Image(
                            image: AssetImage("assets/images/desserts3.jpg",
                            ),
                            fit: BoxFit.cover,
                            height: (h / 2) * r,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15 * r, vertical: 30 * r),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 30 * r,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()));
                              },
                            ),
                          )
                        ],
                        ),
                      )
                  )
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (rpDessertdl.reLoading) {
                      return ShimmerLoading(
                          isLoading: rpDessertdl.reLoading,
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
                                    builder: (context) => SingleDessert(
                                        dessertItem: rpDessertdl.dessertListProvider[index])));
                          },
                          child: DessertCard(item: rpDessertdl.dessertListProvider[index]),
                        ),
                      );
                    }
                  },
                  childCount: rpDessertdl.reLoading ? 2: rpDessertdl.dessertListProvider.length,
                ),
              ),
            ]
        ),
      ),
    );
  }
}

