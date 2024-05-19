import 'package:cartify_app/common_widget/bg.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/consts/iconlist.dart';
import 'package:cartify_app/controller/productcontroller.dart';
import 'package:cartify_app/views/category_screen/categorydetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
   var controller=Get.find<ProductController>();
    return bg(
      child: Scaffold(
        appBar: AppBar(
          title: category.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200), itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(categoryimag[index],height: 120,width: 200,fit: BoxFit.cover,),
                10.heightBox,
                categorylist[index].text.color(darkFontGrey).align(TextAlign.center).make(),
              ],
            ).box.white.rounded.clip(Clip.antiAlias).outerShadowLg.make().onTap(() {
             controller.getCategories(categorylist[index]);
             
              Get.to(()=>CategoryDetsail(title: categorylist[index]));
            });
          }),
        ),
      )
    );
  }
}