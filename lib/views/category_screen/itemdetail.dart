import 'dart:ffi';

import 'package:cartify_app/common_widget/button.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/consts/iconlist.dart';
import 'package:cartify_app/controller/productcontroller.dart';
import 'package:cartify_app/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ItemDetail extends StatelessWidget {
  final String? title;
final  dynamic data;
  const ItemDetail({Key? key,required this.title,this.data}):super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<ProductController>();
    return WillPopScope(
      onWillPop: ()async{
        controller.resetvalue();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            controller.resetvalue();
            Get.back();
          }, icon: Icon(Icons.arrow_back)),
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            
            IconButton(onPressed: (){}, icon: Icon(Icons.share)),
            Obx(
              ()=> IconButton(onPressed: (){
                if(controller.isfav.value){
                  controller.removefromwhishlist(data.id);
                  
                }
                else{
                  controller.addtowhishlist(data.id);
                  
                }
              }, icon: Icon(Icons.favorite_outlined,
              color:controller.isfav.value?Colors.red:darkFontGrey ,)),
            ),
          ],
        ),
        body: Column(
          children: [
          Expanded(
            child: Padding(
           padding: EdgeInsets.all(8),
           child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VxSwiper.builder(
                  autoPlay: true,
                  height: 350,
                  viewportFraction: 1.0,
                  aspectRatio: 16/9,
                  itemCount: data['p_imgs'].length, 
                  itemBuilder: (context, index) {
                  return Image.network(data['p_imgs'][index],width: double.infinity,fit: BoxFit.cover,);
                }),
                10.heightBox,
                title!.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                10.heightBox,
                VxRating(
                  isSelectable: false,
                  value: double.parse(data['p_rating']),
                  onRatingUpdate: (Value){},normalColor: textfieldGrey,selectionColor: golden,count: 5,size: 25,maxRating: 5,),
                10.heightBox,
                "${data['p_price']}"!.numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['p_seller']}".text.white.fontFamily(semibold).make(),
                        5.heightBox,
                        "In House Brand".text.fontFamily(semibold).color(darkFontGrey).make(),
                      ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.message_rounded,color: darkFontGrey,),
                    ).onTap(() {Get.to(()=>ChatScreen(),
                    arguments: [data['p_seller'],data['vendor_id']],
                    );})
                  ],
                ).box.height(60).padding(EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),
                20.heightBox,
                Obx(
                  ()=> Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(children: [
                        
                        SizedBox(
                          width: 100,
                          child: "Color: ".text.color(textfieldGrey).make(),
                        ),
                        Row(
                          children: List.generate(data['p_colors'].length,
                           (index) => Stack(
                            alignment: Alignment.center,
                             children: [
                               VxBox().size(40, 40).roundedFull.color(Color(data['p_colors'][index]).withOpacity(1.0)).margin(EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                                controller.changecolorindex(index);
                               }),
                            Visibility(
                              visible: index==controller.colorindex.value,
                              child:  Icon(Icons.done,color: Colors.white,),)
                             ],
                           )),
                        ),
                      ],).box.padding(EdgeInsets.all(8)).make(),
                  
                      Row(children: [
                        
                        SizedBox(
                          width: 100,
                          child: "Quantity: ".text.color(textfieldGrey).make(),
                        ),
                        Obx(()=>
                           Row(
                            children: [
                              IconButton(onPressed: (){
                                controller.descquantity();
                                controller.calculateprice(int.parse(data['p_price']));
                              }, icon: Icon(Icons.remove)),
                              controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                              IconButton(onPressed: (){
                                controller.incquantity(int.parse(data['p_quantity']));
                                controller.calculateprice(int.parse(data['p_price']));
                              }, icon: Icon(Icons.add)),
                              10.widthBox,
                              "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                            ],
                             ),
                        ),
                  
                      ],).box.padding(EdgeInsets.all(8)).make(),
                    Row(children: [
                        
                        SizedBox(
                          width: 100,
                          child: "Total: ".text.color(textfieldGrey).make(),
                        ),
                       controller.totalPrice.value.numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),
                  
                      ],).box.padding(EdgeInsets.all(8)).make(),
                      10.heightBox,
                    
                      "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      "${data['p_desc']}".text.color(darkFontGrey).make(),
                      10.heightBox,
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(itemdetailbuttonlist.length, (index) => ListTile(
                          title: itemdetailbuttonlist[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                          trailing: Icon(Icons.arrow_forward),
                        )),
                      ),
                      20.heightBox,
                  
                      productlike.text.fontFamily(bold).size(16).align(TextAlign.left).color(darkFontGrey).make(),
                    10.heightBox,
                     SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(6, (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                    10.heightBox,
                    "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                    10.heightBox,
                    "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                  ],
                              ).box.shadowSm.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(8)).make()),
                            
                            ),
                          ),
                          
                    ],
                  ).box.white.shadowSm.make(),
                ),
              ],
            ),
           ),
            )),
        SizedBox(
        width: double.infinity,
        height: 60,
        child: btn((){

      if(controller.quantity.value>0){
        controller.addtoCart(
        color: data['p_colors'][controller.colorindex.value],
        context: context,
        vendorid: data['vendor_id'],
        img: data['p_imgs'][0],
        qty: controller.quantity.value,
        sellername: data['p_seller'],
        title: data['p_name'],
        tprice: controller.totalPrice.value
      );
      VxToast.show(context, msg: "item is added to Cart");
      }
      else{
         VxToast.show(context, msg: "Minimum 1 product is required");
      }
        }, redColor, whiteColor, "Add to cart"),
      ),
        ]),
      ),
    );
  }
}