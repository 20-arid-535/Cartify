import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/views/category_screen/categorydetail.dart';
import 'package:cartify_app/views/category_screen/categoryscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Widget featurebtn({String? title,icon}){
  return Row(
    children: [
      Image.asset(icon,width:60,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).white.padding(EdgeInsets.all(4)).roundedSM.outerShadowSm.make().onTap(() {
    Get.to(()=>CategoryDetsail(title: title));
  });
}