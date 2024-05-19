import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cartify_app/Modals/categorymodal.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

var subcat=[];
var quantity =0.obs;
var colorindex=0.obs;
var totalPrice=0.obs;
var isfav =false.obs;


  getCategories(title) async{
    subcat.clear();
    var data =await rootBundle.loadString('lib/services/category_modal.json');
    var decode = categoryModalFromJson(data);
    var s=decode.categories.where((element) => element.name==title).toList();
    for(var e in s[0].subcategories){
      subcat.add(e);
    }
  }
  changecolorindex(index){
colorindex.value=index;
  }
  incquantity(tquantity){
    if(quantity.value<tquantity){
       quantity.value++;
    }
   
  }
  descquantity(){
    if(quantity.value>0){
       quantity.value--;
    }
   
  }
  calculateprice(price){
    totalPrice.value = price*quantity.value;
  }
  addtoCart({vendorid ,title,img,tprice,sellername,color,qty,context}) async{
await firestore1.collection(cartcollection).doc().set({
  'title':title,
  'img':img,
  'sellernamew':sellername,
  'color':color,
  'qty':qty,
  'vendor_id':vendorid,
  'tprice':tprice,
  'added_by':currentuser!.uid,
  }).catchError((error){
    VxToast.show(context, msg: error.toString());
  });
  }
  resetvalue(){
    totalPrice.value=0;
    quantity.value=0;
    colorindex.value=0;
  }
  addtowhishlist(docid)async{
    await firestore1.collection(productcollection).doc(docid).set({
'p_whishlist':FieldValue.arrayUnion([
  currentuser!.uid
])
    },SetOptions(merge: true));
     isfav.value=true;
  }

   removefromwhishlist(docid)async{
    await firestore1.collection(productcollection).doc(docid).set({
'p_whishlist':FieldValue.arrayRemove([
  currentuser!.uid
])
    },SetOptions(merge: true));
isfav(false);
  }
  checkfav(data)async{
if(data['p_whishlist'].contains(currentuser!.uid)){
  isfav.value=true;
}
else{
   isfav.value=false;
}
  }
}