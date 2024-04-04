import 'package:flutter/material.dart';
import 'package:football_season/Providers/mainprovider.dart';
import 'package:provider/provider.dart';

import '../Constant/mycolor.dart';
import '../Constant/myfunctions.dart';
import '../Constant/mywidgets.dart';
import 'addQrAdmin_screen.dart';

class QrAdminsScreen extends StatelessWidget {
  const QrAdminsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;

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
        title: const Text(
          "QrAdmins",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<MainProvider>(
            builder: (context,value,child) {
              return Expanded(
                child:value.qrAdminsLoader?
                const Center(
                    child: CircularProgressIndicator(color: Colors.white,)):
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemCount: value.qrAdminsList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var item=value.qrAdminsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
          )
        ],
      ),
      floatingActionButton: InkWell(
        onTap: (){
          provider.qrClear();
          callNext(context, AddQrAdminScreen());
        },
          child: floatingActnBtn("Add",Icons.add))
    );
  }
}
