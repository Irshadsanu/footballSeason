import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_season/Constant/mywidgets.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Providers/loginprovider.dart';


enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  late BuildContext context;
  String Code = "";
  late String verificationId;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpPage = false;

  Future<void> signInWithPhoneAuthCredential(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    if (kDebugMode) {
      print('done 1  $phoneAuthCredential');
    }
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print(' 1  $phoneAuthCredential');
      }
      setState(() {
        showLoading = false;
      });
      try {
        var LoginUser = authCredential.user;
        if (LoginUser != null) {
          LoginProvider loginProvider = LoginProvider();
          loginProvider.userAuthorized(LoginUser.phoneNumber, context);

          if (kDebugMode) {
            print("Login SUccess");

          }
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          e.message ?? "",
        ),
      ));
    }
  }

  final FocusNode _pinPutFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


  Widget getUserMobileFormWidget(context) {
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        height: hieght,
        decoration: BoxDecoration(image: DecorationImage(image:AssetImage(registrationBkrnd),fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Image.asset(logo,scale: 5),
                const SizedBox(height: 10),
                Image.asset(logoTxt3,scale: 7),
                const SizedBox(height: 300),
                const Align(
                  alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Login!",style: TextStyle(color: Colors.yellow),),
                    )),
                const SizedBox(height: 20),
                Material(
                  elevation: 2,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: phoneController,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      if (value.length == 10) {
                        showTick = true;
                        SystemChannels.textInput
                            .invokeMethod('TextInput.hide');
                      } else {
                        showTick = false;
                      }

                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder:border,
                      enabledBorder:border,
                      border: border,
                      filled: true,
                      fillColor: Colors.black,
                      //   focusedBorder: customFocusBorder,
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(color:txtclr.withOpacity(.7)),
                      // enabledBorder: customFocusBorder,
                      //   border: customFocusBorder,
                      // filled: true,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                showLoading
                    ? const Center(
                     child: CircularProgressIndicator(
                      color: Colors.white,
                  ),
                )
                    : InkWell(
                     onTap: () async {
                    print(phoneController.text.toString()+"kokokok");

                    // db.collection("ADMIN").where("PHONE", isEqualTo:"+91${phoneController.text}").get().then((val) async {
                    //   if (val.docs.isNotEmpty) {
                        setState(() {
                          if (phoneController.text.length == 10) {
                            print(phoneController.text.toString()+"yrftury");
                            showLoading = true;
                          }
                        });
                        await auth.verifyPhoneNumber(
                            phoneNumber: "+91${phoneController.text}",
                            verificationCompleted:
                                (phoneAuthCredential) async {
                              setState(() {
                                showLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Verification Completed"),
                                duration: Duration(milliseconds: 3000),
                              ));
                              if (kDebugMode) {}
                            },
                            verificationFailed:
                                (verificationFailed) async {
                              setState(() {
                                print("ftryeri90ew"+phoneController.text.toString());

                                print(verificationFailed.phoneNumber);
                                print("kikikikikiki"+ verificationFailed.message.toString()+""+verificationFailed.phoneNumber.toString());
                                showLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                Text("Sorry, Verification Failed"),
                                duration: Duration(milliseconds: 3000),
                              ));
                              if (kDebugMode) {
                                print(verificationFailed.message.toString());
                              }
                            },
                            codeSent:
                                (verificationId, resendingToken) async {
                              setState(() {
                                showLoading = false;
                                currentSate = MobileVarificationState
                                    .SHOW_OTP_FORM_STATE;
                                this.verificationId = verificationId;

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "OTP sent to phone successfully"),
                                  duration:
                                  Duration(milliseconds: 3000),
                                ));

                                if (kDebugMode) {
                                  print("");
                                }
                              });
                            },
                            codeAutoRetrievalTimeout:
                                (verificationId) async {});
                      // }
                      // else {
                      //   const snackBar = SnackBar(
                      //       backgroundColor: Colors.white,
                      //       duration: Duration(milliseconds: 3000),
                      //       content: Text("Sorry , You don't have any access",
                      //         textAlign: TextAlign.center,
                      //         softWrap: true,
                      //         style: TextStyle(
                      //             fontSize: 18,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.bold),
                      //       ));
                      //
                      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // }
                    // });


                  },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 22),
                        height:51 ,
                        width: width,
                        decoration: BoxDecoration( image: DecorationImage(image: AssetImage(footBall,),alignment: Alignment.bottomLeft,opacity: 0.5 ),
                          gradient: const LinearGradient(
                              colors: [btncolor1, btncolor2,],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft),
                          borderRadius:  BorderRadius.circular(59),),
                        child: const Center(child: Text("Submit",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),))
                      )),



              ],),
          ),
        ),
      ),
    );
  }

  Widget getUserOtpFormWidget(context) {
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        width: width,
        height: hieght,
        decoration: BoxDecoration(image: DecorationImage(image:AssetImage(registrationBkrnd),fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                Image.asset(logo,scale: 5),
                const SizedBox(height: 10,),
                Image.asset(logoTxt3,scale: 7,),
                const SizedBox(height: 250,),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Login!",style: TextStyle(color: Colors.yellow),),
                    )),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 18,right: 18,top: 15,bottom: 15),
                  child: PinFieldAutoFill(
                    controller: otpController,
                    codeLength: 6,
                    focusNode: _pinPutFocusNode,
                    autoFocus: true,
                    keyboardType: TextInputType.number,
                    decoration: BoxLooseDecoration(
                      textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      radius: Radius.circular(40),
                      strokeColorBuilder: FixedColorBuilder(Colors.white24),
                    ),
                    onCodeChanged: (pin) {
                      if (pin!.length == 6) {
                        PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: pin);
                        signInWithPhoneAuthCredential(
                            context, phoneAuthCredential);
                        otpController.text = pin;
                        print(otpController.text+"ersgver");
                        setState(() {
                          Code = pin;
                        });
                      }
                    },
                  ),
                ),

                Container(
                    margin: EdgeInsets.symmetric(vertical: 22),
                    height:51 ,
                    width: width,
                    decoration: BoxDecoration( image: DecorationImage(image: AssetImage(footBall,),alignment: Alignment.bottomLeft,opacity: 0.5 ),
                      gradient: const LinearGradient(
                          colors: [btncolor1, btncolor2,],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft),
                      borderRadius:  BorderRadius.circular(59),),
                    child: const Center(child: Text("Submit Otp",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),))
                ),
                showLoading
                    ? const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
                    : Container(),


              ],),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
          key: scaffoldKey,
          body:currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
          // getMobileFormWidget
              ? getUserMobileFormWidget(context)
              : getUserOtpFormWidget(context),
      ),
    );
  }

}

