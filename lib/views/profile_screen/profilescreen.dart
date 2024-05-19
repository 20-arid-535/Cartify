import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cartify_app/common_widget/bg.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/consts/iconlist.dart';
import 'package:cartify_app/consts/images.dart';
import 'package:cartify_app/controller/auth_controller.dart';
import 'package:cartify_app/controller/profilecontroller.dart';
import 'package:cartify_app/services/firestore_services.dart';
import 'package:cartify_app/views/auth_screen/login.dart';
import 'package:cartify_app/views/chat_screen/messaging_screen.dart';
import 'package:cartify_app/views/order_screen/order_screen.dart';
import 'package:cartify_app/views/profile_screen/editprofile.dart';
import 'package:cartify_app/views/whishlist_screen/whishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common_widget/profiledetailbtn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProfileController());
    return bg(
      child: Scaffold(
        body: StreamBuilder(stream: FirestoreServices.getUser(currentuser!.uid), 
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
       if(!snapshot.hasData){
        return Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),
        );
       }
      else{

        var data=snapshot.data!.docs[0];
       return SafeArea(child: Column(
            children: [

Padding(
  padding: const EdgeInsets.all(8.0),
  child: Align(
    alignment: Alignment.topRight,
    child: Icon(Icons.edit,color: whiteColor,)).onTap(() {
      controller.namecontroller.text=data['name'];
     //controller.passcontroller.text=data['password'];
      Get.to(()=>EditProfile(data: data,));}),
),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    data['imgurl']==""?

                    Image.asset(imgProfile2,width: 60,height: 60,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make():
                     Image.network(data['imgurl'],width: 60,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                    ,
                 
                 
                  10.widthBox,
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "${data['name']}".text.fontFamily(semibold).white.make(),
                      
                      "${data['email']}".text.white.make(),
                    ],
                  )),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: whiteColor
                    )
                  ),
                  onPressed: ()async{
                    await Get.put(AuthController()).signoutMethod(context: context);
                    Get.offAll(()=>Login());
                  }, child: logout.text.fontFamily(semibold).white.make())
                  ],
                ),
              ),
              10.heightBox,
FutureBuilder(future: FirestoreServices.getcount(), builder: (BuildContext context, AsyncSnapshot snapshot){
   if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),));
                    }
                    else{
                      var countdata =snapshot.data;
  return Row(
    
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  profiledetailbtn(count: "${countdata[0]}",title: "in your cart",width: context.screenWidth/3.4),
                   profiledetailbtn(count: "${countdata[1]}",title: "your whishlist",width: context.screenWidth/3.4),
                    profiledetailbtn(count: "${countdata[2]}",title: "your orders",width: context.screenWidth/3.4),
                ],
              );}
}),


              
              
              
              ListView.separated(
                shrinkWrap: true,
separatorBuilder: (context, index) {
  return const Divider(color: lightGrey,);
},
                itemCount:profilebuttonlist.length,
                itemBuilder: (BuildContext context,int index){
return ListTile(
  onTap: (){
    switch(index){
      case 0:
      Get.to(()=>OrderScreen());
      break;
      case 1:
      Get.to(()=>WhishlistScreen());
      break;
      case 2:
      Get.to(()=>MsgScreen());
      break;
    }
  },
  leading: Image.asset(profileiconslist[index],width: 22,),
  title: profilebuttonlist[index].text.fontFamily(semibold).color(darkFontGrey).make(),
);
                }).box.white.rounded.shadowSm.margin(EdgeInsets.all(12)).padding(EdgeInsets.symmetric(horizontal: 16)).make().box.make(),
              
                ],
          ),
        );
      }
        }
        ),
      )
    );
  }
}