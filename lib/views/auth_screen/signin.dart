import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/controller/auth_controller.dart';
import 'package:cartify_app/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common_widget/applogo.dart';
import '../../common_widget/bg.dart';
import '../../common_widget/button.dart';
import '../../common_widget/custom_textfield.dart';
import '../../consts/colors.dart';

import '../../consts/strings.dart';
import '../../consts/styles.dart';

class Signin extends StatefulWidget {

  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool? ischk=false;
  var controller =Get.put(AuthController());
  var namecontroller =TextEditingController();
  var emailcontroller =TextEditingController();
  var passcontroller =TextEditingController();
  var repasscontroller =TextEditingController();
 @override
  Widget build(BuildContext context) {
    return bg(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
(context.screenHeight*0.1).heightBox,
applogo(),
10.heightBox,
"Join to $appname".text.fontFamily(bold).white.size(18).make(),
15.heightBox,
Column(
  children: [
     customtextfield(Title:name,hint:namehint,controller1: namecontroller,ispass: false),
    customtextfield(Title:email,hint:emailhint,controller1: emailcontroller,ispass: false),
    customtextfield(Title:pass,hint:passhint,controller1: passcontroller,ispass: true),
     customtextfield(Title:repass,hint:passhint,controller1: repasscontroller,ispass: true),
  5.heightBox,
 
  Row(
    children: [
      
      Checkbox(
        activeColor: redColor,
        checkColor: whiteColor,
        value: ischk, onChanged: (newvalue){
          setState(() {
             ischk=newvalue;
          });
         
          }),
        10.widthBox,
        Expanded(
          child: RichText(text: TextSpan(children: [
            TextSpan(text: "I agree to the ", style: TextStyle(fontFamily: regular,color: fontGrey)),
            TextSpan(text: term,style: TextStyle(fontFamily: regular,color: redColor)),
            TextSpan(text: " & ", style: TextStyle(fontFamily: regular,color: fontGrey)),
            TextSpan(text: poloicy,style: TextStyle(fontFamily: regular,color: redColor))
           
            ]
            )),
        )
    ],
  ),
 btn(()async{
if(ischk !=false){
  try{
await controller.signupMethod(context: context,email: emailcontroller.text,password: passcontroller.text).then((value){

  return controller.storeUserData(
    email: emailcontroller.text,
    password: passcontroller.text,
    name: namecontroller.text
  );
}).then((value){
  
  VxToast.show(context, msg: "loggedin Successfull");
  Get.offAll(()=>home());
});
  }
  catch(e){
    VxToast.show(context, msg: e.toString());
auth.signOut();
  }
}
 },
 ischk==true? redColor:lightGrey,whiteColor,signup).box.width(context.screenWidth-50).make(),
  10.heightBox,
  RichText(text: TextSpan(children: [
    TextSpan(text: alreadyaccount,
    style: TextStyle(fontFamily: bold,color: fontGrey)),
     TextSpan(text: login,
    style: TextStyle(fontFamily: bold,color: redColor))
  ])).onTap(() {Get.back();})
],
).box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make(),
            ],
          ),
        ),
      )
    );
  }
}