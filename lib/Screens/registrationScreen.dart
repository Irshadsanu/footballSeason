import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Constant/myfunctions.dart';
import 'package:football_season/Constant/mywidgets.dart';
import 'package:football_season/Providers/mainprovider.dart';
import 'package:football_season/Screens/registraction_SuccessfulScreen.dart';
import 'package:provider/provider.dart';

import '../Constant/images.dart';
import '../Constant/mycolor.dart';

class RegistrationScreen extends StatelessWidget {
   RegistrationScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData= MediaQuery.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    MainProvider provider = Provider.of<MainProvider>(context, listen: true);


    return Scaffold(
       resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body:queryData.orientation==Orientation.portrait?
        Container(
          width: width,
            decoration: BoxDecoration(image: DecorationImage(image:AssetImage(registrationBkrnd),fit: BoxFit.fitWidth)),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Image.asset(logo2,scale: 3),


                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone,color:btncolor1 ,size: 10),
                      SizedBox(width: 5,),
                      Text("919946470220",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 13,color: txtclr),)

                    ],
                  ),
                  
                  const SizedBox(height: 60,),
                  const Text("Season Ticket Registration!",style: TextStyle(color: Colors.yellow),),
                  const SizedBox(height: 20,),
                  richtxt("Rs. ",btncolor1,"500",txtclr),
                  const SizedBox(height: 10,),
                  Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return InkWell(
                        onTap: (){
                          value.chooseuserImage(context);
                        },
                        child: Container(
                            child:value.userfileBytes!=null?
                            CircleAvatar(
                              radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage:MemoryImage(value.userfileBytes!,) ,
                                ):
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white,width: 0.5)),
                                child: Image.asset(profile,scale: 4,))),
                      );
                    }
                  ),
                  const SizedBox(height: 15,),
                  Consumer<MainProvider>(
                      builder: (context,value,child) {
                        return regiterTextfield(value.nameController,"Name",Colors.black,TextInputType.text);
                      }
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<MainProvider>(
                      builder: (context,value,child) {
                        return regiterTextfield3( value.mobileController,"Mobile Number",Colors.black,TextInputType.number);
                      }
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Consumer<MainProvider>(
                      builder: (context,value,child) {
                        return regiterTextfield2(value.addressController,"House Name",Colors.black,TextInputType.text);
                      }
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<MainProvider>(
                      builder: (context,value,child) {
                        return regiterTextfield(value.placeController,"Place",Colors.black,TextInputType.text);
                      }
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<MainProvider>(
                      builder: (context,val,child) {
                        return InkWell(
                            onTap: () {
                              final FormState? form = _formKey.currentState;
                              if (form!.validate()) {
                                print("fvgbhnjm");
                                provider.adduser(val.userfileBytes,context);

                              }
                            },
                            child: val.adduserLoader?const CircularProgressIndicator(color: Colors.white,):btn(51,width,"Submit")
                        );
                      }
                  ),
                  // Image.asset(ballImg,scale: 1.7,),


                  // SizedBox(height: 150,)

                ],),
            ),
          ),
        ):
        Center(
          child: Container(
              width: width/3,
              decoration: BoxDecoration(image: DecorationImage(image:AssetImage(registrationBkrnd),fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey ,
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      Image.asset(logo2,scale: 3),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone,color:btncolor1 ,size: 10),
                          SizedBox(width: 5,),
                          Text("919946470220",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 13,color: txtclr),)

                        ],
                      ),

                      const SizedBox(height: 60,),
                      const Text("Season Ticket Registration!",style: TextStyle(color: Colors.yellow),),
                      const SizedBox(height: 20,),
                      richtxt("Rs. ",btncolor1,"500",txtclr),
                      const SizedBox(height: 10,),
                      Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return InkWell(
                              onTap: (){
                                value.chooseuserImage(context);
                              },
                              child: Container(
                                  child:value.userfileBytes!=null?
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.white,
                                    backgroundImage:MemoryImage(value.userfileBytes!,) ,
                                  ):
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white,width: 0.5)),
                                      child: Image.asset(profile,scale: 4,))),
                            );
                          }
                      ),
                      const SizedBox(height: 15,),
                      Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return regiterTextfield( value.nameController,"Name",Colors.black,TextInputType.text);
                          }
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return regiterTextfield3( value.mobileController,"Mobile Number",Colors.black,TextInputType.number);
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return regiterTextfield2(value.addressController,"House Name",Colors.black,TextInputType.text);
                          }
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return regiterTextfield(value.placeController,"Place",Colors.black,TextInputType.text);
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Consumer<MainProvider>(
                          builder: (context,val,child) {
                            return InkWell(
                                onTap: () {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    provider.adduser(val.userfileBytes,context);

                                  }

                                },
                                child: val.adduserLoader?const CircularProgressIndicator(color: Colors.white,):btn(51,width,"Submit")
                            );
                          }
                      ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Column(
                  //     children: [
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                    // Image.asset(ballImg,scale: 1.7,),



                      // SizedBox(height: 300,)


                    ],),
                ),
              ),
            ),
          ),


    );
  }
}
