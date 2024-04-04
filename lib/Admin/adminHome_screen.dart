import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Admin/qrAdmins_screen.dart';
import 'package:football_season/Admin/scanningReport_screen.dart';
import 'package:football_season/Admin/userslistScreen.dart';
import 'package:football_season/Constant/myfunctions.dart';
import 'package:football_season/Providers/mainprovider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Constant/mywidgets.dart';
import '../qrApp/qrScreen.dart';
import '../qrApp/qrhome.dart';
import 'addQrAdmin_screen.dart';
import 'adminAdd_member.dart';
import 'adminApproved_memeber.dart';
import 'categorywisescreen.dart';
import 'login_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  String addedBy;
   AdminHomeScreen({super.key,required this.addedBy});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope( onWillPop: () async{
      provider.showExitPopup(context);
      return true;
    },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      provider.getAllScannedQrDetails();
                      callNext(context,  QrcodeHomeScreen(addedBy: addedBy,from: "ADMIN",));
                    },
                    child:floatingActnBtn("Scan",Icons.qr_code_scanner)
                ),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      print(DateTime.now().toString()+"ocococ");

                      DateTime firstDate = DateTime.now();
                      provider.getScanningReport(firstDate);
                      callNext(context, const ScanningReportScreen());
                    },
                    child:floatingActnBtn("Report",Icons.receipt)
                ),
              ],
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      provider.addCategory();
                      provider.clear();
                      callNext(context, AdminAddMember(addedBy: addedBy,));
                    },
                    child:floatingActnBtn("add",Icons.add)
                ),

                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      provider.getQrAdmins();
                      callNext(context, QrAdminsScreen());
                      // provider.qrClear();
                      // callNext(context, AddQrAdminScreen());
                    },
                    child:floatingActnBtn("QrAdmin",Icons.add)
                ),
              ],
            )

          ],
        ),   backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 360,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(userlistbkgd)),
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
                  ),
                  child: Column(children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(onTap: ()  {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(backgroundColor: Colors.white,
                                elevation: 20,
                                content: const Text(
                                    "Do you want to Logout ?",style: TextStyle(
                                    fontSize:17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey)),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: (){
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
                                            child: const Center(child: Text("No",style: TextStyle( color: Colors.white,fontSize: 17,fontWeight: FontWeight.w700))),
                                          )),
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth auth = FirebaseAuth.instance;
                                          auth.signOut();
                                          callNextReplacement(const LoginScreen(), context);
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
                                          child: const Center(child: Text("Yes",style: TextStyle( color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700))),
                                        ),
                                      ),

                                    ],
                                  )

                                ],
                              ),
                            );
                          },
                              child: Image.asset(logout,scale: 15))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(logo,scale: 20),
                        const SizedBox(width: 5),
                        SizedBox(width: 174,child: Image.asset(logoTxt2,scale: 13,)),
                      ],
                    ),
                    const SizedBox(height: 6,),
                    SizedBox(width:210,child: Image.asset(sevensballText,scale: 13,)),
                    const SizedBox(height: 30,),
                    const Text("Total Registration",style: TextStyle(color:txtclr,fontSize: 12,fontWeight: FontWeight.w500),),
                    // const SizedBox(height: 10,),
                    Consumer<MainProvider>(
                      builder: (context,value,child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.currency_rupee, color: btncolor1,size: 40,),
                            Text(((value.countfive*500)+(value.countthree*300)).toString(),
                                style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 51,color: btncolor1)),
                          ],
                        );
                      }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_outline, color: txtclr,size: 40,),
                        Consumer<MainProvider>(
                            builder: (context,value,child) {
                              return Text(value.totalregistration.toString(),style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 40,color: txtclr),);
                            }
                        ),],
                    ),
                  ]),
                ),
                const SizedBox(height:22,),
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return Column(
                      children: [
                        Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(onTap: () {
                              value.getApprovedUser("300");
                              callNext(context, CategorywiseScreen(category: "300"));
                             },
                                child: admhomebtn("Rs.",btncolor1,"300",txtclr,(value.countthree*300).toString(),value.countthree.toString())),
                            InkWell(onTap: () {
                              value.getApprovedUser("500");
                              callNext(context, CategorywiseScreen(category: "500"));
                            },
                                child: admhomebtn("Rs.",btncolor1,"500",txtclr,(value.countfive*500).toString(),value.countfive.toString())),
                          ],
                        ),
                        const SizedBox(height:22,),
                        Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(onTap: () {
                              value.getPendingUserdata();
                              callNext(context, UsersListScreen(addedBy: addedBy,));
                              },
                                child: admhomebtn2(pendingicn,"Pending",value.pendingCount.toString())),
                            InkWell(onTap: () {
                              value.getApprovedUser("Free");
                              callNext(context, CategorywiseScreen(category: "Free"));
                              },
                                child: admhomebtn2(Complimentaryicn,"Complimentary",value.countfree.toString())),
                          ],
                        )
                      ],
                    );
                  }
                ),
                SizedBox(height:60,)







          ]),
        ),
      ),
    );
  }
}
