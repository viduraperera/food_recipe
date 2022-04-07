import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ViewBakedItem extends StatelessWidget {
  final Baked bakedItem;

  ViewBakedItem({Key? key, required this.bakedItem}) : super(key: key);

  final PanelController _panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double r = UIManager.ratio;
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: h / 1.7,
        maxHeight: h - 100,
        controller: _panelController,
        backdropEnabled: true,
        panel: getPanelForBakedItem(context: context, r: r, h: h),
        body: getBodyForBakedItem(context: context, h: h, w: w, r: r),
        parallaxEnabled: true,
        parallaxOffset: 0.4,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    );
  }

  Widget getBodyForBakedItem(
      {required BuildContext context,
      required double h,
      required double w,
      required double r}) {
    return Container(
      alignment: Alignment.topLeft,
      child: Stack(
        children: [
          Image(
            width: w,
            image: NetworkImage(bakedItem.data.image),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15 * r, vertical: 30 * r),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30 * r,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
      ),
    );
  }

  Widget getPanelForBakedItem(
      {required BuildContext context, required double h, required double r}) {
    final rMdl = Provider.of<BakedItemProvider>(context);
    final PageController controller = PageController(initialPage: 0);
    TextStyle titleSt =
        TextStyle(fontSize: 16 * r, fontWeight: FontWeight.bold, color: kGrey);
    TextStyle valueSt =
        TextStyle(fontSize: 18 * r, fontWeight: FontWeight.bold, color: kBlack);

    final rpMdl = Provider.of<BakedItemProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        _panelController.open();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25 * r, vertical: 15 * r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            rMdl.mealPage == 0
                ? bakedItemFirstPageBar()
                : bakedItemSecondPageBar(),
            SizedBox(
              height: 20 * r,
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (int page) {
                  rMdl.onSingleRecipePageChange(page);
                },
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bakedItem.data.name,
                                      style: TextStyle(
                                          fontSize: 26 * r,
                                          fontWeight: FontWeight.bold,
                                          color: kPurple),
                                    ),
                                    // Text(bakedItem.data.subTitle),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  tooltip: 'Edit',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditBakedItem(
                                                bakedItem: bakedItem)));
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  tooltip: 'Delete',
                                  onPressed: () async {
                                    await rpMdl.deleteMeal(bakedItem.id);
                                    final snackBar = SnackBar(
                                      content: const Text('Baked Item Deleted'),
                                      action: SnackBarAction(
                                        label: '',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BakedItemList()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60 * r, child: const Divider()),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("baked_item.restTime".tr(),
                                        style: titleSt),
                                    Text(
                                        bakedItem.data.preparation.restTime ??
                                            "",
                                        style: valueSt),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("baked_item.restTemperature".tr(),
                                        style: titleSt),
                                    Text(
                                        bakedItem.data.preparation
                                                .restTemperature ??
                                            "",
                                        style: valueSt),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "baked_item.cookingTime".tr(),
                                      style: titleSt,
                                    ),
                                    Text(
                                        bakedItem
                                                .data.preparation.cookingTime ??
                                            "",
                                        style: valueSt),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(height: 20 * r),
                            Text("baked_item.description".tr(), style: titleSt),
                            SizedBox(height: 10 * r),
                            Text(
                              (bakedItem.data.description ?? ""),
                              style: const TextStyle(
                                  color: kBlack, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20 * r,
                            ),
                            Text("baked_item.ingredients".tr(), style: titleSt),
                            SizedBox(
                              height: 20 * r,
                            ),
                            Column(
                              children: bakedItem.data.ingredients
                                  .map((BakingIngredient item) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10 * r),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Expanded(
                                      //     child: Padding(
                                      //       padding:
                                      //       EdgeInsets.only(right: 20 * r),
                                      //       child: Text(item.amount),
                                      //     )),
                                      Expanded(
                                        flex: 2,
                                        child: Text(item.name),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("baked_item.steps".tr(), style: titleSt),
                      SizedBox(
                        height: 20 * r,
                      ),
                      Column(
                        children: bakedItem.data.steps.map((BakingStep step) {
                          int idx = bakedItem.data.steps.indexOf(step) + 1;
                          return Padding(
                              padding: EdgeInsets.all(10 * r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 0,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 20 * r),
                                              child: CircleAvatar(
                                                backgroundColor: kPurple,
                                                child: Text(idx.toString()),
                                              ))),
                                      Expanded(
                                        child: Text(
                                          step.step,
                                          style: TextStyle(
                                              fontSize: 18 * r,
                                              color: kPurple,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 12 * r,
                                  // ),
                                  // Text(step.description)
                                ],
                              ));
                        }).toList(),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget bakedItemFirstPageBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 5,
        width: 50,
        decoration: const BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), bottomLeft: Radius.circular(4))),
      ),
      Container(
        height: 5,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(width: .4, color: Colors.black26),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(4), bottomRight: Radius.circular(4))),
      )
    ],
  );
}

Widget bakedItemSecondPageBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 5,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(width: .4, color: Colors.black26),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4), bottomLeft: Radius.circular(4))),
      ),
      Container(
        height: 5,
        width: 50,
        decoration: const BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(4), bottomRight: Radius.circular(4))),
      ),
    ],
  );
}
