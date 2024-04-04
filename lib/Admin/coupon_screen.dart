import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:football_season/Constant/images.dart';
import 'package:football_season/Constant/mywidgets.dart';
import 'package:football_season/Providers/mainprovider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constant/mycolor.dart';
import 'package:image/image.dart' as img;

class CouponScreen extends StatelessWidget {
  String category;
   CouponScreen({super.key,required this.category});

  ScreenshotController screenshotController = ScreenshotController();


  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          provider.getPendingUserdata();
          // provider.getApprovedUser();
          provider.gettotalcount();
          provider.clear();
          return true;
        },
        child: Scaffold(
          // appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height:30,),

              Consumer<MainProvider>(
                builder: (context,val,child) {
                  return Screenshot(
                    controller: screenshotController,
                    child: val.userLoader?const Center(child: CircularProgressIndicator()):Container(
                      height:650,
                      width:350,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                            image:category=="Free"||category=="300"
                                ? DecorationImage(image: AssetImage(poster2),fit: BoxFit.fitHeight)
                                :DecorationImage(image: AssetImage(poster1),fit: BoxFit.fitHeight)),
                       child: Consumer<MainProvider>(
                         builder: (context,val,child) {
                           return Padding(
                             padding:  const EdgeInsets.only(top: 120,left:44),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   children: [
                                    val.memberFileImg!=null?Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.file(val.memberFileImg!,fit: BoxFit.fill,)),
                                    ): val.userImage!=""?Container(
                                       height: 80,
                                       width: 80,
                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(10),
                                           child: Image.network(val.userImage!,fit: BoxFit.fill,)),
                                     ):Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(userA,fit: BoxFit.fill,)),
                                    ),
                                     SizedBox(width: 10,),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Row(
                                           children: [
                                             category=="Free"||category=="300"?
                                             Image.asset("assets/PersonBlue.png",scale: 2,):
                                             Image.asset("assets/PersonYellow.png",scale: 2,),
                                             SizedBox(width: 5,),
                                             Text(val.userName,style: TextStyle(color:category=="Free"||category=="300"?blue: Colors.orangeAccent.withOpacity(0.8),
                                                 fontWeight: FontWeight.bold,fontSize: 17 ),),
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             const Icon(Icons.local_phone_outlined,color: Colors.white,size: 15),
                                             SizedBox(width: 5,),
                                             Text(val.userPhone,style: const TextStyle(color:Colors.white),),
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             Image.asset("assets/location.png",scale: 2,),
                                             SizedBox(width: 5,),
                                             Text(val.userPlace,style: const TextStyle(color:Colors.white),),
                                           ],
                                         ),

                                       ],
                                     )
                                   ],
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(top: 31.0,right: 50),
                                   child: Align(
                                     alignment: Alignment.topRight,
                                       child: Text(val.ticketNo,style: TextStyle(color: Colors.red.shade900,fontSize: 18,fontWeight: FontWeight.w600),)),
                                 ),
                                 SizedBox(
                                   height: 30,
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(left: 35,top: 30),
                                   child: Container(
                                     width: 190,
                                     height: 190,
                                     child: QrImage(
                                       padding: const EdgeInsets.all(10),
                                       backgroundColor: Colors.white,
                                       data: val.userID,
                                       version: QrVersions.auto,
                                       size: 100,

                                     ),
                                   ),
                                 )
                               ],
                             ),
                           );
                         }
                       ),
                      ),
                  );
                }
              ),
                SizedBox(height: 20,),
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return InkWell(
                      onTap: (){
                        // value. shareImageStatus(screenshotController);
                        value.shareImageToWhatsApp(screenshotController,value.userPhone);
                        // _captureAndShareImage(value.userPhone);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 13),
                        height:50 ,
                        width: width,
                        decoration: BoxDecoration( image: DecorationImage(image: AssetImage(footBall,),alignment: Alignment.bottomLeft,opacity: 0.5 ),
                          gradient: const LinearGradient(
                              colors: [btncolor1, btncolor2,],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft),
                          borderRadius:  BorderRadius.circular(59),),
                        child: const Center(child: Text("Share",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),)),
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Future<void> _captureAndShareImage(String phoneNumber) async {
  //   try {
  //     final img.Image? image = img.decodeImage(
  //       Uint8List.fromList(await screenshotController.capture() ?? []),
  //     );
  //
  //     final img.Image resizedImage = img.copyResize(image!, width: 200);
  //
  //
  //     final ByteData byteData = ByteData.sublistView(Uint8List.fromList(img.encodePng(resizedImage)));
  //     final String imageUrl = 'data:image/png;base64,${base64Encode(byteData.buffer.asUint8List())}';
  //
  //     final String whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=Check%20out%20this%20screenshot:%20$imageUrl";
  //
  //     await launch(whatsappUrl);
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle error
  //   }
  // }
  // Future<void> _shareScreenshot() async {
  //   try {
  //     // Capture the screenshot
  //     Uint8List? imageBytes = await screenshotController.capture();
  //
  //     if (imageBytes != null) {
  //       // Convert the image to base64
  //       String base64Image = base64Encode(imageBytes);
  //
  //       // Share the image to WhatsApp
  //       await FlutterShareMe().shareToWhatsApp(base64Image);
  //     }
  //   } catch (e) {
  //     print('Error sharing screenshot: $e');
  //   }
  // }
}

