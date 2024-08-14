// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/Categories_Model.dart';
import 'package:shop/AppContent/Cubit/Cubit.dart';
import 'package:shop/AppContent/Cubit/CubitStates.dart';
import 'package:shop/AppContent/Products_Model.dart';
import 'package:shop/Constants/Componants.dart';
import 'package:shop/Login/Login_Screen.dart';
import 'package:shop/SharedPref/CasheHelper.dart';
import 'package:shop/main.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is Favoritee_Error) {
          Snake(
              titleWidget: Text('${state.messgae.toString()}',),
              context: context,
              EnumColor: Messages.Error);
        }
          if (state is change_Favorite_state_error) {
          Snake(
              titleWidget: Text('${state.messgae.toString()}'),
              context: context,
              EnumColor: Messages.Error);
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return cubit.model == null || cubit.categoriesModel == null
            ? Center(child: CircularProgressIndicator())
            : Home_Product_Builder(cubit.model, cubit.categoriesModel,context);
      },
    );
  }
}

Widget Home_Product_Builder(
    ProductModel? Model, Categories_Model? categoryModel,context) {
      var cubit=ShopCubit.get(context);
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DefaultTextButton(
        //     onPressed: () {
        //       print(Token);
        //       print(Token);
        //       print(Token);
        //       print(Token);
        //       print(Token);
        //       print(Token);
        //       print(Token);
        //       AHA.clearvalue(key: "Token");
        //     },
        //     text: Text("CLick Me")),
        CarouselSlider(
            // items: cubit.model!.data.banners.map((element) {
            //   return Image.network(element.image);
            // }).toList(),
            items: [
              for (BannerModel banner in Model!.data.banners)
                Image.network(
                  banner.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                )
            ],
            options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 1,
                //reverse: false
                // enableInfiniteScroll: true,
                height: 300,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn

                //height ,initialpage,reverse,scroll,autoplay its interval,anaimation,curve,view

                )),
        SizedBox(
          height: 10,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: cubit.DarkMode?Colors.white:null),
            )),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 100,
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    CategoryProductScroll(categoryModel.Data!.Data[index]),
                separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                itemCount: categoryModel!.Data!.Data.length)),
        SizedBox(
          height: 20,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text("New Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: cubit.DarkMode?Colors.white:null))),
                SizedBox(height: 10,),
        //singlechildscrollview
        //شيل ال expanded واكتفي بال shrinkwrap
        Container(
     color:     cubit.DarkMode?  Colors.grey[800]:null,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.58),
            itemCount: Model.data.products.length,
            itemBuilder: (context, index) =>
                ProudctBuilder(Model.data.products[index], context),
          ),
        )
      ],
    ),
  );
}

Widget ProudctBuilder(ProductModelModel Model, BuildContext context) {
  ShopCubit cubit = ShopCubit.get(context);
  return Container(
    color:cubit.DarkMode? Color.fromARGB(160, 0, 0, 0):Colors.white,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.network(
            Model.image,
            height: 200,
            width: double.infinity,
          ),
          if (Model.discount != 0)
            Container(
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Save ${Model.discount}%",
                style: TextStyle(fontSize: 15),
              ),
            ),
        ],
      ), //infinty malhash lazama
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //padding heb2a a7sandd

              Model.name,
              maxLines: 2,

              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  // height: 1.52
                  // fontSize: 14
color:   cubit.DarkMode?Colors.white:null

                  ),
            ),
            SizedBox(
              height: 5,
            ),
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
                if (Model.discount != 0)
                  Text(
                    '${Model.old_price.round()}',
                    style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      cubit.Favorites_Data(Model.id, context);
                    },
                    icon: Icon(
                      cubit.Favorite[Model.id] ?? false
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Colors.blue,
                    ))
              ],
            ),
          ],
        ),
      ),
    ]),
  );
}

Widget CategoryProductScroll(DataModelModel Model) {
  return InkWell(
    onTap: () {},
    child: Container(
      width: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
            Model.image!,
            width: 100,
            height: 100,
          ),
          Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                Model.name!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ))
        ],
      ),
    ),
  );
}
