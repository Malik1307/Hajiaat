import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/About_App.dart';
import 'package:shop/AppContent/Cubit/Cubit.dart';
import 'package:shop/AppContent/Cubit/CubitStates.dart';
import 'package:shop/AppContent/Profile.dart';
import 'package:shop/AppContent/Search.dart';
import 'package:shop/AppContent/color.dart';
import 'package:shop/Constants/Componants.dart';
import 'package:shop/Login/Login_Screen.dart';
import 'package:shop/SharedPref/CasheHelper.dart';
import 'package:shop/main.dart';

//sign out function
class Shop_Layout extends StatelessWidget {
  const Shop_Layout({super.key});

  @override
  Widget build(BuildContext context) {
    var ScreenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          drawer: Drawer(
            
            // backgroundColor: cubit.DarkMode ? t : PreDom2,
            width: ScreenWidth / 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              // color: Colors.grey[200],
              // width: 50,

              child: ListView(
                children: [
                
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () => Navigat(context, Profile()),
                    leading: Icon(
                      Icons.person,
                      color: cubit.DarkMode ? Colors.white70 : null,
                    ),
                    title: Text(
                      "Profile",
                                           style: Theme.of(context).textTheme.bodyLarge,

                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  ListTile(
                    onTap: () {
                      cubit.changeMode();
                      AHA.SavaData(key: "Mode", value: cubit.DarkMode);
                      print("object");
                    },
                    leading: cubit.DarkMode
                        ? Icon(
                            Icons.light_mode,
                            color: Colors.white70,
                          )
                        : Icon(Icons.dark_mode),
                    title: Text(
                      cubit.DarkMode ? "Light Mode" : "Dark Mode",
                                          style: Theme.of(context).textTheme.bodyLarge,

                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  ListTile(
                    onTap: () {
                      Navigat(context, AboutApp());
                    },
                    leading: Icon(
                      Icons.keyboard_double_arrow_up_sharp,
                      color: cubit.DarkMode ? Colors.white70 : null,
                    ),
                    title: Text(
                      "About App",
                      style: Theme.of(context).textTheme.bodyLarge,
                      // style: TextStyle(
                      //   fontSize: 15,
                      //   // color: cubit.DarkMode ? Colors.white70 : null,
                        
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  ListTile(
                    onTap: () => AHA.clearvalue(key: "token").then(
                          (value) => NavigatReplace(context, LoginScreen()),
                        ),
                    leading: Icon(
                      Icons.exit_to_app,
                      color: cubit.DarkMode ? Colors.white70 : null,
                    ),
                    title: Text(
                      "Log Out",
                                          style: Theme.of(context).textTheme.bodyLarge,

                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),

            //   onPressed: () {
            // ScaffoldKey.currentState!.openDrawer();
            //   },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.CurrentIndex,
            onTap: (value) {
              cubit.BottomVav(value);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favourites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: "Categories"),
            ],
          ),
          appBar: AppBar(
            
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: ScreenWidth / 5.3,
                // ),
                Image.asset("Images/635775-200.png",width: 30,height: 30,color:cubit.DarkMode? Colors.white:null,),
                Text(
                  "HAJIAAT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Additional2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    // fontStyle: FontStyle.italic
                    // decoration: TextDecoration.underline
                    // shadows: [Shadow.lerp(4, b, t)??""]
                    // fontVariations: [FontVariation(, value)]
                  ),
                )
              ],
            ),
            // centerTitle: true,
            actions: [
              DefaultButton(
                ButtonFunc: () {
                  Navigat(context, Search_Page());
                },
                isText: false,
                ButtonWidth: 0,
                ButtonIcon: Icon(
                  Icons.search,
                  color: cubit.DarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          body: cubit.Pages[cubit.CurrentIndex],
        );
      },
    );
  }
}
