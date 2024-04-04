import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Constant/myfunctions.dart';
import 'package:provider/provider.dart';

import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Providers/mainprovider.dart';
import 'coupon_screen.dart';

class CategorywiseScreen extends StatelessWidget {
  String category;
   CategorywiseScreen({super.key,required this.category});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:  InkWell(onTap: () {
          back(context);
        },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 16,
            color: Colors.white,
          ),
        ),
        title: Text(
          category=="Free"?"Complimentary":"Rs."+category,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          category=="Free"?const SizedBox():
          Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xff272727)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 2.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                ),
              ],),
            child: Consumer<MainProvider>(
              builder: (context,value1,child) {
                return Row(
                  children:  [
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Icon(
                        Icons.currency_rupee,
                        color: Colors.yellow,
                        size: 30,
                      ),
                    ),
                     Text(
                      value1.approvedAmount.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    const SizedBox(
                      width: 125,
                    ),
                    const Icon(
                      Icons.person_2_outlined,
                      color: Colors.yellow,
                      size: 30,
                    ),
                    Text(
                      value1.approvedCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                );
              }
            ),
          ),
          Consumer<MainProvider>(
            builder: (context,val,child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width:  category=="Free"?width/1.3:width/1.1,
                    child: TextFormField(
                      onChanged: (value){
                        val.searchApprovedmemeber(value);
                      },
                      decoration: InputDecoration(fillColor:const Color(0xff272727),filled:true,contentPadding: const EdgeInsets.symmetric(vertical: 4),
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
                  ),
                  category=="Free"?
                  Text(val.approvedUsersList.length.toString(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15,color: btncolor1))
                      :SizedBox(),
                ],
              );
            }
          ),
          const SizedBox(
            height: 20,
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
                      child: InkWell(
                        onTap: () {
                          val.getUserData(item.userid);
                          callNext(context, CouponScreen(category: item.category,));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // item.image != ""
                                  //     ? CircleAvatar(
                                  //   radius: 25,
                                  //   backgroundImage: NetworkImage(
                                  //       item.image.toString()),
                                  // )
                                  //     :
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 12.0),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  item.image!=''?
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(item.image),
                                  ) :InkWell(
                                        onTap: (){
                                      val.showBottomSheetApprovedData(context,item.userid);
                                    },
                                    child:CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(userA),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                          width: width * .37,
                                          child:  Text(
                                            item.username,
                                            style: const TextStyle(
                                                color: Colors.yellow,fontWeight: FontWeight.w500),
                                          )),
                                       Text(
                                        item.mobile,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   width: 80,
                                  // ),
                                  Text(
                                    item.approvedTime,
                                    style: TextStyle(
                                      color: txtclr.withOpacity(.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
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
          )
        ],
      ),
    );
  }
}
