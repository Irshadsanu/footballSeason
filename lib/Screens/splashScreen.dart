import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Admin/login_screen.dart';
import 'package:football_season/Constant/myfunctions.dart';
import 'package:football_season/Providers/mainprovider.dart';
import 'package:football_season/Screens/registrationScreen.dart';
import 'package:provider/provider.dart';
import '../Constant/images.dart';
import '../Providers/loginprovider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    Timer(const Duration(seconds: 3), () {
      LoginProvider loginProvider =
      Provider.of<LoginProvider>(context, listen: false);

      if(!kIsWeb){
        provider.getPendingUserdata();
        // provider.getApprovedUser();
        provider.gettotalcount();
        // provider.lockApp();
        provider.lockAppQR();
        provider.getCategory500Count();
        provider.getCategoryFreeCount();
        provider.getCategory300Count();


        FirebaseAuth auth = FirebaseAuth.instance;
        var user = auth.currentUser;



          if(user==null){
            callNextReplacement(const LoginScreen(), context);
          }else{
            loginProvider.userAuthorized(user.phoneNumber.toString(), context);
          }



      }else{
        callNextReplacement(RegistrationScreen(), context);
      }


    });
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData= MediaQuery.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body:queryData.orientation==Orientation.portrait?
      Container(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ballImg),alignment: Alignment.bottomRight,scale: 1.7)),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Image.asset(logo2,scale: 2.5),



              SizedBox(height: 25,),
              Image.asset(logonurospine,scale: 2.3,)


          ],),
        ),
      ):Center(
        child: Container(
          height: height,
          width: width/3,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ballImg),alignment: Alignment.bottomRight,scale: 1.7)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(logo2,scale: 2.5),
              const SizedBox(height: 25),
              Image.asset(logonurospine,scale: 2.3,)


            ],),
        ),
      )

    ) ;

  }
}