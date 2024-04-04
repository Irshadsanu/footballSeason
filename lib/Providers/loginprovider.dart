import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Admin/userslistScreen.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../Admin/adminHome_screen.dart';
import '../Admin/categorywisescreen.dart';
import '../Constant/myfunctions.dart';
import '../qrApp/qrScreen.dart';
import '../qrApp/qrhome.dart';
import 'mainprovider.dart';

class LoginProvider extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? packageName;

  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    String loginUsername='';
    String loginUsertype='';
    String loginUserid='';
    String loginPhone='';
    String userId='';
    String from='';
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
       packageName  = packageInfo.packageName;
      var phone = phoneNumber!;

      db.collection("ADMIN").where("PHONE",isEqualTo:phone).get().then((value) {
        if(value.docs.isNotEmpty){
          for(var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();
            loginUsername = map['NAME'].toString();
            loginUsertype = map['TYPE'].toString();
            loginPhone= map["PHONE"].toString();
            loginUserid = element.id;
            String uid = loginUserid;
            if (loginUsertype == "ADMIN"&& packageName =="com.spine.football_season") {
              callNextReplacement(AdminHomeScreen(addedBy: loginPhone,), context);
              // callNextReplacement(UsersListScreen(addedBy: loginPhone), context);

            }else if(loginUsertype == "SCANNER" && packageName =="com.spine.football_season_scanner"){

              provider.getAllScannedQrDetails();
              callNextReplacement(  QrcodeHomeScreen(addedBy: loginPhone ,from: "ScannerApp"),context);
            }
          }

        }
        else {
          const snackBar = SnackBar(
              backgroundColor: Colors.white,
              duration: Duration(milliseconds: 3000),
              content: Text("Sorry , You don't have any access",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

      });


    } catch (e) {


      // const snackBar = SnackBar(
      //     backgroundColor: Colors.white,
      //     duration: Duration(milliseconds: 3000),
      //     content: Text("Sorry , Some Error Occurred",
      //       textAlign: TextAlign.center,
      //       softWrap: true,
      //       style: TextStyle(
      //           fontSize: 18,
      //           color: Colors.black,
      //           fontWeight: FontWeight.bold),
      //     ));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  // Future<void> getPackageName() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   packageName = packageInfo.packageName;
  //   print("${packageName}packagenameee");
  //   notifyListeners();
  // }
}