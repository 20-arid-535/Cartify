import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/controller/homecontroller.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var totalprice=0.obs;

var addresscontroller =TextEditingController();
var citycontroller =TextEditingController();
var statecontroller =TextEditingController();
var postalcodecontroller =TextEditingController();
var phonecontroller =TextEditingController();
var paymentindex=0.obs;
late dynamic productsnapshot;
var products=[];
var vendors=[];

  calculate(data){
    totalprice.value=0;
    for (var i=0;i<data.length;i++){
totalprice.value=totalprice.value+int.parse(data[i]['tprice'].toString());
    }
  }

  changepaymentindex(index){
    paymentindex.value=index;
  }

  placemyorder({orderpaymentmethod,total}) async{

await getproductdetail();
await firestore1.collection(ordercollection).doc().set({
  'order_code':"212134567",
  'order_date': FieldValue.serverTimestamp(),
'order_by':currentuser!.uid,
'order_by_name':Get.find<HomeController>().name,
'order_by_email':currentuser!.email,
'order_by_address':addresscontroller.text,
'order_by_state':statecontroller.text,
'order_by_city':citycontroller.text,
'order_by_phone':phonecontroller.text,
'order_by_postalcode':postalcodecontroller.text,
'shipping_method':"Home Delivery",
'payment_method':orderpaymentmethod,
'order_place':true,
'order_confirm':false,
'order_delivered':false,
'order_on_delivery':false,
'total_amount':total,
'orders': FieldValue.arrayUnion(products),
'vendors':FieldValue.arrayUnion(vendors),
});
  }

  getproductdetail(){
    products.clear();
    vendors.clear();
    for(var i=0;i<productsnapshot.length;i++){
products.add({
  'color':productsnapshot[i]['color'],
  'img':productsnapshot[i]['img'],
  'vendor_id':productsnapshot[i]['vendor_id'],
  'tprice':productsnapshot[i]['tprice'],
  'qty':productsnapshot[i]['qty'],
  'title':productsnapshot[i]['title'],
});
vendors.add(productsnapshot[i]['vendor_id']);
    }
  }

  clearcart(){
    for (var i = 0; i < productsnapshot.length; i++) {
      firestore1.collection(cartcollection).doc(productsnapshot[i].id).delete();
    }
  }
  }