import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:provider/provider.dart';

class AddNewDessert extends StatefulWidget {
  const AddNewDessert({Key? key}) : super(key: key);

  @override
  State<AddNewDessert> createState() => _AddNewDessertState();
}

class _AddNewDessertState extends State<AddNewDessert> {
  final TextEditingController titleControllerDesserts = TextEditingController();
  final TextEditingController detailControllerDessert = TextEditingController();
  final TextEditingController commentControllerDessert = TextEditingController();
  final TextEditingController tempControllerDessert = TextEditingController();
  final TextEditingController prepTimeControllerDessert = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Widget> ingInput = [];
  List<Widget> stpInput = [];
  List<RecipeStep> recipeSteps = [];
  List<IngredientItem> ingredients = [];
  int ingIndex = 0;
  int stpIndex = 0;

  Widget inputField(label, id) {
    final _ctrl = TextEditingController();
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
    final rpDessertdl = Provider.of<DessertProvider>(context, listen: false);
    final addDesserts = Provider.of<AddDessertProvider>(context, listen: false);
    double r = UIManager.ratio;

    InputField titleField = InputField(
      hint: 'single_recipe_dessert.name'.tr(),
      controller: titleControllerDesserts,
      onChanged: (val) {
        print(val);
      },
    );

    InputField commentField = InputField(
      hint: 'single_recipe_dessert.short_description'.tr(),
      // maxLength: 2,
      controller: commentControllerDessert,
    );

    InputField detailField = InputField(
        hint: 'single_recipe_dessert.description'.tr(),
        maxLength: null,
        type: TextInputType.multiline,
        controller: detailControllerDessert,
        isMulti: true);

    InputField tempField = InputField(
      hint: 'single_recipe_dessert.temp'.tr(),
      controller: tempControllerDessert,
    );

    InputField prepTimeField = InputField(
      hint: 'single_recipe_dessert.preparation_time'.tr(),
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
            onTap: () async {
              setState(() {
                //   // validate = true;
              });
              print(titleControllerDesserts.text);
              formKey.currentState!.save();
              if (formKey.currentState!.validate()) {
                await addDesserts.uploadImageToFirebase(context: context,
                    name: titleControllerDesserts.text,
                    sub: commentControllerDessert.text,
                    ing: ingredients,
                    des: detailControllerDessert.text,
                    stp: recipeSteps,
                    temp: tempControllerDessert.text,
                    pre: prepTimeControllerDessert.text
                );
                rpDessertdl.loadAllDesserts();
              }
            }),
      ),
    );
  }
}
