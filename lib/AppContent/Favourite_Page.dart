// ignore_for_file: non_constant_identifier_names

/*
class Favourite_Page extends StatelessWidget {
  const Favourite_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
                  var favData = cubit.favPageModel?.data?.data ?? [];


          return ListView.builder(itemCount: cubit.favPageModel!.data!.data.length,
              itemBuilder: (context, index) =>
                  Favourite_build(cubit.favPageModel!.data!.data[index], context));
        });
  }
}

Widget Favourite_build(SecondData model, context) {
  ShopCubit cubit = ShopCubit.get(context);
  final product = model.Products;

  return Container(
    padding: EdgeInsets.all(20),
    height: 200,
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: 200,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Expanded(
                child: Image.network(
                  product?.image ?? '',
                  height: 200,
                  width: double.infinity,
                ),
              ),
              if (product?.discount != 0)
                Container(
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Save ${product?.discount}%",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${product?.price}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(width: 30),
                    if (product?.discount != 0)
                      Text(
                        '${product?.old_price?.round()}',
                        style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        cubit.Favorites_Data(model.id!, context);
                      },
                      icon: Icon(
                        cubit.Favorite[model.id ?? 0] ?? false
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
*/

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/Cubit/Cubit.dart';
import 'package:shop/AppContent/Cubit/CubitStates.dart';
import 'package:shop/AppContent/ModelPageFavorite.dart';
import 'package:shop/AppContent/color.dart';
import 'package:shop/Constants/Componants.dart';
import 'package:shop/Login/Login_Screen.dart';
import 'package:shop/SharedPref/CasheHelper.dart';

class Favourite_Page extends StatelessWidget {
  const Favourite_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);

          return state is Loading
              ? Center(child: CircularProgressIndicator())
              
              : cubit.fav_model == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.block,
                            color:   !ShopCubit.get(context).DarkMode?  Additional2:h,

                            size: 50,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "No Favorites Products To Display",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold,color: ShopCubit.get(context).DarkMode?Colors.white60:null),
                          )
                        ],
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => Container(
                            height: 1,
                            color: Colors.grey[200],
                          ),
                      itemCount: cubit.favPageModel!.data!.data.length,
                      itemBuilder: (context, index) => Favourite_build(
                          cubit.favPageModel!.data!.data[index], context));
        });
  }
}

Widget Favourite_build(SecondData Model, context) {
  ShopCubit cubit = ShopCubit.get(context);
  if (!(cubit.Favorite[Model.Products!.id] ?? false))
    return Container(
      height: 0.0000001,
      width: 0.0000001,
    );
  else
    return InkWell(
      onTap: () {
        print("Id" + (Model.Products!.id ?? 0).toString());
        print("Value" + (cubit.Favorite[Model.Products!.id ?? 0]).toString());
      },
      child: Container(
        padding: EdgeInsets.all(20),
        height: 200,
        color:cubit.DarkMode?Color.fromARGB(160, 0, 0, 0) : Colors.white,
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
                  Model.Products!.image !,
                  height: 900,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),


                if (Model.Products!.discount != 0)
                  Container(
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Save ${Model.Products!.discount}%",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  
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

                    Model.Products!.name ?? "",
                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                    color:   cubit.DarkMode?Colors.white:null
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
                        '${Model.Products!.price}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      // 3ayzoh ytrz3 fel Akher
                      // Spacer(),
                      SizedBox(
                        width: 30,
                      ),
                      if (Model.Products!.discount != 0)
                        Text(
                          '${Model.Products!.old_price.round()}',
                          style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            cubit.Favorites_Data(
                                Model.Products!.id ?? 0, context);
                            cubit.FavPage();
                          },
                          icon: Icon(
                            (cubit.Favorite[Model.Products!.id] ?? false)
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
