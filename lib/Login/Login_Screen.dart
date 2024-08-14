import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/Cubit/Cubit.dart';
import 'package:shop/AppContent/Home.dart';
import 'package:shop/AppContent/Shop_Layout.dart';
import 'package:shop/AppContent/color.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Constants/Componants.dart';
import 'package:shop/Login/Cubit/Cubit.dart';
import 'package:shop/Login/Cubit/CubitStates.dart';
import 'package:shop/Register/Register_Scree.dart';
import 'package:shop/SharedPref/CasheHelper.dart';
import 'package:shop/main.dart';
//جزئية ال فلديات ازودها

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var EmailController = TextEditingController();
    var PassController = TextEditingController();
    var KeyForm = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Scaffold(
          // appBar: AppBar(),
          body: Container(
            padding: const EdgeInsets.all(8),
            color: PreDom2,
            child: Center(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(20),
              // width: double.maxFinite,
              height: 500,
              child: Form(
                key: KeyForm,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "LOGIN",
                            // "LOGIN",
                            style: TextStyle(
                                letterSpacing: 3,
                                color: Additional2,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DefaultForm(
                            
                            label: "Email",
                            dtaPrefIcon: Icons.email,
                            controller: EmailController,
                            type: TextInputType.text,
                            validateor: (value) {
                              if (value.length == 0) {
                                return "Please enter an email address";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DefaultForm(
                              onFieldSubmitted: (value) {
                                if (KeyForm.currentState!.validate()) {
                                  cubit.Login(
                                      email: EmailController.text,
                                      password: PassController.text);
                                }
                              },
                              controller: PassController,
                              type: TextInputType.visiblePassword,
                              validateor: (value) {
                                if (value.length == 0) {
                                  return "Please enter a password";
                                }
                              },
                              Obscure: cubit.HiddenPassword,
                              label: "Password",
                              suff_func: () {
                                cubit.TogglePassword();
                              },
                              dtaPrefIcon: Icons.lock,
                              dtaSufIcon: Icon(
                                Icons.remove_red_eye,
                                color:
                                    cubit.HiddenPassword ? null : Colors.blue,
                              )),
                          const SizedBox(
                            height: 40,
                          ),
                          state is Loading
                              ? const Center(child: CircularProgressIndicator())
                              : DefaultButton(
                                  ButtonFunc: () {
                                    if (KeyForm.currentState!.validate()) {
                                      cubit.Login(
                                          email: EmailController.text,
                                          password: PassController.text);
                                    }
                                  },
                                  ButtonWidth: 300,
                                  isText: true,
                                  Title: "Login"),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextButton(
                            onPressed: () {},
                            text: "Forgot Password",
                          ),
                        ),
                        // const Spacer(),

                        const Text("Not a member yet ?"),
                        DefaultTextButton(
                          onPressed: () =>
                              NavigatReplace(context, const RegisterScreen()),
                          text: "Sign up",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )),
          ),
        );
      }, listener: (context, state) {
        if (state is Login_Success) if (state.Model!.status) {
          AHA.SavaData(key: "token", value: state.Model.data.token).then(
            (value) async {
              Token = state.Model.data.token;

              print("Tocken Login Success");
              print(state.Model.data.token);
              print(state.Model.data.token);
              print(state.Model.data.token);
              print(state.Model.data.token);
              print(state.Model.data.token);
              ShopCubit.get(context).Getuser();
              ShopCubit.get(context).DarkMode = false;

              NavigatReplace(context, const Shop_Layout());
            },
          );
          print("///////////////////////////////////////");
          print("${state.Model.message}");
          print(state.Model.data.name);
          print("///////////////////////////////////////");

          Snake(
              titleWidget: Text("${state.Model.message}"),
              context: context,
              EnumColor: Messages.Success);

          // Fluttertoast.showToast(
          //   msg: "${state.Model.message}",
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 4,
          //   backgroundColor: Colors.green,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        } else {
          print("///////////////////////////////////////");
          print(state.Model!.message);
          print("///////////////////////////////////////");
          Snake(
              titleWidget: Text("${state.Model.message}"),
              context: context,
              EnumColor: Messages.Error);

          // Fluttertoast.showToast(
          //   msg: state.Model.message,
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 4,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          //  K );
        }
      }),
    );
  }
}
