import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constant/images.dart';




class Update extends StatelessWidget {
  String text;
  String button;
  String ADDRESS;
  Update({Key? key,required this.text,required this.button,required this.ADDRESS}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:   const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,Colors.black
                  ]
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 130,
                margin: const EdgeInsets.only(bottom: 40),

                decoration:  BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(logo),

                    scale: 1,
                    fit: BoxFit.fitHeight,
                  ),
                ),

              ),
              Container(
                height: 80,
                margin: const EdgeInsets.only(bottom: 40),

                decoration:  BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(logoTxt3),

                    scale: 3,
                    fit: BoxFit.fitHeight,
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(text,style: const TextStyle(
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color:Colors.white
                )),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: InkWell(
              //     splashColor: Colors.white,
              //     onTap: (){
              //       // _launchURL(ADDRESS);
              //     },
              //     child: Container(
              //       height: 40,
              //       width: 150,
              //
              //       decoration: BoxDecoration(
              //           gradient:  const LinearGradient(
              //               colors: [
              //                 Colors.blue,Colors.blueGrey
              //               ]
              //           ),
              //           borderRadius: BorderRadius.circular(30)
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 10),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children:  [
              //             Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 10,),
              //               child: Text(button,style:  const TextStyle(
              //                 fontWeight: FontWeight.w500,
              //                 fontSize: 15,
              //                 fontFamily: 'Montserrat',
              //                 color: Colors.white,
              //               ),),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logonurospine,scale:3),
            ],
          ),
        ),


      ),
    );

  }
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
