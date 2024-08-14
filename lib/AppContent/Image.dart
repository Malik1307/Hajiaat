// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shop/AppContent/Shop_Layout.dart';
// import 'package:shop/Constants/Componants.dart';
// import 'package:shop/Login/Cubit/Cubit.dart';
// import 'package:shop/Login/Cubit/CubitStates.dart';
// import 'package:shop/Register/Register_Scree.dart';
// import 'package:shop/main.dart';

// var imagepick = ImagePicker();
// File? pickedImage;

// class Imagepick extends StatefulWidget {
//   const Imagepick({super.key});

//   @override
//   State<Imagepick> createState() => _ImagepickState();
// }

// class _ImagepickState extends State<Imagepick> {
//   @override
//   Widget build(BuildContext context) {
//     // String choosenImage=""

//     return BlocProvider(
//       create: (context) => LoginCubit(),
//       child: BlocConsumer<LoginCubit, LoginStates>(
//         builder: (context, state) {
//           return Scaffold(
//               appBar: AppBar(),
//               body: Container(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Center(
//                         child: ClipOval(
//                       child: pickedImage != null
//                           ? ClipOval(
//                               child: Image.file(
//                                   pickedImage ??
//                                       File(
//                                           "https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg"),
//                                   width: 200,
//                                   height: 200,
//                                   fit: BoxFit.cover),
//                             )
//                           : Image.asset(
//                               fit: BoxFit.cover,
//                               "Images/6.jpg",
//                               height: 200,
//                               width: 200,
//                             ),
//                     )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     DefaultButton(
//                       ButtonFunc: () {
//                         PickAnImageProfile(ImageSource.camera);
//                       },
//                       isText: true,
//                       ButtonWidth: 200,
//                       Title: "Pick An Image Profile",
//                     ),
//                     Spacer(),
//                     Align(
//                         alignment: Alignment.bottomRight,
//                         child: DefaultTextButton(
//                           onPressed: () {
//                           //   LoginCubit.get(context).SendRegister(
//                           //   name:    nameController.text,
//                           //     email:   emailController.text,
//                           // phone:       phoneController.text,
//                           // password:       passwordController.text,

//                           //   // image:     pickedImage!.path
//                           //   );
//                           //   NavigatReplace(context, Shop_Layout());
//                           },
//                           text: Text(pickedImage == null
//                               ? "Skip"
//                               : "Finish Registration "),
//                         ))
//                   ],
//                 ),
//               ));
//         },
//         listener: (context, state) {},
//       ),
//     );
//   }

//   Future PickAnImageProfile(ImageSource source) async {
//     var image = await imagepick.pickImage(source: source);
//     if (image != null) {
//       pickedImage = File(image.path);
//       setState(() {});
//     }
//   }
// }
