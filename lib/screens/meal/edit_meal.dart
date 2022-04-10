import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:food_recipe/screens/meal/update_mael_image.dart';
import 'package:provider/provider.dart';

class EditMeal extends StatefulWidget {
  final Meal mealItem;
  const EditMeal({Key? key, required this.mealItem}) : super(key: key);

  @override
  State<EditMeal> createState() => _EditMealState();
}

class _EditMealState extends State<EditMeal> {
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
                            ingredients.removeWhere((item) => item.id == ing.id);

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
    if(initialVal != null){
      _ctrl.text = initialVal;
      stp = RecipeStep(id:id, step: initialVal);
      recipeSteps.add(stp);

    }
    else{
      stp = RecipeStep(id:id, step: "");
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
                    for(RecipeStep i in recipeSteps){
                      if(i.id == stp.id){
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
                            recipeSteps.removeWhere((item) => item.id == stp.id);

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

  setInitialValues(){
    titleController.text = widget.mealItem.data.name;
    commentController.text = widget.mealItem.data.subTitle;
    detailController.text = widget.mealItem.data.description!;
    tempController.text = widget.mealItem.data.preparation.temp!;
    prepTimeController.text = widget.mealItem.data.preparation.prepTime!;
    cookTimeController.text = widget.mealItem.data.preparation.cookingTime!;

    for(IngredientItem a in widget.mealItem.data.ingredients){
      ingInput.add(inputField(
          id: ingIndex, initialVal: a.name));
      ingIndex = ingIndex + 1;
    }

    for(RecipeStep a in widget.mealItem.data.steps){
      stpInput.add(stepsField(
          id: stpIndex, initialVal: a.step));
      stpIndex = stpIndex + 1;
    }

  }

  @override
  Widget build(BuildContext context) {
    final rpMdl = Provider.of<MealProvider>(context, listen: false);
   // final addMdl = Provider.of<AddMealProvider>(context, listen: false);
    final updateMdl = Provider.of<UpdateMealProvider>(context, listen: false);
    double r = UIManager.ratio;

    validate(value, msg) {
      if (value == null || value.isEmpty) {
        return '$msg is Required';
      }
      return null;
    }

    InputField titleField = InputField(
      hint: 'single_recipe.name'.tr(),
      controller: titleController,
      validator: (value) => validate(value, 'single_recipe.name'.tr()),
      onChanged: (val) {
        print(val);
      },
    );

    InputField commentField = InputField(
      hint: 'single_recipe.short_des'.tr(),
      // maxLength: 2,
      controller: commentController,
      validator: (value) => validate(value, 'single_recipe.short_des'.tr()),
    );

    InputField detailField = InputField(
        hint: 'single_recipe.description'.tr(),
        maxLength: null,
        type: TextInputType.multiline,
        controller: detailController,
        validator: (value) => validate(value, 'single_recipe.description'.tr()),
        isMulti: true);

    InputField tempField = InputField(
      hint: 'single_recipe.temp'.tr(),
      controller: tempController,
      validator: (value) => validate(value, 'single_recipe.temp'.tr()),
    );

    InputField prepTimeField = InputField(
      hint: 'single_recipe.prepare_time'.tr(),
      controller: prepTimeController,
      validator: (value) => validate(value, 'single_recipe.prepare_time'.tr()),
    );

    InputField cookTimeField = InputField(
      hint: 'single_recipe.cooking_time'.tr(),
      controller: cookTimeController,
      validator: (value) => validate(value, 'single_recipe.cooking_time'.tr()),
    );

    return Scaffold(
      backgroundColor: kGrey4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30 * r,
            ),
             Stack(
               children: [
                 UpdateMealImage(image: widget.mealItem.data.image),
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
                 ),
               ],
             ),

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
                                             label: "Ing ${ingIndex + 1}", id: ingIndex));
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
                                             label: "Step ${stpIndex + 1}", id : stpIndex));
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

                await updateMdl.updateImageToFirebase(
                    context: context,
                    name: titleController.text,
                    sub: commentController.text,
                    ing: ingredients,
                    des: detailController.text,
                    stp: recipeSteps,
                    temp: tempController.text,
                    cook: cookTimeController.text,
                    pre: prepTimeController.text,
                    id: widget.mealItem.id,
                    img: widget.mealItem.data.image);
                rpMdl.loadAllMeal();
                setState(() {
                  isLoading = false;
                });

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MealList()));
              } catch (e) {
                setState(() {
                  isLoading = false;
                });

                final snackBar = SnackBar(
                  content: const Text('An Error Ocurred'),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          },
        ),
      ),
    );
  }
}


