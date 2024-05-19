import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cartify_app/common_widget/button.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/controller/cartcontroller.dart';
import 'package:cartify_app/services/firestore_services.dart';
import 'package:cartify_app/views/cart_screen/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
    height: 60,
    child: btn((){
      Get.to(()=>ShippingDetail());
    }, redColor, whiteColor, "Proceed to shipping"),),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(stream: FirestoreServices.getCart(currentuser!.uid), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       
        if(!snapshot.hasData){
          return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
        }
        else if(snapshot.data!.docs.isEmpty){
          return Center(child: "Cart is empty".text.color(darkFontGrey).make(),);
        }
        else{
          var data=snapshot.data!.docs;
          controller.calculate(data);
          controller.productsnapshot=data;
          return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(child: Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: Image.network("${data[index]['img']}",width: 70,fit: BoxFit.cover,),
                    title: "${data[index]['title']} (x${data[index]['qty']})".text.size(16).fontFamily(semibold).make(),
                    subtitle:"${data[index]['tprice']}".numCurrency.text.color(redColor).fontFamily(semibold).make(), 
                    trailing:  Icon(Icons.delete,color: redColor,).onTap(() { 

                      FirestoreServices.deleteDoc(data[index].id);
                    }),
                  );
                }),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
  "total price".text.fontFamily(semibold).color(darkFontGrey).make(),
  Obx(()=> "${controller.totalprice.value}".numCurrency.text.fontFamily(semibold).color(redColor).make()),
 
],
            ).box.padding(EdgeInsets.all(12)).width(context.screenWidth-60).color(lightgolden).roundedSM.make(),
          
          ],
        ));
        }
      })
    );
  }
}