import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/Cubit/Cubit.dart';
import 'package:shop/AppContent/Cubit/CubitStates.dart';
import 'package:shop/AppContent/Home.dart';
import 'package:shop/AppContent/Image.dart';
import 'package:shop/AppContent/Shop_Layout.dart';
import 'package:shop/AppContent/color.dart';
import 'package:shop/Login/Login_Screen.dart';
import 'package:shop/SharedPref/CasheHelper.dart';

import 'package:shop/OnBoarding.dart';
import 'package:shop/dio.dart';
import 'package:shop/observer.dart';

String? Token;

// اعمل المخطط الي انت عايزة ف الأخر
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AHA.init();
  Bloc.observer = MyBlocObserver();
  await DioHelp.initial();

  bool IsDark = await AHA.readData(key: "Mode") ?? false;
  print("Dark mode =" + IsDark.toString());

  bool FininshonBoarding = await AHA.readData(key: "Board") ?? false;

  Token = await AHA.readData(key: "token").then(
        (value) {
          print("Token: $value");
          print("Success");
          return value; // Make sure to return the value from the then block
        },
      ).catchError((onError) {
        print(onError.toString());
        Token = ""; // Return an empty string in case of an error
      }) ??
      'false';

  print(Token! + "Main Token");
  Widget StartPage;
  if (!FininshonBoarding) {
    StartPage = Onboarding();
  } else {
    if (Token == "false")
      StartPage = const LoginScreen();
    else
      StartPage = const Shop_Layout();
  }
  runApp(MyApp(
    isDark: IsDark,
    Page: StartPage,
  ));
}

class MyApp extends StatelessWidget {
  final Widget Page;

  bool isDark = true; //Edit

  MyApp({super.key, required this.Page, required this.isDark});

  @override
  Widget build(BuildContext context) {
    bool x = true;
    return BlocProvider(create: (context) => ShopCubit()
    ..ExtractData()
              ..Extract_Categories_Data()
              ..FavPage()
              ..Getuser(),
    
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          if (x == true) {
            ShopCubit.get(context).DarkMode = isDark;
            x = false;
          }
      
          return MaterialApp(
            home: Page,
            // home: Shop_Layout(),
            theme: ThemeData(
            
              // primarySwatch: 
              // ,
              // primaryColor: ,
                textTheme: TextTheme(bodyLarge: TextStyle()),
                // iconTheme: ,
                fontFamily: "NewFont",
                drawerTheme: DrawerThemeData(backgroundColor: PreDom2),
                appBarTheme: AppBarTheme(
                    backgroundColor: Dom,
                    iconTheme: IconThemeData(color: Colors.black),
                    actionsIconTheme: IconThemeData(color: Additional2)),
                scaffoldBackgroundColor: Dom,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Dom,
                    selectedItemColor: Additional2,
                    unselectedItemColor: Colors.grey)),
            themeMode: ShopCubit.get(context).DarkMode
                ? ThemeMode.dark
                : ThemeMode.light ?? ThemeMode.light,
      
            darkTheme: ThemeData(
              primaryColor: Colors.white,
      
              // iconButtonTheme: IconButtonThemeData(style: ButtonStyle(colo)),
              // actionIconTheme: ActionIconThemeData(backButtonIconBuilder: Colors.white),
              fontFamily: "NewFont",
              drawerTheme: DrawerThemeData(backgroundColor: t),
              textTheme:
                  TextTheme(bodyLarge: TextStyle(color: Colors.white70)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: t, unselectedItemColor: Colors.white24),
              scaffoldBackgroundColor: Color(0xff121212),
              appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.white), // App bar actions color (e.g., search icon)
                backgroundColor: Color(0xff1A1A2E),
      
                iconTheme: IconThemeData(color: Colors.white),
                // actionsIconTheme: IconThemeData(color: Colors.white)
              ),
            ),
      
            // home: Page,
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
