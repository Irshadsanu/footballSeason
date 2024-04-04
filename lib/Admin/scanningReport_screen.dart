import 'package:flutter/material.dart';
import 'package:football_season/Constant/myfunctions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Providers/mainprovider.dart';

class ScanningReportScreen extends StatelessWidget {
  const ScanningReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;

    MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar:  AppBar(
        backgroundColor: Colors.black,
        leading:  InkWell(onTap: () {
          finish(context);
        },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 16,
            color: Colors.white,
          ),
        ),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: (){
                provider.selectDate(context);
              },
                child: const Icon(Icons.calendar_month)),
          ),
        ],
        title: const Text(
          "Scanning Report",
          style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<MainProvider>(
            builder: (context,val,child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child:  Padding(
                  //       padding: const EdgeInsets.only(top:15,left: 25,bottom: 10),
                  //       child: Text( DateFormat('dd-MM-yyyy  EEEE').format(val.firstDate),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15,color: btncolor1),)
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text("Total : "+val.scanningReportList.length.toString(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15,color: btncolor1),),
                  )
                ],
              );
            }
          ),
          Expanded(
            child: Consumer<MainProvider>(
                builder: (context,value,child) {
                  return value.isDateSelected?
                  const Center(child: CircularProgressIndicator(color: Colors.white,))
                      : value.searchData?
                  value.scanningReportList.isNotEmpty?
                         ListView.builder(
                          scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemCount: value.scanningReportList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                         var item=value.scanningReportList[index];
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
                                      item.image!=''?
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(item.image),
                                      ) :CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(userA),
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

                                  // const SizedBox(
                                  //   width: 80,
                                  // ),
                                  Text(

                                    item.milliTme,
                                    style: TextStyle(
                                      color: txtclr.withOpacity(.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
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
                  ):
                  const Center(child: Text("Please Select Date",style: TextStyle(color: Colors.white,fontSize: 15)))
                      : const Center(child: Text("No Data Found...!",style: TextStyle(color: Colors.white,fontSize: 15),));
                }
            ),
          ),
        ],
      ),
    );
  }
}
