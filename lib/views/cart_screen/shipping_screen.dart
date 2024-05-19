import 'package:cartify_app/common_widget/custom_textfield.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/controller/cartcontroller.dart';
import 'package:cartify_app/views/cart_screen/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/button.dart';

class ShippingDetail extends StatelessWidget {
  const ShippingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar:  SizedBox(
        height: 60,
        child: btn((){
          if(controller.addresscontroller.text.isNotEmpty){
Get.to(()=>PaymentMethod());
          }
          else{
VxToast.show(context, msg: "please fill all field");
          }
        }, redColor, whiteColor, "Continue")),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customtextfield(hint: "Address",ispass: false,Title: "Address",controller1: controller.addresscontroller),
               customtextfield(hint: "City",ispass: false,Title: "City",controller1: controller.citycontroller),
                customtextfield(hint: "State",ispass: false,Title: "State",controller1: controller.statecontroller),
                 customtextfield(hint: "Postal code",ispass: false,Title: "Postal code",controller1: controller.postalcodecontroller),
                  customtextfield(hint: "Phone",ispass: false,Title: "Phone",controller1: controller.phonecontroller),
            ],
          ),
        ),
    );
  }
}