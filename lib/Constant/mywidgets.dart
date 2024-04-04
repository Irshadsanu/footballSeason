import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_season/Providers/mainprovider.dart';
import 'package:provider/provider.dart';

import 'images.dart';
import 'mycolor.dart';


InputBorder border=const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
    borderSide: BorderSide(color: Colors.white60,width: 0.1)
);
TextStyle textsty=const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: "RacingSansOne");
TextStyle textsty2=const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: "RacingSansOne");

Widget regiterTextfield(TextEditingController controllers,String hinttxt,Color fillcolor,TextInputType textInputType) {
  return Column(
    children: [
      Padding(
        padding:  EdgeInsets.only(left: 50,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(hinttxt,style: TextStyle(
              color:txtclr.withOpacity(.7) ,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),),
            Text("*",style: TextStyle(color: Colors.red),),

          ],
        ),
      ),
      Container(

        // height: 51,
        // width: width,
        margin: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          // color: Colors.black12,
          borderRadius: BorderRadius.circular(59),
          boxShadow:  [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              // offset: Offset(
              //   0.0, // Move to right 7.0 horizontally
              //   8.0,
              // ),
              color: shadowColor.withOpacity(0.25),
              blurRadius: 5.0,
            ),
          ],
        ),

        child: TextFormField(
          controller: controllers,
          textAlign: TextAlign.center,
          keyboardType: textInputType,
          inputFormatters: [
            LengthLimitingTextInputFormatter(
                textInputType==TextInputType.number?10:100)],
          // enabled:type=="Request"?false:true,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              // hintMaxLines: maxline,
              filled: true,
              fillColor: fillcolor,
              // isDense: true,
              labelStyle: const TextStyle(fontSize: 15),
              focusedBorder:border,
              enabledBorder: border,
              errorBorder: border,
              border:border,

          ),
          style: const TextStyle(color: Colors.white),
          validator: (value) {
            if (value!.isEmpty) {
              return "This field is Required";
            }
            return null;
          },
        ),
      ),
    ],
  );
}
Widget regiterTextfield2(TextEditingController controllers,String hinttxt,Color fillcolor,TextInputType textInputType) {
  return Column(
    children: [
      Padding(
        padding:  EdgeInsets.only(left: 50,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(hinttxt,style: TextStyle(
              color:txtclr.withOpacity(.7) ,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),),

          ],
        ),
      ),
      Container(

        // height: 51,
        // width: width,
        margin: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          // color: Colors.black12,
          borderRadius: BorderRadius.circular(59),
          boxShadow:  [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              // offset: Offset(`
              //   0.0, // Move to right 7.0 horizontally
              //   8.0,
              // ),
              color: shadowColor.withOpacity(0.25),
              blurRadius: 5.0,
            ),
          ],
        ),

        child: TextFormField(

          controller: controllers,
          textAlign: TextAlign.center,
          keyboardType: textInputType,
          // enabled:type=="Request"?false:true,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10,),
              // hintMaxLines: maxline,
              filled: true,
              fillColor: fillcolor,
              // isDense: true,
              labelStyle: const TextStyle(fontSize: 15),
              focusedBorder:border,
              enabledBorder: border,
              errorBorder: border,
              border:border,


          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}
Widget regiterTextfield3(TextEditingController controllers,String hinttxt,Color fillcolor,TextInputType textInputType) {
  return Column(
    children: [
      Padding(
        padding:  EdgeInsets.only(left: 50,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(hinttxt,style: TextStyle(
              color:txtclr.withOpacity(.7) ,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),),
            Text("*",style: TextStyle(color: Colors.red),),

          ],
        ),
      ),
      Container(

        // height: 51,
        // width: width,
        margin: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          // color: Colors.black12,
          borderRadius: BorderRadius.circular(59),
          boxShadow:  [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              // offset: Offset(`
              //   0.0, // Move to right 7.0 horizontally
              //   8.0,
              // ),
              color: shadowColor.withOpacity(0.25),
              blurRadius: 5.0,
            ),
          ],
        ),

        child: TextFormField(
          controller: controllers,
          textAlign: TextAlign.center,
          keyboardType: textInputType,
          maxLength: 10,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10,),
              filled: true,
              fillColor: fillcolor,
              counterText: "",
              labelStyle: const TextStyle(fontSize: 15),
              focusedBorder:border,
              enabledBorder: border,
              errorBorder: border,
              border:border,

          ),
          style: const TextStyle(color: Colors.white),
          validator: (value) {
            if(value!.isEmpty){
              return 'Please Enter Phone Number';
            } else if(value.length<10){
              return 'Please Enter valid Number';
            }
            return null;
          },
        ),
      ),
    ],
  );
}

Widget btn(double height,double width,String txt){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
    height:height ,
    width: width,
    decoration: BoxDecoration( image: DecorationImage(image: AssetImage(footBall,),alignment: Alignment.bottomLeft,opacity: 0.5 ),
        gradient: const LinearGradient(
        colors: [btncolor1, btncolor2],
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft),
        borderRadius:  BorderRadius.circular(59),),
    child: Center(child: Text(txt,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),)),
  );
}
Widget alert (){
  return Container();
}
Widget btn2(double height,double width,String txt,){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
    height:height ,
    width: width,
    decoration: BoxDecoration( image: DecorationImage(image: AssetImage(footBall2,),alignment: Alignment.topRight,opacity: 0.5, ),
      gradient: const LinearGradient(
          colors: [btncolor1, btncolor2,],
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft),
      borderRadius:  BorderRadius.circular(59),),
    child: Center(child: Text(txt,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),)),
  );
}
Widget floatingActnBtn(String text,IconData icons){
  return Container(
    height: 41,
    width: 111,
    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10),
      boxShadow:  const [
        BoxShadow(
            blurStyle: BlurStyle.outer,
            color: shadowclr,
            blurRadius: 9.0,
            // spreadRadius:5
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Icon(icons ,color: btncolor1,size: 25),
        Text(text,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color:btncolor1 ),),

      ],),
  );
}
Widget richtxt(String txt,Color fntclr ,String txt2,Color fntclr2 ){
  return RichText(
    text:  TextSpan(
      text: txt,
      style: TextStyle(
          color: fntclr,
          fontSize: 24,
           fontFamily: "RacingSansOne",
          fontWeight: FontWeight.w400),
      children: <TextSpan>[
        TextSpan(text: txt2,
            style: TextStyle(fontWeight: FontWeight.w400, color: fntclr2,fontSize:24,fontFamily: "RacingSansOne",)),
      ],
    ),
  );
}

String generateRandomString(int length) {
  final random = Random();
  const availableChars = '1234567890';
  final randomString = List.generate(length,
          (index) => availableChars[random.nextInt(availableChars.length)]).join();

  return randomString;
}


Widget  admhomebtn(String rtxt,Color rfntclr,String rtxt2,Color rfntclr2,String amount,String register){
  return Container(
      width: 149,
      height: 125,
    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(16) ,boxShadow:  const [
      BoxShadow(
      blurStyle: BlurStyle.outer,
        color: shadowclr,
      blurRadius: 9.0,
        offset: Offset(
         0, // Move to right 7.0 horizontally
          5,
        ),
      // spreadRadius:5
    ),
    ], ),
    child:  Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        RichText(
          text:  TextSpan(
            text: rtxt,
            style: TextStyle(
                color: rfntclr,
                fontSize: 24,
                fontFamily: "RacingSansOne",
                fontWeight: FontWeight.w400),
                children: <TextSpan>[
                TextSpan(text: rtxt2,
                  style: TextStyle(fontWeight: FontWeight.w400, color: rfntclr2,fontSize:24,fontFamily: "RacingSansOne",)),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.currency_rupee,color: txtclr,size: 10),
            const SizedBox(width: 3,),
             Text(amount,style: const TextStyle(fontSize:15,fontWeight: FontWeight.w200,color: txtclr,),),
          ],
        ),
        const SizedBox(height: 3,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.perm_identity, size: 15,color: txtclr),SizedBox(width: 3,),
            Text(register,style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: txtclr)),
          ],
        ),

      ]

    ),

  );
}
Widget  admhomebtn2(String img,String txt,String txt2){
  return Container(
    width: 149,
      height: 125,
    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(16) ,boxShadow:  const [
      BoxShadow(
      blurStyle: BlurStyle.outer,
        color: shadowclr,
      blurRadius: 9.0,
        offset: Offset(
          0, // Move to right 7.0 horizontally
          5,
        ),
      // spreadRadius:5
    ),
    ], ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
      // const SizedBox(
      //   height: 41,
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img,scale: 28),
          SizedBox(width: 3,),
          Text(txt, style: const TextStyle(color: txtclr,fontSize: 13,fontWeight: FontWeight.w300),),
        ],
      ),
      Text(txt2,style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:btncolor1),)
    ]),
  );
}

