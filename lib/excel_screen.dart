import 'package:flutter/material.dart';
import 'package:football_season/Providers/webProvider.dart';
import 'package:provider/provider.dart';

class ExcelGenerateScreen extends StatelessWidget {
  const ExcelGenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                webProvider.fetchUserExcelData(context);
              },
              child: Container(
                height: 45,
                width: 170,
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text("Get Users")),
              ),
            ),

            SizedBox(height: 10,),
            Consumer<WebProvider>(
              builder: (context,val,child) {
                return InkWell(
                  onTap: (){
                    webProvider.createExcelUsers(val.userExcelList);
                  },
                  child: Container(
                    height: 45,
                    width: 170,
                    decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Text("Download Excel")),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
