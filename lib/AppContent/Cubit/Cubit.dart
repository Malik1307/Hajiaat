import 'dart:ffi';
//Ask GPT
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/Categories._Page.dart';
import 'package:shop/AppContent/Categories_Model.dart';
import 'package:shop/AppContent/Cubit/CubitStates.dart';
import 'package:shop/AppContent/Cubit/Favorites_Model.dart';
import 'package:shop/AppContent/Favourite_Page.dart';
import 'package:shop/AppContent/Home.dart';
import 'package:shop/AppContent/ModelPageFavorite.dart';
import 'package:shop/AppContent/Products_Model.dart';
import 'package:shop/AppContent/Search_Model.dart';
import 'package:shop/AppContent/Update_Model.dart';
import 'package:shop/Constants/Componants.dart';
import 'package:shop/Login/Cubit/Cubit.dart';
import 'package:shop/Login/ExtractData.dart';
import 'package:shop/dio.dart';
import 'package:shop/main.dart';
//تصليح كل الفاريابولز وعدم تكرار السيم العبيط ده بذا المنظر

/*

  طريقتين علشان اوصل للمودل الي تحت 
   ابعته مع ستات ال ساكسيس واخده ف الليسن هناك او احطه جلوبال ف ال كيوبيت وهوصله هناك من البيلدر

 */
//ctrl+alt
class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(Initial());
  List Pages = [
    const Home(),
    const Favourite_Page(),
    const Categories_Page(),
  ];
  bool DarkMode = false;
  void changeMode() {
    DarkMode = !DarkMode;
    emit(Change_Mode());
  }

  static ShopCubit get(context) => BlocProvider.of(context);
  Search_Model? ModelSearch;

  int CurrentIndex = 0;
  void BottomVav(value) {
    CurrentIndex = value;
    if (CurrentIndex == 1) FavPage();

    emit(Bottom_Navigation());
  }

  ProductModel? model; //ShopCubit between late and ? !
  Categories_Model? categoriesModel; //ShopCubit between late and ? !

  Map<int, bool> Favorite = {};

  FavouriteModel? fav_model;
  
  void ExtractData() async {
    // emit(Loading());

    await DioHelp.ReadData(path: "home", token: Token).then(
      (value) {
        // Print the raw data returned by the API
        // print("Raw API data: ${value.data}");

        // Parse the data into the model
        model = ProductModel.Extract(value.data);
        for (var element in model!.data.products) {
          Favorite.addAll({element.id: element.in_favorites});
        }
        print(Favorite.toString());
        print("${Token!}Tocken cubit");
        // print();
        // Print parsed model data to ensure it matches expectations
        // print("Status: ${model!.status}");
        // print("Banners count: ${model!.data.banners.length}");
        // if (model!.data.banners.isNotEmpty) {
        //   print("First banner ID: ${model!.data.banners[0].id}");
        // }C
        // print("Products count: ${model!.data.products.length}");
        // if (model!.data.products.isNotEmpty) {
        //   print("First product ID: ${model!.data.products[0].id}");
        // }

        emit(Extract_Data_Success());
      },
    ).catchError((error) {
      print("$error\n\n\n\n\n\n\n\n\n\n");
      emit(Extract_Data_Errro());
    });
  }

  void Extract_Categories_Data() async {
    // emit(Loading());

    await DioHelp.ReadData(path: "categories").then(
      (value) {
        categoriesModel = Categories_Model.Extract(value.data);

        emit(Extract_Categories_Data_Success());
      },
    ).catchError((error) {
      print("Errrrror$error");
      emit(Extract_Categories_Data_Errro());
    });
  }

  void Favorites_Data(int id, context) async {
    // if (Favorite[id] == null) {
    //   Favorite[id] = false;
    // }

    Favorite[id] = !(Favorite[id] ?? false);
    emit(change_Favorite_state_success());

    try {
      final value = await DioHelp.postData(
        path: "favorites",
        data: {'product_id': '$id'},
        token: Token,
      );
      fav_model = FavouriteModel.Extract(value.data);

      // Ensure fav_model is not null and has a status property
      if (fav_model != null && fav_model!.status) {
        emit(Favoritee_Success());
      } else {
        print(fav_model!.status);
        print(fav_model!.message);
        // Revert the change if the operation was not successful
        Favorite[id] = !(Favorite[id] ?? false);
        emit(change_Favorite_state_error(fav_model!.message));
      }
    } catch (error) {
      // Handle network or other errors
      Favorite[id] = !(Favorite[id] ?? false);
      // Revert the local change
      print(error.toString());
      print("/////////////////////////////////");
      emit(Favoritee_Error(error.toString()));
    }
  }

  FavPageModel? favPageModel;

  void FavPage() async {
    emit(Loading());

    await DioHelp.ReadData(path: "favorites", token: Token).then(
      (value) {
        favPageModel = FavPageModel.Extract(value.data);

        emit(Favorite_Page_Model_Success());
      },
    ).catchError((error) {
      print("Errrrror$error");
      emit(Favorite_Page_Model_Error());
    });
    favPageModel ?? (products: []);
  }

  LoginModel? ModelLogin;
  void Getuser() async {
    emit(Loading());
    // emit(Update_Loading());

    await DioHelp.ReadData(path: "profile", token: Token).then(
      (value) {
        ModelLogin = LoginModel.ExtractData(value.data);
        print(ModelLogin!.data!.name);

        emit(UserData_Success());
      },
    ).catchError((error) {
      print("Errrrror$error");
      emit(UserData_Error());
    });
  }

  void Search_Function(text) {
    DioHelp.postData(path: "products/search", data: {"text": "$text"}).then(
      (value) {
        ModelSearch = Search_Model.Extract(value.data);

        emit(Search_Success());
      },
    ).catchError((Error) {
      print(Error.toString());
      emit(Search_Error());
    });
  }

  Update? ModelUpdate;
  void UpdateProfile({required name, required phone, required email}) {
    DioHelp.PutData(
        token: Token,
        path: "update-profile",
        data: {"name": '$name', 'phone': '$phone', 'email': '$email'}).then(
      (value) async {
        emit(Update_Loading());
        await Future.delayed(Duration(seconds: 1));

        if (ModelLogin != null)
          //ليه ال MOdelLogin wehowa feh token
          ModelUpdate = Update.Extract(value.data) ?? null;
        //GetUser  تشوف حل انه مبيلقطش بسرعة الا لو وحدت المودلس
        Getuser();//لعيب كبير
        emit(Update_Success(ModelLogin));
      },
    ).catchError((Error) {
      print(Error);
      emit(Update_Error());
    });
  }
}


  

/*  FavPageModel? favPageModel;

  void FavPage() async {

    // emit(Loading());

    await DioHelp.ReadData(path: "favorites",token: Token).then(
      (value) {
        favPageModel = FavPageModel.Extract(value.data);

        emit(Favorite_Page_Model_Success());
      },
    ).catchError((error) {
      print("Errrrror$error");
      emit(Favorite_Page_Model_Error());
    });
    favPageModel ?? (products: []);



     if (favPageModel == null || favPageModel!.data == null) {
    favPageModel = FavPageModel.Extract({
      "status": false,
      "data": {
        "current_page": 0,
        "data": [],
        // Other necessary fields
      }
    });
  } */

/*d
late ProductModel Model;
  void ExtractData() async{
    emit(Loading());

  await  DioHelp.ReadData(path: "home", token: Token).then(
      (value) {
        Model = ProductModel.Extract(value.data);
        print(Model.data.banners[0].id.toString());
        print(Model.status);
        print(Model.status);
        print(Model.status);
        print(Model.status);
        print(Model.status);
        emit(Extract_Data_Success());
      },
    ).catchError((Error) {
      print("$Error\n\n\n\n\n\n\n\n\n\n");
      emit(Extract_Data_Errro());
    });
  }
 */