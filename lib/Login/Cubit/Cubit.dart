import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Login/ExtractData.dart';
import 'package:shop/Login/Cubit/CubitStates.dart';
import 'package:shop/dio.dart';

LoginModel? login;

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(initial());
  bool HiddenPassword = true;


  LoginModel? registermodel;
  void SendRegister({String ?name, email, phone, password}) {
    emit(Loading());
    DioHelp.postData(path: "register", data: {
      "name": "$name",
      "phone": "$phone",
      "email": "$email",
      "password": "$password",
      // "image": "$image"??"Images/l-intro-1679582548.jpg"
    }).then(
      (value) {
        print("name:" +
            name! +
            " email:" +
            email +
            " password:" +
            password +
            "phone" +
            phone);
        registermodel = LoginModel.ExtractData(value.data);
        print(registermodel.toString());

        
        emit(Register_Success(registermodel!));

      },
    ).catchError((onError) {
      print(onError.toString());
      emit(Register_Failed());
    });
  }

  // void saveskipped() {
  //   FinishOnBoard = AHA.readData(key: "OnBoarding")!;
  //   print("++++++++++++++++++++++++++++++++++++++++++++++");
  //   print(FinishOnBoard);
  //   print("++++++++++++++++++++++++++++++++++++++++++++++");
  //   emit(Save_Skipped());
  // }

  static LoginCubit get(k) => BlocProvider.of(k);

  TogglePassword() {
    HiddenPassword = !HiddenPassword;

    emit(Toggle_Password());
  }

  void Login({required email, required password}) async {
    emit(Loading());

    await DioHelp.postData(path: "login", data: {
      "email": "$email", //
      "password": "$password"
    }).then(
      (value) {
        // print(login.message.toString());
        // print(login.dat.)
        // print(login.dat.)
        login = LoginModel.ExtractData(value.data);
        print("################################");
        print("################################");

        emit(Login_Success(login));
      },
    ).catchError((error) {
      print(error.toString());
      emit(Login_Failed(error.toString()));
    });
  }
}
