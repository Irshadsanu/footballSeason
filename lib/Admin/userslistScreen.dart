import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Admin/coupon_screen.dart';
import 'package:football_season/Admin/login_screen.dart';
import 'package:football_season/Constant/myfunctions.dart';
import 'package:football_season/Providers/mainprovider.dart';
import 'package:provider/provider.dart';

import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Constant/mywidgets.dart';
import '../Screens/registrationScreen.dart';
import '../Constant/myfunctions.dart';
import '../qrApp/qrScreen.dart';
import 'adminAdd_member.dart';
import 'login_screen.dart';

class UsersListScreen extends StatelessWidget {
  String addedBy;
  UsersListScreen({super.key,required this.addedBy});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:  InkWell(onTap: () {
          back(context);
        },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 16,
            color: Colors.white,
          ),
        ),
        title: const Text("Pending",
          style: TextStyle(color: txtclr, fontSize: 15,fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
             // Container(
          //   height: 80,
          //   margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     border: Border.all(color: const Color(0xff272727)),
          //     boxShadow: const [
          //       BoxShadow(
          //         color: Color(0x26000000),
          //         blurRadius: 2.0, // soften the shadow
          //         spreadRadius: 1.0, //extend the shadow
          //       ),
          //     ],),
          //   child: Consumer<MainProvider>(
          //       builder: (context,value1,child) {
          //         return Row(
          //           children:  [
          //             const Padding(
          //               padding: EdgeInsets.only(left: 25.0),
          //               child: Icon(
          //                 Icons.currency_rupee,
          //                 color: Colors.yellow,
          //                 size: 30,
          //               ),
          //             ),
          //             const Text(
          //               "18,000",
          //               style: TextStyle(color: Colors.white, fontSize: 25),
          //             ),
          //             const SizedBox(
          //               width: 110,
          //             ),
          //             const Icon(
          //               Icons.person_2_outlined,
          //               color: Colors.yellow,
          //               size: 30,
          //             ),
          //             Text(
          //               value1.totalregistration.toString(),
          //               style: const TextStyle(color: Colors.white, fontSize: 25),
          //             )
          //           ],
          //         );
          //       }
          //   ),
          // ),
      //     Container(
      //       decoration: BoxDecoration(
      //         color: const Color(0xff272727),
      //         image: DecorationImage(image: AssetImage(fbnet)),
      //         borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
      //       ),
      //       child: Column(
      //         children: [
      //
      //       const SizedBox(height: 40),
      //
      //
      //       // Padding(
      //       //   padding: const EdgeInsets.only(right: 8.0,top: 5),
      //       //   child: Align(
      //       //       alignment: Alignment.topRight,
      //       //       child: InkWell(
      //       //           onTap: ()  {
      //       //         provider.getApprovedUser();
      //       //         provider.getPendingUserdata();
      //       //       },
      //       //           child: Container(
      //       //             height: 30,
      //       //               width: 30,
      //       //               decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(5)),
      //       //               child: Icon(Icons.refresh,color: Colors.white,)))),
      //       // ),
      //
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Image.asset(logo,scale: 20),
      //
      //           SizedBox(width: 174,child: Image.asset(logoTxt2,scale: 15,)),
      //         ],
      //       ),
      //       const SizedBox(height: 6,),
      //       SizedBox(width:210,child: Image.asset(sevensballText,scale: 15,)),
      //       const SizedBox(height: 25,),
      //       Consumer<MainProvider>(
      //           builder: (context,value,child) {
      //             return Text(value.totalregistration.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.yellow),);
      //           }
      //       ),
      //       const SizedBox(height: 8,),
      //
      //       Image.asset(totalreg,scale: 45,),
      //
      //     // const TabBar(
      //     //   indicatorColor: Colors.yellow,
      //     //     indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
      //     //     indicatorWeight: 4,
      //     //     labelColor: Colors.white,
      //     //     unselectedLabelColor: Colors.grey,
      //     //     tabs: [
      //     //       Tab(text: "APPROVED"),
      //     //       Tab(text: "PENDING"),
      //     //   ])
      //
      //     ],
      //   ),
      // ),

    //   Expanded(
    //     child: TabBarView(children: [
    //       Consumer<MainProvider>(builder: (context, val, child) {
    //         return ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: val.approvedUsersList.length,
    //             itemBuilder: (context, index) {
    //               var item = val.approvedUsersList[index];
    //
    //             return
    //               Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //               child: InkWell(
    //                 onTap: (){
    //                   val.getUserData(item.userid);
    //                   callNext(context, CouponScreen(category: item.category,));
    //                   },
    //                 // onLongPress: (){
    //                 //   editDeleteAlert(context,item.userid);
    //                 // },
    //                 child: Container(
    //                   child: Column(
    //                     children: [
    //                       Row(
    //                         children: [
    //                           item.image != ""
    //                               ? CircleAvatar(
    //                             radius: 25,
    //                             backgroundImage: NetworkImage(
    //                                 item.image.toString()),
    //                           )
    //                               : CircleAvatar(
    //                             radius: 25,
    //                             backgroundColor: Colors.white,
    //                             backgroundImage: AssetImage(userA),
    //                           ),
    //                           const SizedBox(
    //                             width: 5,
    //                           ),
    //                           Column(
    //                             crossAxisAlignment:
    //                             CrossAxisAlignment.start,
    //                             children: [
    //                               SizedBox(
    //                                   width: width * .3,
    //                                   child: Text(
    //                                     item.username,
    //                                     style:
    //                                     const TextStyle(color: Colors.yellow),
    //                                   )),
    //                               Text(
    //                                 item.mobile,
    //                                 style: const TextStyle(color: Colors.white),
    //                               ),
    //                             ],
    //                           ),
    //                           const SizedBox(
    //                             width: 80,
    //                           ),
    //                           Text(item.status,style: const TextStyle(color: Colors.white),)
    //                         ],
    //                       ),
    //                       const SizedBox(
    //                         height: 30,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           });
    //     }),
          Consumer<MainProvider>(
            builder: (context,value1,child) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: TextFormField(
                  onChanged: (value) {
                         value1.searchMember(value);
                },
                  decoration: InputDecoration(
                    fillColor:const Color(0xff272727),filled:true,contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white60, width: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white60, width: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white60, width: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),

                  ),
                  style: TextStyle(color: Colors.white),

                ),

              );
            }
          ),
          SizedBox(height: 15,),
          Expanded(
            child: Consumer<MainProvider>(builder: (context, val, child) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: val.usersList.length,
                  itemBuilder: (context, index) {
                    var item = val.usersList[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    provider.addCategory();
                    val.memberFileImg=null;
                    alert(context,item.userid,item.username,item.mobile,item.image,item.address,item.place);
                    },
                      child: Container(
                        child: Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 12.0),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  item.image != ""
                                      ? CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        item.image.toString()),
                                  )
                                      : CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(userA),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: width * .4,
                                          child: Text(
                                            item.username,
                                            style:
                                            const TextStyle(color: Colors.yellow),
                                          )),
                                      Text(
                                        item.mobile,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        item.addedTime,
                                        style:  TextStyle(color: Colors.white.withOpacity(0.7)),
                                      ),
                                    ],
                                  ),
                                ],),

                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        provider.makingPhoneCall(item.mobile);
                                      },
                                        child: Image.asset(phone,scale: 2,)),
                                    SizedBox(width: 5,),
                                    InkWell(
                                      onTap: (){
                                        provider.whatsappLaunch(number: item.mobile, message: '');
                                      },
                                        child: Image.asset(whatsapp,scale: 2,)),
                                    SizedBox(width: 15,)
                                  ],
                                )
                                // Text(item.status,style: const TextStyle(color: Colors.white),)
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
        }),
          ),
    //
    //   ]),
    // )

    ],
    ),
    );
  }

  alert(BuildContext contxt,String id,String name,String phone,String image,String address,String place){
    MainProvider provider = Provider.of<MainProvider>(contxt, listen: false);
    var height = MediaQuery.of(contxt).size.height;
    var width = MediaQuery.of(contxt).size.width;
    showDialog(
      barrierDismissible: false,
      context: contxt,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title:Container(
          // height: 230,
          padding: EdgeInsets.zero,
          // color: Colors.red,
          child: Consumer<MainProvider>(
            builder: (context,value,child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 image != ""
                      ? Container(width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15)),
                         child: Image.network(image, fit: BoxFit.fill),
                 )
                      : InkWell(
                         onTap: (){
                           provider.showBottomSheet(context);
                        },
                        child: value.memberFileImg!=null?
                         Container(width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15)),
                             child: Image.file(value.memberFileImg!,fit: BoxFit.fill,),
                         )
              // CircleAvatar(
              //            radius: 35,
              //             backgroundColor: Colors.white,
              //              backgroundImage: FileImage(value.memberFileImg!),
              //           )
                        :Container(width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(userA, fit: BoxFit.fill),
                        ),
                        // CircleAvatar(
                        //   radius: 35,
                        //   backgroundColor: Colors.white,
                        //   backgroundImage: AssetImage(userA),
                        //   ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(name,style: const TextStyle(color: btncolor1,fontSize: 16,fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(phone,style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(place,style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(address,style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                  ),

               Consumer<MainProvider>(
                builder: (context, value, child) {
                return Container(
                  height: height*0.08,
                  width: width*0.8,
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
                                height:40,
                                width: 70,
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
                   );
                  }
                 )
                ],
              );
            }
          ),
        ),
        actions: <Widget>[
          Consumer<MainProvider>(
              builder: (context1, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        finish(context);
                      },
                      child: Container(
                        height: 35,
                        width: 109,
                        decoration: BoxDecoration(
                            color: btncolor1,
                            borderRadius:
                            BorderRadius.circular(95),
                            border: Border.all(width: 1.5,
                                color: Colors.black)),
                        child: const Center(child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                      ),
                    ),
                    InkWell(
                      onTap: ()
                      {
                        if(value.selectedCategory!=''){
                          provider.approveRequests(id,context,addedBy,image);
                          finish(contxt);
                          provider.getPendingUserdata();
                          callNext(context,CouponScreen(category: value.selectedCategory),);
                        }else{
                          const snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Please select Category',
                              style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        },
                      child: value.approveLoader?const CircularProgressIndicator():Container(
                        height: 35,
                        width: 109,
                        decoration: BoxDecoration(
                            color: btncolor1,
                            borderRadius:
                            BorderRadius.circular(95),
                            border: Border.all(width: 1.5,
                                color: Colors.black)),
                        child: const Center(child: Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                      ),
                    ),
                  ],
                );

              })
        ],



      ),
    );
  }

  editDeleteAlert(BuildContext context,String memberId) {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Text(
        "Do you want to delete?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: Consumer<MainProvider>(
          builder: (context,value,child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        finish(context);
                      },
                      child: Container(
                        height: 45,
                        width: 110,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient:  LinearGradient(
                              colors: [btncolor1, btncolor2,],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 2.0, // soften the shadow
                              spreadRadius: 1.0, //extend the shadow
                            ),
                          ],
                        ),
                        child: const Center(child: Text("Cancel",style: TextStyle( color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700))),

                      ),
                    ),
                    InkWell(
                      onTap: (){
                        mainProvider.delete(memberId);
                        const snackBar = SnackBar(
                            content: Text('Deleted Successfully'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        finish(context);
                        // mainProvider.getApprovedUser();
                      },
                      child: Container(
                        height: 45,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 2.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                              ),
                            ] ),
                        child: const Center(child: Text("Delete",style: TextStyle( color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700))),
                      ),
                    ),

                  ],
                ),
              ],
            );
          }
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
