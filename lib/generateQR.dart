import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatelessWidget {
  const GenerateQr({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 35,top: 30),
        child: Container(
          width: 500,
          height: 500,
          child: QrImage(
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.white,
            data: "https://footballseason-dd1d1.web.app",
            version: QrVersions.auto,
            size: 100,

          ),
        ),
      ),
    );
  }
}
