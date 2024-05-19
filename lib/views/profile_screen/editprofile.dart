import 'dart:io';

import 'package:cartify_app/common_widget/bg.dart';
import 'package:cartify_app/common_widget/button.dart';
import 'package:cartify_app/common_widget/custom_textfield.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/controller/profilecontroller.dart';
import 'package:get/get.dart';


class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    var controller= Get.find<ProfileController>();
   
    return bg(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          ()=> Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
             data['imgurl']==""&& controller.profilepath.isEmpty
             ? Image.asset(imgProfile2,width: 70,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
             :data['imgurl']!=""&&controller.profilepath.isEmpty
             ? Image.network(data['imgurl'],width: 70,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
             : Image.file(File(controller.profilepath.value),
              width: 70,
              fit: BoxFit.cover
              ).box.roundedFull.clip(Clip.antiAlias).make(),
               
               
               
                10.heightBox,
                btn((){
                   controller.changeImage(context);
                }, redColor, whiteColor, "Change"),
                Divider(),
                20.heightBox,
                customtextfield(hint: namehint,Title: name,ispass: false,controller1: controller.namecontroller),
               10.heightBox,
                customtextfield(hint: passhint,Title: "Old Password",ispass: true,controller1: controller.oldpasscontroller),
        10.heightBox,
        customtextfield(hint: passhint,Title: "New Password",ispass: true,controller1: controller.newpasscontroller),
        
          20.heightBox,
          controller.isloading.value? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),):
           SizedBox(
            width: context.screenWidth-50,
            child: btn(() async{
              controller.isloading(true);


              if(controller.profilepath.value.isNotEmpty){
                 await controller.uploadprofile(context);
              }
              else{
                controller.proflink=data['imgurl'];
              }
              if(data['password']==controller.oldpasscontroller.text){
               await controller.changeauthpass(email: data['email'] ,password: controller.oldpasscontroller.text,newpassword: controller.newpasscontroller.text);
                await controller.updateProfile(imgurl: controller.proflink,
             name: controller.namecontroller.text,password: controller.newpasscontroller.text);
           
             VxToast.show(context, msg: "updated");
              }
            else{
              VxToast.show(context, msg: "wrong old password");
              controller.isloading(false);
            }
             

            }, redColor, whiteColor, "Save")),
            ],
          ).box.white.shadowSm.padding(EdgeInsets.all(16)).rounded.margin(EdgeInsets.only(top: 50,left: 12,right: 12)).make(),
        ),
      )
    );
  }
}