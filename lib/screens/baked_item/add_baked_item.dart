import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:provider/provider.dart';

class AddBakedItem extends StatefulWidget {
  const AddBakedItem({Key? key}) : super(key: key);

  @override
  State<AddBakedItem> createState() => _AddNewBakedItemState();
}

class _AddNewBakedItemState extends State<AddBakedItem> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController restTimeController = TextEditingController();
  final TextEditingController restTemperatureController =
      TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController cookingTemperatureController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Widget> ingInput = [];
  List<Widget> stpInput = [];
  List<BakingStep> bakingStep = [];
  List<BakingIngredient> bakingIngredient = [];
  int ingIndex = 0;
  int stpIndex = 0;
  bool isLoading = false;

  Widget inputField(label, id) {
    final _ctrl = TextEditingController();
    // _ctrl.text = answersMap[id] != null ? answersMap[id].answer: "";
    BakingIngredient ing = BakingIngredient(id: id, name: "");
    bakingIngredient.add(ing);

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
                    for (BakingIngredient i in bakingIngredient) {
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
                            bakingIngredient
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
    BakingStep stp = BakingStep(id: id, step: "");
    bakingStep.add(stp);

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
                    for (BakingStep i in bakingStep) {
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
                            bakingStep.removeWhere((item) => item.id == stp.id);
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
    // ingInput.add(inputField("Ing${ingIndex + 1}" , 0));
  }

  @override
  Widget build(BuildContext context) {
    final rpMdl = Provider.of<BakedItemProvider>(context, listen: false);
    final addMdl = Provider.of<AddBakedItemProvider>(context, listen: false);
    double r = UIManager.ratio;

    validate(value, msg) {
      if (value == null || value.isEmpty) {
        return '$msg is Required';
      }
      return null;
    }

    InputField titleField = InputField(
      hint: 'baked_item.name'.tr(),
      label: 'baked_item.name'.tr(),
      controller: titleController,
      validator: (value) => validate(value, 'baked_item.name'.tr()),
    );

    InputField descriptionField = InputField(
        hint: 'baked_item.description'.tr(),
        label: 'baked_item.description'.tr(),
        maxLength: null,
        type: TextInputType.multiline,
        controller: descriptionController,
        validator: (value) => validate(value, 'baked_item.description'.tr()),
        isMulti: true);

    InputField restTemperatureField = InputField(
      hint: 'baked_item.restTemperature'.tr(),
      label: 'baked_item.restTemperature'.tr(),
      controller: restTemperatureController,
      validator: (value) => validate(value, 'baked_item.restTemperature'.tr()),
    );

    InputField restTimeField = InputField(
      hint: 'baked_item.restTime'.tr(),
      label: 'baked_item.restTime'.tr(),
      controller: restTimeController,
      validator: (value) => validate(value, 'baked_item.restTime'.tr()),
    );

    InputField cookingTimeField = InputField(
      hint: 'baked_item.cookingTime'.tr(),
      label: 'baked_item.cookingTime'.tr(),
      controller: cookingTimeController,
      validator: (value) => validate(value, 'baked_item.cookingTime'.tr()),
    );

    InputField cookingTemperatureField = InputField(
      hint: 'baked_item.cookingTemperature'.tr(),
      label: 'baked_item.cookingTemperature'.tr(),
      controller: cookingTemperatureController,
      validator: (value) =>
          validate(value, 'baked_item.cookingTemperature'.tr()),
    );

    return Scaffold(
      backgroundColor: kGrey4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30 * r,
            ),
            const AddBakedItemImage(),
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
                                              "Ingredient ${ingIndex + 1}",
                                              ingIndex));
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
                            Expanded(child: cookingTemperatureField),
                            Container(
                              width: 16,
                            ),
                            Expanded(child: cookingTimeField),
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
            isLoading: isLoading,
            title: 'submit'.tr(),
            onTap: () async {
              setState(() {
                //   // validate = true;
              });

              formKey.currentState!.save();
              if (formKey.currentState!.validate()) {
                try {
                  this.isLoading = true;
                  final snackBar = SnackBar(
                    content: const Text(
                        'Your Baked Item is being saved. Please wait..'),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  await addMdl.uploadImageToFirebase(
                      context: context,
                      name: titleController.text,
                      description: descriptionController.text,
                      restTime: restTimeController.text,
                      restTemperature: restTemperatureController.text,
                      cookingTemperature: cookingTemperatureController.text,
                      cookingTime: cookingTimeController.text,
                      ingredients: bakingIngredient,
                      steps: bakingStep);
                  await rpMdl.loadAllMeal();
                  this.isLoading = false;
                  ScaffoldMessenger.of(context).clearSnackBars();
                  isLoading = false;
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
                      MaterialPageRoute(builder: (context) => BakedItemList()));
                } catch (e) {
                  this.isLoading = false;
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
                }
              } else {
                final snackBar = SnackBar(
                  content: const Text('Fill all the mandatory fields'),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }),
      ),
    );
  }
}
