import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cartify_app/common_widget/bg.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/controller/productcontroller.dart';
import 'package:cartify_app/services/firestore_services.dart';
import 'package:cartify_app/views/category_screen/itemdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetsail extends StatefulWidget {
   CategoryDetsail({Key? key,required this.title}):super(key: key);
final String? title;


  @override
  State<CategoryDetsail> createState() => _CategoryDetsailState();
   
}

class _CategoryDetsailState extends State<CategoryDetsail> {
  var controller=Get.find<ProductController>();
  dynamic productmethod;
  @override
  void initState() {
    // TODO: implement initState
    switchcategory(widget.title);
    super.initState();
  }
  switchcategory(title){
if(controller.subcat.contains(title)){
productmethod= FirestoreServices.getsubcategoryproduct(title);
}
else{
productmethod= FirestoreServices.getProduct(title);
}
    }
  @override
  Widget build(BuildContext context) {
   
    
    return bg(
      child: Scaffold(
        appBar: AppBar(title: widget.title!.text.white.fontFamily(bold).make(),foregroundColor: whiteColor,),
     body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              
              controller.subcat.length, (index) => controller.subcat[index].toString().text.size(12).fontFamily(semibold).color(darkFontGrey).makeCentered().box.white.rounded.size(120, 60).margin(EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                switchcategory("${controller.subcat[index]}");
                setState(() {
                  
                });
              })),
          ),
        ),
        20.heightBox,
         StreamBuilder(stream: productmethod,
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
           
            if(!snapshot.hasData){
              return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
            }
            else if(snapshot.data!.docs.isEmpty){
              return Expanded(child: Center(child: "No products found".text.white.color(darkFontGrey).make(),));
            }
            else{
              var data = snapshot.data!.docs;
              return
                Expanded(child: Container(
                  color: whiteColor,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                 
                    shrinkWrap: true,
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 3), itemBuilder: (context, index) {
                    return Column(
                
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(data[index]['p_imgs'][0],width: 200,height: 150,fit: BoxFit.cover,)),
                         10.heightBox,
                        "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                        10.heightBox,
                        "${data[index]['p_price']}"!.numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                      ],
                    ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.shadowSm.padding(EdgeInsets.all(12)).make().onTap(() {
                      controller.checkfav(data[index]);
                      Get.to(()=>ItemDetail(title: "${data[index]['p_name']}",data: data[index],));
                    });
                  }).box.margin(EdgeInsets.all(9)).make(),
                ))
              ;
            }
          }),
       ],
     ))
      
    );
  }
}