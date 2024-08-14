import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/Cubit/Cubit.dart';
import 'package:shop/AppContent/Cubit/CubitStates.dart';
import 'package:shop/AppContent/ModelPageFavorite.dart';
import 'package:shop/AppContent/Search_Model.dart';
import 'package:shop/Constants/Componants.dart';

class Search_Page extends StatelessWidget {
  const Search_Page({super.key});

  @override
  Widget build(BuildContext context) {
    var SearcController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);

          return Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              // backgroundColor: Colors.blue,
              // actionsIconTheme: IconThemeData(color: Colors.white),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DefaultForm(
                    isDark: true,
                      label: "Search",
                      controller: SearcController,
                      dtaPrefIcon: Icons.search,
                      onChanged: (String value) {
                        cubit.Search_Function(value);
                      }),
                  if (state is Loading)
                    Center(child: CircularProgressIndicator())
                  else if (cubit.ModelSearch?.data?.data == null)
                    Center(child: Text('No data available'))
                  else
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: Colors.grey[200],
                        ),
                        itemCount: cubit.ModelSearch!.data!.data.length,
                        itemBuilder: (context, index) => Favourite_build(
                          cubit.ModelSearch!.data!.data[index],
                          context,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}

Widget Favourite_build(FirstDataSearch Model, context) {
  ShopCubit cubit = ShopCubit.get(context);

  return InkWell(
    onTap: () {
      print("Id" + (Model.id ?? 0).toString());
      // print("Value" + (cubit.Favorite[Model.Products!.id ?? 0]).toString());
    },
    child: Container(
      padding: EdgeInsets.all(20),
      height: 200,
      // color: Colors.white,
      color:cubit.DarkMode? Color.fromARGB(160, 0, 0,0):null,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //حجم row بدل ال stack
        Container(
          height: 200,
          width: 200,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              //هام
              // Expanded(
              //   child: Image.network(
              //     Model.Products!.image??"",
              //     height: 200,
              //     width: double.infinity,
              //   ),
              // ),

              Image.network(
                Model.image ?? "",
                height: 900,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              // if (Model.discount != 0)
              //   Container(
              //     color: Colors.green,
              //     padding: EdgeInsets.symmetric(horizontal: 10),
              //     child: Text(
              //       "Save ${Model.discount}%",
              //       style: TextStyle(fontSize: 15),
              //     ),
              //   ),
            ],
          ),
        ), //infinty malhash lazama
        Expanded(
          child: Container(
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //padding heb2a a7sandd

                  Model.name ?? "",
                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
              color:      cubit.DarkMode?Colors.white:null
                      // height: 1.52
                      // fontSize: 14

                      ),
                ),
                // Container(
                //   height: 100,
                //   child: Spacer(
                //   ),
                // ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${Model.price}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    // 3ayzoh ytrz3 fel Akher
                    // Spacer(),
                    SizedBox(
                      width: 30,
                    ),
                    // if (Model.discount != 0)
                    //   Text(
                    //     '${Model.old_price.round()}',
                    //     style: TextStyle(
                    //         color: Colors.red,
                    //         decoration: TextDecoration.lineThrough),
                    //   ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          cubit.Favorites_Data(Model.id ?? 0, context);
                          cubit.FavPage();
                        },
                        icon: Icon(
                          (cubit.Favorite[Model.id] ?? false)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    ),
  );
}
