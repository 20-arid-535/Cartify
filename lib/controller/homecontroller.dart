import 'package:cartify_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  void onInit(){
    getusername();
    super.onInit();
  }
var currentNavIndex=0.obs;
var name="";
var searchcontroller=TextEditingController();

getusername() async{
 var n=await firestore1.collection(usercollection).where('id',isEqualTo: currentuser!.uid).get().then((value){
 if(value.docs.isNotEmpty){
  return value.docs.single['name'];
  }
 });
 name=n;
}
}