import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cartify_app/services/firestore_services.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class WhishlistScreen extends StatelessWidget {
  const WhishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Whishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
   
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getwhishlist(),
       builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
         if(!snapshot.hasData){
          return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
        }
        else if(snapshot.data!.docs.isEmpty){
          return Center(child: "No whishlist yet!".text.color(darkFontGrey).make(),);
        }
        else{
           var data=snapshot.data!.docs;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                          leading: Image.network("${data[index]['p_imgs'][0]}",width: 70,fit: BoxFit.cover,),
                          title: "${data[index]['p_name']} ".text.size(16).fontFamily(semibold).make(),
                          subtitle:"${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(semibold).make(), 
                          trailing:  Icon(Icons.favorite,color: Colors.red,).onTap(() async{ 
                
                           await firestore1.collection(productcollection).doc(data[index].id).set({
                          'p_whishlist':FieldValue.arrayRemove([currentuser!.uid])
                           },SetOptions(merge: true));
                          }),
                        );
                  }),
                 
                ),
              ),
            ],
          );
        }
       }),
    );
  }
}