import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:food_recipe/providers/dessert_provider.dart';
import 'package:food_recipe/providers/update_dessert_provider.dart';
import 'package:provider/provider.dart';
import '../../global/app_colors.dart';

class UpdateDessert extends StatefulWidget {
  final DessertItem dessertItem;
  const UpdateDessert({Key? key, required this.dessertItem}) : super(key: key);

  @override
  State<UpdateDessert> createState() => _UpdateDessertState();
}

class _UpdateDessertState extends State<UpdateDessert> {
  final TextEditingController titleControllerDesserts = TextEditingController();
  final TextEditingController detailControllerDesserts =
      TextEditingController();
  final TextEditingController commentControllerDesserts =
      TextEditingController();
  final TextEditingController tempControllerDesserts = TextEditingController();
  final TextEditingController prepTimeControllerDesserts =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Widget> ingInput = [];
  List<Widget> stpInput = [];
  List<RecipeStep> recipeSteps = [];
  List<IngredientItem> ingredients = [];
  int ingIndex = 0;
  int stpIndex = 0;

  Widget inputField({label, id, initialVal}) {
    IngredientItem ing;
    final _ctrl = TextEditingController();
    if (initialVal != null) {
      _ctrl.text = initialVal;
      ing = IngredientItem(id: id, name: initialVal);
      ingredients.add(ing);
    } else {
      ing = IngredientItem(id: id, name: "");
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
                    for (IngredientItem i in ingredients) {
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
    RecipeStep stp;
    // _ctrl.text = answersMap[id] != null ? answersMap[id].answer: "";
    if (initialVal != null) {
      _ctrl.text = initialVal;
      stp = RecipeStep(id: id, step: initialVal);
      recipeSteps.add(stp);
    } else {
      stp = RecipeStep(id: id, step: "");
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
                    for (RecipeStep i in recipeSteps) {
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
    titleControllerDesserts.text = widget.dessertItem.dessertName;
    commentControllerDesserts.text = widget.dessertItem.subTitle;
    detailControllerDesserts.text = widget.dessertItem.description!;
    tempControllerDesserts.text = widget.dessertItem.preparation.temp!;
    prepTimeControllerDesserts.text = widget.dessertItem.preparation.prepTime!;

    for (IngredientItem a in widget.dessertItem.ingredients) {
      ingInput.add(inputField(id: ingIndex, initialVal: a.name));
      ingIndex = ingIndex + 1;
    }

    for (RecipeStep a in widget.dessertItem.steps) {
      stpInput.add(stepsField(id: stpIndex, initialVal: a.step));
      stpIndex = stpIndex + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rpDessertdl = Provider.of<DessertProvider>(context, listen: false);
    // final addMdl = Provider.of<AddMealProvider>(context, listen: false);
    final updateMdl =
        Provider.of<UpdateDessertProvider>(context, listen: false);
    double r = UIManager.ratio;

    InputField titleField = InputField(
      hint: 'single_recipe.name'.tr(),
      controller: titleControllerDesserts,
      onChanged: (val) {
        print(val);
      },
    );

    InputField commentField = InputField(
      hint: 'single_recipe.short_des'.tr(),
      // maxLength: 2,
      controller: commentControllerDesserts,
    );

    InputField detailField = InputField(
        hint: 'single_recipe.description'.tr(),
        maxLength: null,
        type: TextInputType.multiline,
        controller: detailControllerDesserts,
        isMulti: true);

    InputField tempField = InputField(
      hint: 'single_recipe.temp'.tr(),
      controller: tempControllerDesserts,
    );

    InputField prepTimeField = InputField(
      hint: 'single_recipe.prepare_time'.tr(),
      controller: prepTimeControllerDesserts,
    );

    return Scaffold(
      backgroundColor: kGrey4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30 * r,
            ),
            UpdateDessertImage(image: widget.dessertItem.dessertImage),
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
                            // Expanded(child: cookingTimeField),
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
          onTap: () async {
            setState(() {
              //   // validate = true;
            });
            print(titleControllerDesserts.text);
            formKey.currentState!.save();
            if (formKey.currentState!.validate()) {
              await updateMdl.updateImageToFirebase(
                  context: context,
                  name: titleControllerDesserts.text,
                  sub: commentControllerDesserts.text,
                  ing: ingredients,
                  des: detailControllerDesserts.text,
                  stp: recipeSteps,
                  temp: tempControllerDesserts.text,
                  pre: prepTimeControllerDesserts.text,
                  id: widget.dessertItem.id,
                  img: widget.dessertItem.dessertImage);
              rpDessertdl.loadAllDesserts();
            }
            final snackBar = SnackBar(
              content: const Text('Your Meal is Updated'),
              action: SnackBarAction(
                label: '',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ),
    );
  }
}
