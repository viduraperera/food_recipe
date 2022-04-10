import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:provider/provider.dart';

class AddNewMeal extends StatefulWidget {
  const AddNewMeal({Key? key}) : super(key: key);

  @override
  State<AddNewMeal> createState() => _AddNewMealState();
}

class _AddNewMealState extends State<AddNewMeal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();
  final TextEditingController cookTimeController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Widget> ingInput = [];
  List<Widget> stpInput = [];
  List<RecipeStep> recipeSteps = [];
  List<IngredientItem> ingredients = [];
  int ingIndex = 0;
  int stpIndex = 0;
  bool isLoading = false;

  Widget inputField(label, id) {
    final _ctrl = TextEditingController();
    // _ctrl.text = answersMap[id] != null ? answersMap[id].answer: "";
    IngredientItem ing = IngredientItem(id: id, name: "");
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
    RecipeStep stp = RecipeStep(id: id, step: "");
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
    // ingInput.add(inputField("Ing${ingIndex + 1}" , 0));
  }

  @override
  Widget build(BuildContext context) {
    final rpMdl = Provider.of<MealProvider>(context, listen: false);
    final addMdl = Provider.of<AddMealProvider>(context, listen: false);
    double r = UIManager.ratio;

    InputField titleField = InputField(
      hint: 'single_recipe.name'.tr(),
      controller: titleController,
      onChanged: (val) {
        print(val);
      },
    );

    InputField commentField = InputField(
      hint: 'single_recipe.short_des'.tr(),
      // maxLength: 2,
      controller: commentController,
    );

    InputField detailField = InputField(
        hint: 'single_recipe.description'.tr(),
        maxLength: null,
        type: TextInputType.multiline,
        controller: detailController,
        isMulti: true);

    InputField tempField = InputField(
      hint: 'single_recipe.temp'.tr(),
      controller: tempController,
    );

    InputField prepTimeField = InputField(
      hint: 'single_recipe.prepare_time'.tr(),
      controller: prepTimeController,
    );

    InputField cookTimeField = InputField(
      hint: 'single_recipe.cooking_time'.tr(),
      controller: cookTimeController,
    );

    return Scaffold(
      backgroundColor: kGrey4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30 * r,
            ),
            const AddMealImage(),
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
                            Expanded(child: cookTimeField),
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
            onTap: () async {
              setState(() {
                isLoading = true;
              });

              formKey.currentState!.save();
              if (formKey.currentState!.validate()) {
                try {
                  final snackBar = SnackBar(
                    content: const Text(
                        'Your Meal being added. Please wait..'),
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
                      sub: commentController.text,
                      ing: ingredients,
                      des: detailController.text,
                      stp: recipeSteps,
                      temp: tempController.text,
                      cook: cookTimeController.text,
                      pre: prepTimeController.text);
                  await rpMdl.loadAllMeal();
                  ScaffoldMessenger.of(context).clearSnackBars();
                  isLoading = false;
                  final savedSnackBar = SnackBar(
                    content: const Text('Your Meal is added'),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(savedSnackBar);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MealList()));
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
                }
              }else{
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

