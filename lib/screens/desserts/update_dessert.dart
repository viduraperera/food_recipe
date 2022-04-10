import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:food_recipe/screens/desserts/update_dessert_image.dart';
import 'package:provider/provider.dart';
import '../../global/app_colors.dart';
import '../../models/dessert_item.dart';
import '../../providers/dessert_provider.dart';
import '../../providers/update_dessert_provider.dart';

class UpdateDessert extends StatefulWidget {
  final Dessert dessertItem;
  const UpdateDessert({Key? key, required this.dessertItem}) : super(key: key);

  @override
  State<UpdateDessert> createState() => _UpdateDessertState();
}

class _UpdateDessertState extends State<UpdateDessert> {
  final TextEditingController titleControllerDessert = TextEditingController();
  final TextEditingController detailControllerDessert = TextEditingController();
  final TextEditingController commentControllerDessert =
      TextEditingController();
  final TextEditingController tempControllerDessert = TextEditingController();
  final TextEditingController prepTimeControllerDessert =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Widget> ingInput = [];
  List<Widget> stpInput = [];
  List<RecipeStepDessert> recipeSteps = [];
  List<IngredientItemDessert> ingredients = [];
  int ingIndex = 0;
  int stpIndex = 0;
  bool isLoading = false;

  Widget inputField({label, id, initialVal}) {
    IngredientItemDessert ing;
    final _ctrl = TextEditingController();
    if (initialVal != null) {
      _ctrl.text = initialVal;
      ing = IngredientItemDessert(id: id, name: initialVal);
      ingredients.add(ing);
    } else {
      ing = IngredientItemDessert(id: id, name: "");
      ingredients.add(ing);
    }

    // _ctrl.text = answersMap[id] != null ? answersMap[id].answer: "";

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(bottom: 12.0, top: 4),
              child: TextFormField(
                  controller: _ctrl,
                  key: Key(id.toString()),
                  onChanged: (String value) {
                    // changeInputValue(value, id);
                    for (IngredientItemDessert i in ingredients) {
                      if (i.id == ing.id) {
                        i.name = value;
                      }
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.close, color: kGrey, size: 20),
                        onPressed: () {
                          print(id);
                          setState(() {
                            ingInput.removeAt(id);
                            ingredients
                                .removeWhere((item) => item.id == ing.id);
                          });
                        }),
                    hintText: label ?? "",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  )))
        ]);
  }

  Widget stepsField({label, id, initialVal}) {
    final _ctrl = TextEditingController();
    RecipeStepDessert stp;
    // _ctrl.text = answersMap[id] != null ? answersMap[id].answer: "";
    if (initialVal != null) {
      _ctrl.text = initialVal;
      stp = RecipeStepDessert(id: id, step: initialVal);
      recipeSteps.add(stp);
    } else {
      stp = RecipeStepDessert(id: id, step: "");
      recipeSteps.add(stp);
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(bottom: 12.0, top: 4),
              child: TextFormField(
                  controller: _ctrl,
                  key: Key(id.toString()),
                  onChanged: (String value) {
                    // changeInputValue(value, id);
                    for (RecipeStepDessert i in recipeSteps) {
                      if (i.id == stp.id) {
                        i.step = value;
                      }
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.close, color: kGrey, size: 20),
                        onPressed: () {
                          print(id);
                          setState(() {
                            stpInput.removeAt(id);
                            recipeSteps
                                .removeWhere((item) => item.id == stp.id);
                          });
                        }),
                    hintText: label,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  )))
        ]);
  }

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  setInitialValues() {
    try {
      titleControllerDessert.text = widget.dessertItem.data.dessertName;
      commentControllerDessert.text = widget.dessertItem.data.subTitle;
      detailControllerDessert.text = widget.dessertItem.data.description!;
      tempControllerDessert.text = widget.dessertItem.data.preparation.temp!;
      prepTimeControllerDessert.text =
          widget.dessertItem.data.preparation.prepTime!;

      for (IngredientItemDessert a in widget.dessertItem.data.ingredients) {
        ingInput.add(inputField(id: ingIndex, initialVal: a.name));
        ingIndex = ingIndex + 1;
      }

      for (RecipeStepDessert a in widget.dessertItem.data.steps) {
        stpInput.add(stepsField(id: stpIndex, initialVal: a.step));
        stpIndex = stpIndex + 1;
      }
    } catch (e) {
      print('**************************');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rpDessertdl = Provider.of<DessertProvider>(context, listen: false);
    // final addMdl = Provider.of<AddMealProvider>(context, listen: false);
    final updateDessertdl =
        Provider.of<UpdateDessertProvider>(context, listen: false);
    double r = UIManager.ratio;

    InputField titleField = InputField(
      hint: 'single_recipe.name'.tr(),
      controller: titleControllerDessert,
      onChanged: (val) {
        print(val);
      },
    );

    InputField commentField = InputField(
      hint: 'single_recipe.short_des'.tr(),
      // maxLength: 2,
      controller: commentControllerDessert,
    );

    InputField detailField = InputField(
        hint: 'single_recipe.description'.tr(),
        maxLength: null,
        type: TextInputType.multiline,
        controller: detailControllerDessert,
        isMulti: true);

    InputField tempField = InputField(
      hint: 'single_recipe.temp'.tr(),
      controller: tempControllerDessert,
    );

    InputField prepTimeField = InputField(
      hint: 'single_recipe.prepare_time'.tr(),
      controller: prepTimeControllerDessert,
    );

    return Scaffold(
      backgroundColor: kGrey4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30 * r,
            ),
            UpdateDessertImage(image: widget.dessertItem.data.dessertImage),
            Container(
              padding: EdgeInsets.all(10 * r),
              child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        titleField,
                        commentField,
                        detailField,
                        Padding(
                            padding: EdgeInsets.only(bottom: 25 * r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "single_recipe.ingredients".tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18 * r),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          ingInput.add(inputField(
                                              label: "Ing ${ingIndex + 1}",
                                              id: ingIndex));
                                          ingIndex = ingIndex + 1;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: kPurple2,
                                      )),
                                ),
                              ],
                            )),
                        Column(
                          children: ingInput,
                        ),
                        tempField,
                        Row(
                          children: [
                            Expanded(child: prepTimeField),
                            Container(
                              width: 16,
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: stpInput.isEmpty ? 0 : 25 * r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "single_recipe.steps".tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18 * r),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          stpInput.add(stepsField(
                                              label: "Step ${stpIndex + 1}",
                                              id: stpIndex));
                                          stpIndex = stpIndex + 1;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: kPurple2,
                                      )),
                                ),
                              ],
                            )),
                        Column(
                          children: stpInput,
                        ),
                      ])),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20 * r, vertical: 10 * r),
        child: CustomButton(
          title: 'update'.tr(),
          isLoading: this.isLoading,
          onTap: () async {
            formKey.currentState!.save();
            if (formKey.currentState!.validate()) {
              try {
                setState(() {
                  isLoading = true;
                });

                await updateDessertdl.updateImageToFirebase(
                    context: context,
                    name: titleControllerDessert.text,
                    sub: commentControllerDessert.text,
                    ing: ingredients,
                    des: detailControllerDessert.text,
                    stp: recipeSteps,
                    temp: tempControllerDessert.text,
                    pre: prepTimeControllerDessert.text,
                    id: widget.dessertItem.id,
                    img: widget.dessertItem.data.dessertImage);
                await rpDessertdl.loadAllDesserts();
                setState(() {
                  isLoading = false;
                });
                final savedSnackBar = SnackBar(
                  content: const Text('Your Desert Recipe is Saved'),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(savedSnackBar);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DessertList()));
              } catch (e) {
                setState(() {
                  isLoading = false;
                });
                final savedSnackBar = SnackBar(
                  content: const Text('An Error Ocurred'),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(savedSnackBar);
              }
            }
          },
        ),
      ),
    );
  }
}
