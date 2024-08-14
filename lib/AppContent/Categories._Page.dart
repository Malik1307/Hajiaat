// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/Categories_Model.dart';
import 'package:shop/AppContent/Cubit/Cubit.dart';
import 'package:shop/AppContent/Cubit/CubitStates.dart';
import 'package:shop/Constants/Componants.dart';
import 'package:shop/Login/Login_Screen.dart';
import 'package:shop/SharedPref/CasheHelper.dart';

class Categories_Page extends StatelessWidget {
  const Categories_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => CategoresBuild(
                  cubit.categoriesModel!.Data!.Data[index], context),
              separatorBuilder: (context, index) => Container(
                    color: Colors.grey[200],
                    height: 2,
                  ),
              itemCount: cubit.categoriesModel!.Data!.Data.length),
        );
      },
    );
  }
}

Widget CategoresBuild(DataModelModel Model, context) {
  return InkWell(
    onTap: () {},
    child: Row(
      children: [
        Container(
            height: 150,
            width: 150,
            child: Image.network(
              Model.image!,
            )),
        SizedBox(
          width: 20,
        ),
        Text(
          Model.name!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: ShopCubit.get(context).DarkMode
                  ? Colors.white
                  : null), //bodytitle aw bodylabel aw keda
        ),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
      ],
    ),
  );
}
