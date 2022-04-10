import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:food_recipe/models/dessert_item.dart';
import 'package:provider/provider.dart';

import '../../providers/add_dessert_provider.dart';
import '../../providers/dessert_provider.dart';
import 'add_dessert_image.dart';

class AddNewDessert extends StatefulWidget {
  const AddNewDessert({Key? key}) : super(key: key);

  @override
  State<AddNewDessert> createState() => _AddNewDessertState();
}

class _AddNewDessertState extends State<AddNewDessert> {
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

  Widget inputField(label, id) {
    final _ctrl = TextEditingController();
    IngredientItemDessert ing = IngredientItemDessert(id: id, name: "");
    ingredients.add(ing);

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
                          setState(() {
                            ingInput.removeAt(id);
                            ingredients
                                .removeWhere((item) => item.id == ing.id);
                          });
                        }),
                    hintText: label,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  )))
        ]);
  }

  Widget stepsField(label, id) {
    final _ctrl = TextEditingController();
    // _ctrl.text = answersMap[id] != null ? answersMap[id].answer: "";
    RecipeStepDessert stp = RecipeStepDessert(id: id, step: "");
    recipeSteps.add(stp);

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
  }

  @override
  Widget build(BuildContext context) {
    final rpDessertdl = Provider.of<DessertProvider>(context, listen: false);
    final addDesserts = Provider.of<AddDessertProvider>(context, listen: false);
    double r = UIManager.ratio;

    validate(value, msg) {
      if (value == null || value.isEmpty) {
        return '$msg is Required';
      }
      return null;
    }

    InputField titleField = InputField(
      hint: 'single_recipe_dessert.name'.tr(),
      controller: titleControllerDessert,
      validator: (value) => validate(value, 'single_recipe_dessert.name'.tr()),
    );

    InputField commentField = InputField(
      hint: 'single_recipe_dessert.short_description'.tr(),
      controller: commentControllerDessert,
      validator: (value) =>
          validate(value, 'single_recipe_dessert.short_description'.tr()),
    );

    InputField detailField = InputField(
        hint: 'single_recipe_dessert.description'.tr(),
        maxLength: null,
        type: TextInputType.multiline,
        controller: detailControllerDessert,
        validator: (value) =>
            validate(value, 'single_recipe_dessert.description'.tr()),
        isMulti: true);

    InputField tempField = InputField(
      hint: 'single_recipe_dessert.temp'.tr(),
      controller: tempControllerDessert,
      validator: (value) => validate(value, 'single_recipe_dessert.temp'.tr()),
    );

    InputField prepTimeField = InputField(
      hint: 'single_recipe_dessert.preparation_time'.tr(),
      controller: prepTimeControllerDessert,
      validator: (value) =>
          validate(value, 'single_recipe_dessert.preparation_time'.tr()),
    );

    return Scaffold(
      backgroundColor: kGrey4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30 * r,
            ),
            const AddDessertImage(),
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
                                    "single_recipe_dessert.ingredients".tr(),
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
                                              "Ing ${ingIndex + 1}", ingIndex));
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
                                    "single_recipe_dessert.steps".tr(),
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
                                          stpInput.add(inputField(
                                              "Step ${stpIndex + 1}",
                                              stpIndex));
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
            title: 'submit'.tr(),
            isLoading: this.isLoading,
            onTap: () async {
              setState(() {
                //   // validate = true;
              });

              formKey.currentState!.save();
              if (formKey.currentState!.validate()) {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  await addDesserts.uploadImageToFirebase(
                      context: context,
                      name: titleControllerDessert.text,
                      sub: commentControllerDessert.text,
                      ing: ingredients,
                      des: detailControllerDessert.text,
                      stp: recipeSteps,
                      temp: tempControllerDessert.text,
                      pre: prepTimeControllerDessert.text);
                  await rpDessertdl.loadAllDesserts();
                  setState(() {
                    isLoading = false;
                  });

                  final savedSnackBar = SnackBar(
                    content: const Text('Your Baked Item is Saved'),
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
                    content: const Text('An Error Occurred'),
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
            }),
      ),
    );
  }
}
