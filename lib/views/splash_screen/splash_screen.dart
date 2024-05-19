import 'package:cartify_app/views/auth_screen/login.dart';
import 'package:cartify_app/common_widget/applogo.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../home_screen/home.dart';


class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
changescreen(){
  Future.delayed(Duration(seconds: 3),(){
    auth.authStateChanges().listen((User? user) {
      if(user==null&&mounted){
 Get.to(()=>Login());
      }
      else{
      Get.to(()=>home()); 
      }
     });
    
  });
}
@override
  void initState() {
    changescreen();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          applogo(),
          
          ],
        ),
      ),
    );
  }
}