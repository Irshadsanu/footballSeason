import 'package:flutter/material.dart';
import 'package:football_season/Constant/myfunctions.dart';
import 'package:football_season/Constant/mywidgets.dart';
import 'package:football_season/qrApp/qrhome.dart';

import '../Constant/images.dart';
import '../Constant/mycolor.dart';

class ScanRejection extends StatelessWidget {
  String addedBy;
  String from;
   ScanRejection({super.key,required this.addedBy,required this.from});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(height: 20,),
            ],
          ),
          Column(
            children: [
              Image.asset(rejectionIcon,scale: 3),
              SizedBox(height: 15,),
              Image.asset(warningIcon,scale: 10),
              const Text("Already Scanned",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15,color: btncolor1))
            ],
          ),
          InkWell(
            onTap: () {
              callNext(context, QrcodeHomeScreen(addedBy: addedBy, from: from,));
            },
              child: btn2(50, 250, "Go Back"))
        ],
      ),
    );
  }
}
