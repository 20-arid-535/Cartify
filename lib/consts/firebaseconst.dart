import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore1 = FirebaseFirestore.instance;
User? currentuser =auth.currentUser;

const usercollection="users";
const productcollection ="products";
const cartcollection ="cart";
const chatscollection ="chats";
const messagescollection ="messages";
const ordercollection ="order";
