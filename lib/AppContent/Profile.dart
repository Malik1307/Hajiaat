import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/Cubit/Cubit.dart';
import 'package:shop/AppContent/Cubit/CubitStates.dart';
import 'package:shop/Constants/Componants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
//Validate Lokal Field Kowais
  @override
  Widget build(BuildContext context) {
    var emailcontoller = TextEditingController();
    var passwordController = TextEditingController();
    var phoneContoller = TextEditingController();
    var nameContoller = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(builder: (context, state) {
      var cubit = ShopCubit.get(context);
      // if(cubit.ModelLogin==null)
      // {
      //   return Center(child: CircularProgressIndicator());
      // }

      // Debug print to check the current state
      print("Current State: $state");

      // Set up controllers
      if (cubit.ModelLogin != null && cubit.ModelLogin!.data != null) {
        //==null?circular Progress
        emailcontoller.text = cubit.ModelLogin!.data!.email !;
        nameContoller.text = cubit.ModelLogin!.data!.name !;
        phoneContoller.text = cubit.ModelLogin!.data!.phone !;
      } else {
        // Print error message if ModelLogin or its data is null
        print("ModelLogin or its data is null");
      }
      var FormKey = GlobalKey<FormState>();
      final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      final RegExp phoneRegExp = RegExp(
        r'^\+?(\d{1,4})?[-.\s]?(\(?\d{1,4}\)?)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$',
      );

      return Scaffold(
        appBar: AppBar(),
        body: cubit.ModelLogin == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: FormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (state is Update_Loading) LinearProgressIndicator(),
                        if (state is Update_Loading)
                          SizedBox(
                            height: 15,
                          ),
                        // cubit.ModelLogin!.data!.image==null?
                        ClipOval(
                          child: Image.asset(
                              cubit.DarkMode
                                  ? "Images/An3.png"
                                  : "Images/download.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover),
                        )
                        //   ClipOval(
                        //   child: Image.file(cubit.ModelLogin!.data!.image,
                        //       height: 150, width: 150, fit: BoxFit.cover),
                        // ),
                        ,
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          cubit.ModelLogin!.data!.name !,
                          style: TextStyle(
                              color: cubit.DarkMode ? Colors.white : null,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        DefaultForm(
                          isDark: cubit.DarkMode,
                          validateor: (value) {
                            if (value.isEmpty) {
                              return "Field cannot be empty";
                            } else {
                              return null; // Form is valid.
                            }
                          },
                          label: "Name",
                          dtaPrefIcon: Icons.person,
                          controller: nameContoller,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DefaultForm(
                          isDark: cubit.DarkMode,
                          validateor: (value) {
                            if (value.isEmpty) {
                              return "Field cannot be empty";
                            }
                            if (!emailRegExp.hasMatch(value)) {
                              return "Invalid email format";
                            } else {
                              return null; // Form is valid.
                            }
                          },
                          enabled: false,
                          label: "email",
                          dtaPrefIcon: Icons.email,
                          controller: emailcontoller,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DefaultForm(
                          isDark: cubit.DarkMode,
                          validateor: (Value) {
                            /*لازم نرتيرن نال ف الأخر؟ */
                            if (Value.isEmpty)
                              return "Field cannot be empty";
                            else if (!phoneRegExp.hasMatch(Value)) {
                              return "Invalid phone number format";
                            } else {
                              return null; // Form is valid.
                            }
                          },
                          label: "Phone",
                          dtaPrefIcon: Icons.phone_android,
                          controller: phoneContoller,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        DefaultButton(
                          isText: true,
                          ButtonWidth: 300,
                          ButtonFunc: () {
                            if (FormKey.currentState!.validate()) {
                              cubit.UpdateProfile(
                                name: nameContoller.text,
                                phone: phoneContoller.text,
                                email: emailcontoller.text ?? "",
                              );
                            }
                          },
                          Title: "Update",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    }, listener: (context, index) {
      if (index is Update_Success) {
        Snake(
            titleWidget: Text("Updated Successfully"),
            context: context,
            EnumColor: Messages.Success);
        // emailcontoller.text = index.ModelUpdate!.data!.email??"";
        // nameContoller.text = index.ModelUpdate!.data!.name??"";
        // phoneContoller.text = index.ModelUpdate!.data!.phone??"";
      }
    });
  }
}
