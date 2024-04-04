import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../Constant/myfunctions.dart';
import '../models/exceldata_model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
// import 'package:universal_html/html.dart' as web_file;


class WebProvider extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<ExcelDataModel> userExcelList=[];

  void fetchUserExcelData(BuildContext context){
    String approvedTime ='';
    uploadLoading(context,100);
    db.collection('USERS')
        .get().then((event) {
      userExcelList.clear();
      if(event.docs.isNotEmpty){
        for (var element in event.docs) {
          Map<dynamic, dynamic> map = element.data();
          if(map.containsKey("APPROVED_TIME")){
            approvedTime =  DateFormat('dd-MM-yyyy hh:mm a').format(element.get("APPROVED_TIME").toDate()).toString();
          }else{
            approvedTime='';
          }
          userExcelList.add(ExcelDataModel(
              element.id,
              map['NAME']??"NIL",
              map['PHONE_NUMBER']??"NIL",
              map['STATUS']??"NIL",
              map['CATEGORY']??"NIL",
              map['TOKEN_ID']??"NIL",
              map['PLACE']??"NIL",
              map['HOUSE_NAME']??"NIL",
              map['ADDED_BY']??"WEB",
              map['APPROVED_BY']??"NIL",
              DateFormat('dd-MM-yyyy hh:mm a').format(element.get("ADDED_TIME").toDate()).toString(),
              approvedTime

          ));
          print(userExcelList.length.toString()+" length");
          print(approvedTime.toString()+" cnnnnnnn");

          notifyListeners();

        }
      }
      finish(context);

    });
  }

  void createExcelUsers(List<ExcelDataModel> coordinatorList) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    final List<Object> list = [
      'NAME',
      'PHONE_NUMBER',
      'STATUS',
      'CATEGORY',
      'TOKEN_ID',
      'PLACE',
      'HOUSE_NAME',
      'ADDED_BY',
      'ADDED_TIME',
      'APPROVED_BY',
      'APPROVED_TIME',


    ];
    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in coordinatorList) {
      // int addedTime= 00000000000;
      // int approvedTime= 00000000000;
      // try{
      //   addedTime =int.parse(element.addedTime);
      //   approvedTime =int.parse(element.approvedTime);
      // }catch(e){
      //
      // }


      i++;
      final List<Object> list = [

        element.name,
        element.phone,
        element.status,
        element.category,
        element.tokenId,
        element.place,
        element.houseName,
        element.addedBy,
        element.addedTime,
        // getDate(addedTime.toString()),
        element.approvedBy,
        element.approvedTime,
        // getDate(approvedTime.toString()),

      ];
      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if(!kIsWeb){
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
    else{

      // var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');
      //
      // var anchorElement = web_file.AnchorElement(
      //   href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      // )..setAttribute("download", "data.xlsx")..click();
    }

  }
  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

    var d12 = DateFormat('dd-MMM-yy,hh:mm a').format(dt);
    return d12;
  }

  int i=0;
  uploadLoading(BuildContext context,int total) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Colors.white,
      actions: [
        Row(
          children:  [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(color: Colors.blue),
            ),
            const SizedBox(width: 10,),
            Consumer<WebProvider>(
                builder: (context,value,child) {
                  return Text(value.i.toString());
                }
            ),
            Text(total.toString()+" Uploading..."),
          ],
        )      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}