import 'package:cartify_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homebtn(height,width,icon,String? title){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset(icon,width: 26,),
    10.heightBox,
    title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}