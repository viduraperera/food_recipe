import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe/index.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(EasyLocalization(
      //initialize the language and the path
      supportedLocales: const [Locale('en', 'UK')],
      fallbackLocale: const Locale('en', 'UK'),
      path: 'assets/locales',
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food recipe app',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Quicksand',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: mySystemTheme,
          child: const ResponsiveProvider(
            child: SplashScreen(),
          ),
        ),
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
      ),
    );
  }
}

List<SingleChildWidget> providers = [
  //initializing the providers in the main
  ChangeNotifierProvider<MealProvider>(create: (_) => MealProvider()),
  ChangeNotifierProvider<AddMealProvider>(create: (_) => AddMealProvider()),
  ChangeNotifierProvider<UpdateMealProvider>(create: (_) => UpdateMealProvider()),

  ChangeNotifierProvider<UpdateMealProvider>(
      create: (_) => UpdateMealProvider()),
  ChangeNotifierProvider<BakedItemProvider>(create: (_) => BakedItemProvider()),
  ChangeNotifierProvider<AddBakedItemProvider>(
      create: (_) => AddBakedItemProvider()),
  ChangeNotifierProvider<UpdateBakeItemProvider>(
      create: (_) => UpdateBakeItemProvider()),

   //Desserts
  ChangeNotifierProvider<DessertProvider>(create: (_) => DessertProvider()),
  ChangeNotifierProvider<AddDessertProvider>(create: (_) => AddDessertProvider()),
  ChangeNotifierProvider<UpdateDessertProvider>(create: (_) => UpdateDessertProvider()),
];
