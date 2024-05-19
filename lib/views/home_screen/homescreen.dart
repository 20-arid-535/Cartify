import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cartify_app/common_widget/featurebtn.dart';
import 'package:cartify_app/common_widget/homebtn.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/consts/iconlist.dart';
import 'package:cartify_app/controller/homecontroller.dart';
import 'package:cartify_app/services/firestore_services.dart';
import 'package:cartify_app/views/category_screen/itemdetail.dart';
import 'package:cartify_app/views/home_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/productcontroller.dart';
import '../whishlist_screen/whishlist_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());
    var hcontroller=Get.put(HomeController());
    //var hcontroller=Get.find<HomeController>();
    return Container(
      padding: EdgeInsets.all(12),
    color: whiteColor,
    width: context.screenWidth,
    height: context.screenHeight,
    child: SafeArea(
      child: Column(children: [
        10.heightBox,
        Row(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                "Cartify".text.fontWeight(FontWeight.w900).size(20).make(),
                "5,000+ products and categories.".text.make(),
              ],
            ),
            50.widthBox,
           Image.asset(cartic).onTap(() {
            hcontroller.currentNavIndex.value=2;
            }),
           15.widthBox,
          Icon(Icons.favorite_outlined,
              color:Colors.red).onTap(() { 
                Get.to(()=>WhishlistScreen());
                }),
          ],
        ),
        10.heightBox,
Container(
  alignment: Alignment.center,
  height: 60,
  color: whiteColor,
  child: TextFormField(
    controller: hcontroller.searchcontroller,
    decoration: InputDecoration(
      
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(7)),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(7)),
     focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(7)),
     
      suffixIcon: Icon(Icons.search_sharp).onTap(() {
        if(hcontroller.searchcontroller.text.isNotEmpty){
        Get.to(()=>SearchScreen(title: hcontroller.searchcontroller.text,));
   } }),
      filled: true,
      fillColor: whiteColor,
      hintText: searchhint,
      hintStyle: TextStyle(
        color: textfieldGrey
      ),

    ),
  ),
),
10.heightBox,
Expanded(
  child: SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        VxSwiper.builder(
      aspectRatio: 16/9,
      autoPlay: true,
      height: 150,
      enlargeCenterPage: true,
      itemCount: sliderlist.length, 
      itemBuilder: (context,index){
      return Image.asset(sliderlist[index],
        fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
      
    }),
    10.heightBox,
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: List.generate(2, (index) => homebtn(
    //     context.screenHeight*0.15,
    //     context.screenWidth/2.5,
    //     index==0? icTodaysDeal:icFlashDeal,
    //     index==0? todaydeal:flashsale
    //   )),
    // ),
    // 10.heightBox,
    // VxSwiper.builder(
    //   aspectRatio: 16/9,
    //   autoPlay: true,
    //   height: 150,
    //   enlargeCenterPage: true,
    //   itemCount: secondsliderlist.length, 
    //   itemBuilder: (context,index){
    //   return Image.asset(secondsliderlist[index],
    //     fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
      
    // }),
    10.heightBox,
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: List.generate(3, (index) => homebtn(
    //     context.screenHeight*0.15,
    //     context.screenWidth/3.5,
    //     index==0? icTopCategories:index==1? icBrands:icTopSeller,
    //     index==0? topcategory:index==1? brand:topseller
    //      )),
    // ),
    // 20.heightBox,
    Align(
      alignment: Alignment.centerLeft,
      child: featurecategory.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
    20.heightBox,
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) => Column(
          children: [
            featurebtn(icon: featureimage1[index],title: featuretitle1[index]),
            10.heightBox,
            featurebtn(icon: featureimage2[index],title: featuretitle2[index])
          ],
        )).toList(),
      ),
    ),
    20.heightBox,
    Container(
      padding : EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: redColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          featuredproduct.text.white.fontFamily(bold).size(18).make(),
        10.heightBox,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: FirestoreServices.getfeatureproduct(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              
              if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),));
                    }
                      else if(snapshot.data!.docs.isEmpty){
          return Center(child: "No Feature Product".text.white.makeCentered(),);
        }
                    else{
                       var featuredata=snapshot.data!.docs;
              return Row(
                children: List.generate(featuredata.length, (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(featuredata[index]['p_imgs'][0],width: 150,height: 130,fit: BoxFit.cover,)),
                    10.heightBox,
                    "${featuredata[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                    10.heightBox,
                    "${featuredata[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                  ],
                ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(8)).make().onTap(() { Get.to(()=>ItemDetail(title: "${featuredata[index]['p_name']}",data: featuredata[index],));})),
              
              );}
            }
          ),
        )
        
        ],
      ),
    ),
     10.heightBox,
    VxSwiper.builder(
      aspectRatio: 16/9,
      autoPlay: true,
      height: 150,
      enlargeCenterPage: true,
      itemCount: secondsliderlist.length, 
      itemBuilder: (context,index){
      return Image.asset(secondsliderlist[index],
        fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
      
    }),
    20.heightBox,
    Align(
      alignment: Alignment.centerLeft,
      child: "All Products".text.size(18).fontFamily(bold).color(darkFontGrey).make(),
    ),
    20.heightBox,
   StreamBuilder(stream: FirestoreServices.allproduct(), builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot){
    if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),));
                    }
                    else{
   var allproductdata =snapshot.data!.docs;
    return  GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: allproductdata.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 300), itemBuilder: (context,index){
      return Column(
        
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(allproductdata[index]['p_imgs'][0],width: 200,height: 200,fit: BoxFit.cover,)),
                const Spacer(),
                "${allproductdata[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                10.heightBox,
                "${allproductdata[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
              ],
            ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.shadowSm.padding(EdgeInsets.all(12)).make().onTap(() {
              Get.to(()=>ItemDetail(title: "${allproductdata[index]['p_name']}",data: allproductdata[index],));
            });
    });}
   })
    
      ],
    ),
  ),
)
  ],
      )
    ),
  );
  }
}