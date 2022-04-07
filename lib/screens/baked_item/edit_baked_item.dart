import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:food_recipe/screens/baked_item/update_baked_item_image.dart';
import 'package:provider/provider.dart';

class EditBakedItem extends StatefulWidget {
  final Baked bakedItem;
  const EditBakedItem({Key? key, required this.bakedItem}) : super(key: key);

  @override
  State<EditBakedItem> createState() => _EditBakedItemState();
}

class _EditBakedItemState extends State<EditBakedItem> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // final TextEditingController commentController = TextEditingController();
  final TextEditingController restTimeController = TextEditingController();
  final TextEditingController restTemperatureController =
      TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController cookingTemperatureController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Widget> ingInput = [];
  List<Widget> stpInput = [];
  List<BakingStep> recipeSteps = [];
  List<BakingIngredient> ingredients = [];
  int ingIndex = 0;
  int stpIndex = 0;

  Widget inputField({label, id, initialVal}) {
    BakingIngredient ing;
    final _ctrl = TextEditingController();
    if (initialVal != null) {
      _ctrl.text = initialVal;
      ing = BakingIngredient(id: id, name: initialVal);
      ingredients.add(ing);
    } else {
      ing = BakingIngredient(id: id, name: "");
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
                    for (BakingIngredient i in ingredients) {
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
                    hintText: label ?? "",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  )))
        ]);
  }

  Widget stepsField({label, id, initialVal}) {
    final _ctrl = TextEditingController();
    BakingStep stp;
    // _ctrl.text = answersMap[id] != null ? answersMap[id].answer: "";
    if (initialVal != null) {
      _ctrl.text = initialVal;
      stp = BakingStep(id: id, step: initialVal);
      recipeSteps.add(stp);
    } else {
      stp = BakingStep(id: id, step: "");
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
                    for (BakingStep i in recipeSteps) {
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
    titleController.text = widget.bakedItem.data.name;
    descriptionController.text = widget.bakedItem.data.description!;
    restTimeController.text = widget.bakedItem.data.preparation.restTime!;
    restTemperatureController.text =
        widget.bakedItem.data.preparation.restTemperature!;
    cookingTimeController.text = widget.bakedItem.data.preparation.cookingTime!;
    cookingTemperatureController.text =
        widget.bakedItem.data.preparation.cookingTemperature!;

    for (BakingIngredient a in widget.bakedItem.data.ingredients) {
      ingInput.add(inputField(id: ingIndex, initialVal: a.name));
      ingIndex = ingIndex + 1;
    }

    for (BakingStep a in widget.bakedItem.data.steps) {
      stpInput.add(stepsField(id: stpIndex, initialVal: a.step));
      stpIndex = stpIndex + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rpMdl = Provider.of<BakedItemProvider>(context, listen: false);
    // final addMdl = Provider.of<AddMealProvider>(context, listen: false);
    final updateMdl =
        Provider.of<UpdateBakeItemProvider>(context, listen: false);
    double r = UIManager.ratio;

    InputField titleField = InputField(
      hint: 'baked_item.name'.tr(),
      label: 'baked_item.name'.tr(),
      controller: titleController,
      onChanged: (val) {
        // print(val);
      },
    );

    InputField descriptionField = InputField(
        hint: 'baked_item.description'.tr(),
        label: 'baked_item.description'.tr(),
        maxLength: null,
        type: TextInputType.multiline,
        controller: descriptionController,
        isMulti: true);

    InputField restTemperatureField = InputField(
      hint: 'baked_item.restTemperature'.tr(),
      label: 'baked_item.restTemperature'.tr(),
      controller: restTemperatureController,
    );

    InputField cookingTimeField = InputField(
      hint: 'baked_item.cookingTime'.tr(),
      label: 'baked_item.cookingTime'.tr(),
      controller: cookingTimeController,
    );

    InputField cookingTemperatureField = InputField(
      hint: 'baked_item.cookingTemperature'.tr(),
      label: 'baked_item.cookingTemperature'.tr(),
      controller: cookingTemperatureController,
    );

    InputField restTimeField = InputField(
      hint: 'baked_item.restTime'.tr(),
      label: 'baked_item.restTime'.tr(),
      controller: restTimeController,
    );

    return Scaffold(
      backgroundColor: kGrey4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30 * r,
            ),
            UpdateBakedItemImage(image: widget.bakedItem.data.image),
            Container(
              padding: EdgeInsets.all(10 * r),
              child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        titleField,
                        // commentField,
                        descriptionField,
                        Padding(
                            padding: EdgeInsets.only(bottom: 25 * r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "baked_item.bakingIngredient".tr(),
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
                                              label:
                                                  "Ingredient ${ingIndex + 1}",
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
                        Row(
                          children: [
                            Expanded(child: restTemperatureField),
                            Container(
                              width: 16,
                            ),
                            Expanded(child: restTimeField),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: cookingTimeField),
                            Container(
                              width: 16,
                            ),
                            Expanded(child: cookingTemperatureField),
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
                                    "baked_item.steps".tr(),
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
            // print(titleController.text);
            formKey.currentState!.save();
            if (formKey.currentState!.validate()) {
              try {
                final snackBar = SnackBar(
                  content: const Text('Your Meal is Updated'),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                await updateMdl.updateImageToFirebase(
                    context: context,
                    name: titleController.text,
                    ingredients: ingredients,
                    description: descriptionController.text,
                    steps: recipeSteps,
                    restTime: restTimeController.text,
                    restTemperature: restTemperatureController.text,
                    cookingTemperature: cookingTemperatureController.text,
                    cookingTime: cookingTimeController.text,
                    id: widget.bakedItem.id,
                    img: widget.bakedItem.data.image);
                await rpMdl.loadAllMeal();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BakedItemList()));
              } catch (e) {
                final snackBar = SnackBar(
                  content: const Text('An Error Occurred'),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                print(e);
              }
            }
          },
        ),
      ),
    );
  }
}
