import 'package:cartify_app/common_widget/button.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      Divider(),
      10.heightBox,
      "Are you sue you want to exit?".text.size(16).color(darkFontGrey).make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btn((){
            SystemNavigator.pop();
          }, redColor, whiteColor, "yes"),
           btn((){
            Navigator.pop(context);
           }, redColor, whiteColor, "No"),
        ],
      )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}