// ignore_for_file: prefer_const_constructors, must_be_immutable


import 'package:cartify_app/views/auth_screen/signin.dart';
import 'package:cartify_app/common_widget/applogo.dart';
import 'package:cartify_app/common_widget/bg.dart';
import 'package:cartify_app/common_widget/button.dart';
import 'package:cartify_app/common_widget/custom_textfield.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/consts/iconlist.dart';
import 'package:cartify_app/views/home_screen/home.dart';

import 'package:get/get.dart';

import '../../controller/auth_controller.dart';



class Login extends StatelessWidget {
  Login({super.key});
   var controller =Get.put(AuthController());
   var passcontroller =TextEditingController();
   var emailcontroller =TextEditingController();

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
"Log in to $appname".text.fontFamily(bold).white.size(18).make(),
15.heightBox,
   Column(
    children: [
      customtextfield(Title:email,hint:emailhint,controller1:emailcontroller,ispass: false),
      customtextfield(Title:pass,hint:passhint,controller1:passcontroller,ispass: true),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(onPressed: (){},child: forgetpass.text.make())),
    5.heightBox,
    btn(()async {
    
      await controller.loginMethod(context: context,email: emailcontroller.text,password: passcontroller.text).then((value){
        if(value!=null){
          VxToast.show(context, msg: "loggedin Successfull");
          
          Get.offAll(()=> home());
        }
        else{
         
        }
      });
      },redColor,whiteColor,login).box.width(context.screenWidth-50).make(),
    5.heightBox,
  create.text.color(fontGrey).make(),
  5.heightBox,
  btn((){
    Get.to(()=>Signin());
  },lightgolden,redColor,signup).box.width(context.screenWidth-50).make(),
    10.heightBox,
    loginnwith.text.color(fontGrey).make(),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
         backgroundColor: lightGrey,
          radius: 25,
          child: Image.asset(sociallist[index],width: 30,),
        ),
      ))
    )
  ],
  ).box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make(),

            ],
          ),
        ),
      )
    );
  }
}