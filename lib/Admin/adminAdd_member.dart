import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Constant/myfunctions.dart';
import '../Constant/mywidgets.dart';
import '../Providers/mainprovider.dart';
import 'coupon_screen.dart';

class AdminAddMember extends StatelessWidget {
  String addedBy;
   AdminAddMember({super.key,required this.addedBy});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: width,
          decoration: BoxDecoration(image: DecorationImage(image:AssetImage(registrationBkrnd),fit: BoxFit.fitWidth)),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 35,),
                  Image.asset(logo,scale: 4),
                  const SizedBox(height: 10,),
                  Image.asset(logoTxt3,scale: 10,),
                  const SizedBox(height: 30,),
                  const Text("Season Ticket Registration!",style: TextStyle(color: Colors.yellow),),
                  const SizedBox(height: 10,),
                  Consumer<MainProvider>(
                      builder: (context,value,child) {
                        return InkWell(
                          onTap: (){
                            value.showBottomSheet(context);
                          },
                          child: Container(
                              child:value.memberFileImg!=null?
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage:FileImage(value.memberFileImg!,) ,
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
                  const Align(
                    alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 22.0),
                        child: Text("Select Category",style: TextStyle(color: Colors.white),),
                      )),
                  Consumer<MainProvider>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            Container(
                              height: height*0.08,
                              width: width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                              // color: Colors.yellow,
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(15),
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: value.categoryList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var item=value.categoryList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          provider.selectCategory(index, item.category);
                                        },
                                        child: Container(
                                            height:30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                border:item.selection?  Border.all(color: Colors.white):Border.all(color: Colors.white,width: 0.5),
                                                color: item.selection?Colors.white:Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)

                                            ),
                                            child: Center(
                                                child: Text(item.category!="Free"?"₹${item.category}"
                                                    :item.category,
                                                  style:  item.selection?textsty2:textsty,))),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        );
                      }
                  ),
              // Consumer<MainProvider>(
              //   builder: (context,value,child) {
              //     return Container(
              //       margin: EdgeInsets.symmetric(
              //           horizontal:22),
              //       width: width,
              //       height:51,
              //       decoration: BoxDecoration(
              //          boxShadow:  [
              //         BoxShadow(
              //         blurStyle: BlurStyle.outer,
              //
              //         color: shadowColor.withOpacity(0.25),
              //         blurRadius: 5.0,
              //       ),
              //         ],
              //           color: Colors.black,
              //           borderRadius:
              //           BorderRadius.circular(59),border: Border.all(color: Colors.white60,width: 0.1)),
              //       child: DropdownButton(
              //
              //         // Initial Value
              //         underline: Container(color: Colors.white),
              //         value: value.dropdownvalue,
              //
              //         icon: Icon(
              //             Icons.keyboard_arrow_down,
              //             color:txtclr.withOpacity(.7)
              //         ),
              //
              //         items: value.Type.map((String item) {
              //           return DropdownMenuItem(
              //             value: item,
              //             child: Center(child: Text(item,style: TextStyle(color: Colors.white),)),
              //           );
              //         }).toList(),
              //
              //         onChanged: (String? newValue) {
              //           value.dropdown(newValue!);
              //         },
              //       ),
              //     );
              //   }
              // ),


                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<MainProvider>(
                      builder: (context,val,child) {
                        return InkWell(
                            onTap: () {
                              final FormState? form = _formKey.currentState;
                              if (form!.validate()) {
                                if(val.selectedCategory!=""){
                                  val.addadminuser(context,addedBy);

                                }else{
                                  const snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                      content: Text('Select Category',style: TextStyle(color: Colors.white),));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                                print("fvgbhnjm");



                              }
                            },
                            child: val.addAdminLoader?const CircularProgressIndicator(color: Colors.white,):btn(51,width,"Submit")
                        );
                      }
                  ),
                  // Image.asset(ballImg,scale: 1.7,),


                  // SizedBox(height: 150,)

                ],),
            ),
          ),
        )
    );
  }
}
