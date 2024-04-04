import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constant/images.dart';
import '../Providers/mainprovider.dart';

class AdminApprovedMemeber extends StatelessWidget {
  const AdminApprovedMemeber({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [

              SizedBox(height: 60,),

              Padding(
                padding: const EdgeInsets.only(left: 318.0),
                child: Image.asset(logout,scale: 15,),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 75.0),
                child: Row(
                  children: [
                    Image.asset(logo,scale: 25),

                    SizedBox(width: 174,child: Image.asset(logoTxt2,scale: 15,)),
                  ],
                ),
              ),
              SizedBox(height: 6,),
              // SizedBox(width:210,child: Image.asset(sevensballText,scale: 20,)),
              SizedBox(height: 25,),
              Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return Text(value.totalregistration.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.yellow),);
                  }
              ),
              SizedBox(height: 8,),

              Image.asset(totalreg,scale: 45,),

            ],
          ),
          Expanded(
            child: Consumer<MainProvider>(builder: (context, val, child) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: val.approvedUsersList.length,
                  itemBuilder: (context, index) {
                    var item = val.approvedUsersList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
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
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: width * .3,
                                        child: Text(
                                          item.username,
                                          style:
                                          TextStyle(color: Colors.yellow),
                                        )),
                                    Text(
                                      item.mobile,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Text(item.status,style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
