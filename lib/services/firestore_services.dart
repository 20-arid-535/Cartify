import 'package:cartify_app/consts/consts.dart';

class FirestoreServices{
  static getUser(uid){
return firestore1.collection(usercollection).where('id',isEqualTo: uid).snapshots();
  }
  static getProduct(category){
    return firestore1.collection(productcollection).where('p_category',isEqualTo: category).snapshots();
  
  }

  static getCart(uid){
return firestore1.collection(cartcollection).where('added_by',isEqualTo: uid).snapshots();
  }

  static deleteDoc(docid){
    return firestore1.collection(cartcollection).doc(docid).delete();
  }

  static getchatsmsg(docid){
    return firestore1.collection(chatscollection).doc(docid).collection(messagescollection).orderBy('created_on',descending: false).snapshots();
  }

   static getallorders(){
    return firestore1.collection(ordercollection).where('order_by',isEqualTo: currentuser!.uid).snapshots();
  }
  static getwhishlist(){
    return firestore1.collection(productcollection).where('p_whishlist',arrayContains: currentuser!.uid).snapshots();
  }
  static getallmsg(){
    return firestore1.collection(chatscollection).where('fromid',isEqualTo: currentuser!.uid).snapshots();
  }
  static getcount()async{
var res= await Future.wait([
  firestore1.collection(cartcollection).where('added_by',isEqualTo: currentuser!.uid).get().then((value){
return value.docs.length;
  }),
  firestore1.collection(productcollection).where('p_whishlist',arrayContains: currentuser!.uid).get().then((value){
return value.docs.length;
  }),
  firestore1.collection(ordercollection).where('order_by',isEqualTo: currentuser!.uid).get().then((value){
return value.docs.length;
  }),
]);
return res;
  }

  static allproduct(){
 return firestore1.collection(productcollection).snapshots();
  
  }

  static getfeatureproduct(){
     return firestore1.collection(productcollection).where('is_featured',isEqualTo: true).get();
  }

  static searchproduct(title){
    return firestore1.collection(productcollection).get();
  }
  static getsubcategoryproduct(title){
return firestore1.collection(productcollection).where('p_subcategory',isEqualTo: title).snapshots();
  
  }
}