import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:football_season/Providers/webProvider.dart';
import 'package:football_season/test_screen.dart';
import 'package:provider/provider.dart';
import 'Admin/adminHome_screen.dart';
import 'Providers/loginprovider.dart';
import 'Providers/mainprovider.dart';
import 'Screens/splashScreen.dart';
import 'excel_screen.dart';
import 'generateQR.dart';

Future<void> main() async {

  if(!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }else {
    await Firebase.initializeApp(
        options:const FirebaseOptions(
            apiKey: "AIzaSyClS67qAtN2uouvJccOlg4rxPkgXPsRcz0",
            authDomain: "footballseason-dd1d1.firebaseapp.com",
            databaseURL: "https://footballseason-dd1d1-default-rtdb.firebaseio.com",
            projectId: "footballseason-dd1d1",
            storageBucket: "footballseason-dd1d1.appspot.com",
            messagingSenderId: "653147656018",
            appId: "1:653147656018:web:9b5846e3073581ec78348b",
            measurementId: "G-L7EY2NNMY6"
        ));
    runApp(const MyApp());

  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),),
        ChangeNotifierProvider(create: (context) => LoginProvider(),),
        ChangeNotifierProvider(create: (context) => WebProvider(),),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "poppins"),
        title: 'FOOTBALL TOURNAMENT',

        // home: ExcelGenerateScreen(),
        home: const SplashScreen(),
        // home: GenerateQr(),


      ),
    );
  }
}

