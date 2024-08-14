import 'package:flutter/material.dart';
import 'package:shop/AppContent/color.dart';

Widget DefaultForm(
    {required label,
  enabled=true,
  isDark=false,

    onChanged,
    dtaPrefIcon,
    suff_func,
    dtaSufIcon,
    controller,
    validateor,
    onFieldSubmitted,
    Obscure = false,
    type}) {
  return SizedBox(
    // width: 400,
    height: 70,

    child: TextFormField(
      // focusNode: FocusNode(),
      
    
      enabled:enabled ,
      onChanged:onChanged ??null,
      keyboardType: type,
      // readOnly: readOnly,

      ///عدل كسم الانواع دي
      obscureText: Obscure,
      onFieldSubmitted: onFieldSubmitted,
      validator: validateor,
      controller: controller,
      style: isDark?TextStyle(color: Colors.white,fontFamily: ''):TextStyle(fontFamily: 'no'),
      decoration: InputDecoration(
        label: Text(label,style: TextStyle(color:isDark?Colors.white:null ) ),
        border: const OutlineInputBorder(),
        suffixIcon: dtaSufIcon == null
            ? null
            : IconButton(
                icon: dtaSufIcon,
                onPressed: suff_func,
              ),
        prefixIcon: dtaPrefIcon == null
            ? null
            : Icon(dtaPrefIcon,color: isDark?Colors.white:null,), // Use prefixIcon instead of prefix
      ),
    ),
  );
}

Widget DefaultButton(
    {required ButtonFunc,
    required isText,
    Title,
    ButtonIcon,
    required double ButtonWidth}) {
  return ButtonWidth==0?MaterialButton(
    minWidth: 0,
    
    
      onPressed: ButtonFunc,
      child: isText == null
          ? null
          : isText
              ? Title == null
                  ? null
                  : Text(
                      Title,
                      style: const TextStyle(color: Colors.white),
                    )
              : ButtonIcon,
    ): 
    Container(
    decoration: BoxDecoration(
        color: Additional2,
        borderRadius: BorderRadius.circular(20)),
    height: 50,
    width: ButtonWidth,
    child: MaterialButton(
      
      onPressed: ButtonFunc,
      child: isText == null
          ? null
          : isText
              ? Title == null
                  ? null
                  : Text(
                      Title,
                      style: const TextStyle(color: Colors.white),
                    )
              : ButtonIcon,
    ),
  );
}

NavigatReplace(context, TargetPage) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => TargetPage,
  ));
}

Navigat(context, TargetPage) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => TargetPage,
  ));
}

Widget DefaultTextButton({required onPressed, required text}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(text,style: TextStyle(color: Additional2),),
  );
}

Snake({required titleWidget, required context,required EnumColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: SnakeColor(EnumColor),
    duration: Duration(seconds: 1),
    content: titleWidget,
  ));
}

enum Messages { Success, Warning, Error }

Color SnakeColor(Messages EnumColor) {
  switch (EnumColor) {
    case Messages.Success:
      return Colors.green;

    case Messages.Warning:
      return Colors.yellow;

    case Messages.Error:
      return Colors.red;

    default:
      return Colors.grey;
  }
}
