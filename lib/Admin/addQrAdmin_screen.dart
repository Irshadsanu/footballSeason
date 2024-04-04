import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constant/myfunctions.dart';
import '../Constant/mywidgets.dart';
import '../Providers/mainprovider.dart';

class AddQrAdminScreen extends StatelessWidget {
   AddQrAdminScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

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
          "Add QrAdmin",
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15,),
            Consumer<MainProvider>(
                builder: (context,value,child) {
                  return regiterTextfield(value.qrAdminName,"Name",Colors.black,TextInputType.text);
                }
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<MainProvider>(
                builder: (context,value,child) {
                  return regiterTextfield3( value.qrAdminPhone,"Mobile Number",Colors.black,TextInputType.number);
                }
            ),
            SizedBox(
              height: 35,
            ),
            Consumer<MainProvider>(
              builder: (context,val,child) {
                return InkWell(
                  onTap: (){
                    final FormState? form = _formKey.currentState;
                    if (form!.validate()) {
                      provider.addQrAdmin(context);
                    }
                  },
                    child:val.qrLoader?const CircularProgressIndicator(): btn(51,width,"Submit"));
              }
            )
          ],
        ),
      ),
    );
  }
}
