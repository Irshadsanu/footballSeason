import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Constant/myfunctions.dart';
import 'package:football_season/Providers/mainprovider.dart';
import 'package:provider/provider.dart';

import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Constant/mywidgets.dart';

class RegistractionSuccessfulscrn extends StatelessWidget {
  const RegistractionSuccessfulscrn({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData= MediaQuery.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body:queryData.orientation==Orientation.portrait?
         Container(
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(image:AssetImage(registrationBkrnd),fit: BoxFit.fitWidth)),

          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 130,),
              Image.asset(goalimg,scale: 7,),
              SizedBox(height:20,),
              Text("Registration Successful!",style:TextStyle(color: txtclr1,fontWeight:FontWeight.w600,fontSize:12) ),
              SizedBox(height:20,),
              Image.asset(successmesg,scale: 3.5,),
              SizedBox(height:220,),
              Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return InkWell(onTap: () {
                      value.clear();
                      finish(context);
                    },
                        child: btn2(45,width,"Back to Home"));
                  }
              ),


        ]),
          ),
         ) :  Center(
           child: Container(
            width: width/3,
             decoration: BoxDecoration(
                 image: DecorationImage(image:AssetImage(registrationBkrnd),fit: BoxFit.fitWidth)),

             child: SingleChildScrollView(
               child: Column(children: [
                 SizedBox(height: 130,),
                 Image.asset(goalimg,scale: 7,),
                 SizedBox(height:20,),
                 Text("Registration Successful!",style:TextStyle(color: txtclr1,fontWeight:FontWeight.w600,fontSize:12) ),
                 SizedBox(height:20,),
                 Image.asset(successmesg,scale: 2.8,),
                 SizedBox(height:230,),
                 Consumer<MainProvider>(
                   builder: (context,value,child) {
                     return InkWell(onTap: () {
                       value.clear();
                       finish(context);
                     },
                         child: btn2(45,width,"Back to Home"));
                   }
                 ),

            ]),
             ),



        ),
         ) );
  }
}
