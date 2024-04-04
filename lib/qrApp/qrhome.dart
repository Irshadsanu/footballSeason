import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Admin/adminHome_screen.dart';
import 'package:football_season/qrApp/qrScreen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Admin/login_screen.dart';
import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Constant/myfunctions.dart';
import '../Providers/mainprovider.dart';




class QrcodeHomeScreen extends StatefulWidget {
  String from;
  String addedBy;
   QrcodeHomeScreen({Key? key,required this.addedBy,required this.from}) : super(key: key);

  @override
  State<QrcodeHomeScreen> createState() => _QrcodeHomeScreenState();
}

class _QrcodeHomeScreenState extends State<QrcodeHomeScreen> {

  TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;


    return WillPopScope(
      onWillPop: () async {
        if(widget.from=="ADMIN"){
          return false;
        }else{
          provider.showExitPopup(context);
        }
         return false;
      },
      child: Scaffold(
        backgroundColor:  Colors.black,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: (){
              // donationProvider.getScannedQrDetails();

              callNext( context,   qrpage(addedBy:widget.addedBy, userType:widget. from,),);
            },
            child: SizedBox(
              height: 60,
              width: 200,
              child: Card(
                color: btncolor1,
                elevation: 2,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.white, width: 1)),
                child: const Center(
                    child: Text(
                      "Scan QrCode",
                      style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ),
        ),
        appBar:  AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: widget.from=="ADMIN"?true:false,

          leading:  widget.from=="ADMIN"?InkWell(onTap: () {
            callNext(context, AdminHomeScreen(addedBy: widget.addedBy));
          },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 16,
              color: Colors.white,
            ),
          ):SizedBox(),
          title: const Text(
           "Today Scanned Tickets",
            style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
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
                                    gradient:  const LinearGradient(
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
          ),],
        ),
        body: Column(
          children: [

            Align(
              alignment: Alignment.topLeft,
              child:  Padding(
                padding: const EdgeInsets.only(top:15,left: 25,bottom: 10),
                child: Text( DateFormat('dd-MM-yyyy  EEEE').format(DateTime.now()),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15,color: btncolor1),)
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10),
              child: Consumer<MainProvider>(
                  builder: (context,val,child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: width/1.3,
                          child: TextFormField(
                            onChanged: (value){
                              val.searchScannedTickets(value);
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
                            style: const TextStyle(color: Colors.white),

                          ),
                        ),
                        Text(val.qrScannedModelList.length.toString(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15,color: btncolor1)),
                      ],
                    );
                  }
              ),
            ),

            Expanded(
              child: Consumer<MainProvider>(
                  builder: (context,value,child) {
                    // if(value.lock){
                    //
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  Update(ADDRESS:"CONVACATION", button:"CONVACATION", text:"CONVACATION",
                    //   )
                    //   )
                    //   );
                    //
                    // }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*.64,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemCount: value.searchqrScannedModelList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var item=value.searchqrScannedModelList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // item.image != ""
                                      //     ? CircleAvatar(
                                      //   radius: 25,
                                      //   backgroundImage: NetworkImage(
                                      //       item.image.toString()),
                                      // )
                                      //     :
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
                                          item.image!=''?
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(item.image),
                                          ) :CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: Image.asset(userA,scale: 3.5),
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
                                                    item.name,
                                                    style: const TextStyle(
                                                        color: Colors.yellow,fontWeight: FontWeight.w500),
                                                  )),
                                              Text(
                                                item.phone,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      // const SizedBox(
                                      //   width: 80,
                                      // ),
                                      Text(
                                          DateFormat(' HH:mm aa').format(item.milliTme.toDate()).toString(),
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
                          );
                        },
                      ),
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
}
