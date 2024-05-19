import 'package:cartify_app/consts/consts.dart';

Widget customtextfield({String? Title,hint,controller1,ispass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: ispass,
        controller: controller1,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontFamily: semibold,color: textfieldGrey),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: redColor))
        ),
      ),
    5.heightBox],
  );
}