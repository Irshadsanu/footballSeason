import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crop_image/crop_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:football_season/Admin/coupon_screen.dart';
import 'package:football_season/Constant/mywidgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:url_launcher/url_launcher.dart';
// import 'package:package_info_plus/package_info_plus.dart';

import '../Constant/images.dart';
import '../Constant/mycolor.dart';
import '../Constant/myfunctions.dart';
import '../Admin/update.dart';
import '../Screens/registraction_SuccessfulScreen.dart';
import '../models/category_model.dart';
import '../models/qrAdmins_model.dart';
import '../models/qrModelList.dart';
import '../models/scanningReport_model.dart';
import '../models/user_model.dart';
import 'package:intl/intl.dart';
import '../deviceinfo.dart';
import '../qrApp/qrhome.dart';
import '../qrApp/scan_rejection_page.dart';

class MainProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Reference ref = FirebaseStorage.instance.ref("IMAGE URL");
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();

  String? appVersion;
  String scanAppVer = "6";
  String currentVersion = '';
  String buildNumber = '';

  String dropdownvalue = '-select-';

  var Type = [
    '-select-',
    '300',
    '500',
    'Free',
  ];

  MainProvider() {
    getAppVersion();
    getLastNumber();
    getPendingUserdata();
    // getApprovedUser();
  }

  void dropdown(String? newValue) {
    dropdownvalue = newValue!;
    notifyListeners();
  }


  List<QrScannedModel> qrScannedModelList = [];
  List<QrScannedModel> searchqrScannedModelList = [];
  List<ScanningReportModel> scanningReportList = [];

  File? memberFileImg;
  String images = "";

  File? approvedFileImg;

  var whatsStatus;
  String WImageByte = "ccc";


  // DateRangePickerController dateRangePickerController =
  // DateRangePickerController();

  DateTime firstDate = DateTime.now();
  DateTime secondDate = DateTime.now();
  String showSelectedDate = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime endDate2 = DateTime.now();
  bool isDateSelected = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

 TextEditingController qrAdminName=TextEditingController();
 TextEditingController qrAdminPhone=TextEditingController();

  void changeWhatsappImage(var cropper) async {
    whatsStatus = cropper;
    WImageByte = "true";
    notifyListeners();
  }

  Uint8List? userfileBytes;
  String? useruploadedPhotoUrl;
  final ImagePicker picker = ImagePicker();
  bool adduserLoader = false;
  File? fileImage;

  Future<void> adduser(Uint8List? pickedFile, BuildContext context) async {
    adduserLoader = true;
    notifyListeners();

    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    Map<String, dynamic> dataMap = HashMap();
    dataMap["NAME"] = nameController.text;
    dataMap["PHONE_NUMBER"] = '+91${mobileController.text}';
    dataMap["PLACE"] = placeController.text;
    dataMap["HOUSE_NAME"] = addressController.text;
    dataMap["USER_ID"] = id;
    dataMap["ADDED_TIME"] = DateTime.now();
    dataMap["STATUS"] = "PENDING";
    dataMap["ADDED_BY"] = "";

    String time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    if (kIsWeb && pickedFile != null) {
      Reference _reference =
      FirebaseStorage.instance.ref().child('images/$time');
      await _reference
          .putData(
        pickedFile,
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await _reference.getDownloadURL().then((value) {
          // useruploadedPhotoUrl = value;
          dataMap["IMAGE"] = value;
        });
      });
    } else {
      dataMap["IMAGE"] = '';
      notifyListeners();
    }

    print(dataMap.toString() + "ffii");
    bool numberStatus = false;
    numberStatus = await checkNumberExist(mobileController.text);

    if (!numberStatus) {
      db.collection("USERS").doc(id).set(dataMap);
      db
          .collection("LASTNUMBER")
          .doc("LASTNUMBER")
          .set({"NUMBER": FieldValue.increment(1)}, SetOptions(merge: true));

      const snackBar = SnackBar(
        content: Center(
            child: Text('Successfully Registered',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500))),
        backgroundColor: Colors.white,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      callNext(context, RegistractionSuccessfulscrn());
      clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Center(
          child: Text(
            "Number Already Exist",
          ),
        ),
      ));
    }

    adduserLoader = false;
    notifyListeners();
  }

  Future<bool> checkNumberExist(String phone) async {
    print(phone + ' hhhh');
    var D = await db
        .collection("USERS")
        .where("PHONE_NUMBER", isEqualTo: '+91$phone')
        .get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    nameController.clear();
    mobileController.clear();
    placeController.clear();
    addressController.clear();
    useruploadedPhotoUrl = '';
    userfileBytes = null;
    memberFileImg = null;
    images = '';
    selectedCategory = '';
    notifyListeners();
  }

  chooseuserImage(BuildContext context) async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage(pickedFile.path, context);
      // userfileBytes = await pickedFile.readAsBytes();

      notifyListeners();
      // uploadImageToStorage(pickedFile);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileImage = File(response.file!.path);

      notifyListeners();
    }
  }

  List<UserModel> usersList = [];
  List<UserModel> filterUsersList = [];
  int totalregistration = 0;
  int totalAmount = 0;
  int pendingCount = 0;
  int approvedCount = 0;
  int approvedAmount = 0;

  void getPendingUserdata() {
    db
        .collection('USERS')
        .orderBy("ADDED_TIME", descending: true)
        .where("STATUS", isEqualTo: "PENDING")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        usersList.clear();
        for (var element in value.docs) {
          usersList.add(UserModel(
              element.get("USER_ID").toString(),
              element.get("NAME").toString(),
              element.get("PHONE_NUMBER").toString(),
              element.get("IMAGE").toString(),
              element.get("STATUS").toString(),
              element.get("HOUSE_NAME").toString(),
              element.get("PLACE").toString(),
              '',
              '',
              DateFormat('dd.MM.yyyy hh:mm a')
                  .format(element.get("ADDED_TIME").toDate())
                  .toString()));
          filterUsersList = usersList;
          notifyListeners();
          // usersList.sort((a, b) => b.addedTime.compareTo(a.addedTime));
        }
        pendingCount = usersList.length;
        notifyListeners();

        // print(usersList.length.toString() + "gtygyhgyu");
      }
    });
  }

  List<UserModel> approvedUsersList = [];
  List<UserModel> filterapprovedUsersList = [];

  void getApprovedUser(String category) {
    db
        .collection('USERS')
        .orderBy("APPROVED_TIME", descending: true)
    // .where("STATUS", isEqualTo: "APPROVED")
        .where("CATEGORY", isEqualTo: category)
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        approvedUsersList.clear();
        approvedAmount = 0;
        for (var element in value.docs) {
          approvedUsersList.add(UserModel(
            element.get("USER_ID").toString(),
            element.get("NAME").toString(),
            element.get("PHONE_NUMBER").toString(),
            element.get("IMAGE").toString(),
            element.get("STATUS").toString(),
            element.get("HOUSE_NAME").toString(),
            element.get("PLACE").toString(),
            element.get("CATEGORY").toString(),
            DateFormat('dd.MM.yyyy hh:mm a')
                .format(element.get("APPROVED_TIME").toDate())
                .toString(),
            DateFormat('dd.MM.yyyy hh:mm a')
                .format(element.get("ADDED_TIME").toDate())
                .toString(),
          ));
          filterapprovedUsersList = approvedUsersList;
          notifyListeners();
          // approvedUsersList.sort((a, b) => b.approvedTime.compareTo(a.approvedTime));

          if (element.get("CATEGORY").toString() != "Free") {
            approvedAmount =
                approvedAmount + int.parse(element.get("CATEGORY").toString());
            notifyListeners();
          }
        }
        approvedCount = approvedUsersList.length;
        notifyListeners();
        // print(usersList.length.toString() + "gtygyhgyu");
      }
    });
  }

  void gettotalcount() {
    totalregistration = 0;
    db
        .collection('USERS')
        .where("STATUS", isEqualTo: "APPROVED")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        totalregistration = value.docs.length;
        notifyListeners();
      }
    });
  }

  int countthree = 0;
  int countfree = 0;
  int countfive = 0;

  void getCategory300Count() {
    countthree = 0;
    db
        .collection('USERS')
        .where("CATEGORY", isEqualTo: "300")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        countthree = value.docs.length;
        notifyListeners();
      }
    });
  }

  void getCategoryFreeCount() {
    countfree = 0;
    db
        .collection('USERS')
        .where("CATEGORY", isEqualTo: "Free")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        countfree = value.docs.length;
        notifyListeners();
      }
    });
  }

  void getCategory500Count() {
    countfive = 0;
    db
        .collection('USERS')
        .where("CATEGORY", isEqualTo: "500")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        countfive = value.docs.length;
        notifyListeners();
      }
    });
  }

  Future<void> getAppVersion() async {
    PackageInfo.fromPlatform().then((value) {
      currentVersion = value.version;
      buildNumber = value.buildNumber;
      appVersion = buildNumber;

      print(appVersion.toString() + "edfesappversion");

      notifyListeners();
    });
  }

  void lockApp() {
    mRootReference
        .child("0")
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['AppVersionNew'].toString().split(',');
        if (!versions.contains(appVersion)) {
          String ADDRESS = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

  void lockAppQR() {
    mRootReference
        .child("0")
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['AppVersionQR'].toString().split(',');
        if (!versions.contains(scanAppVer)) {
          String ADDRESS = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

  bool addAdminLoader = false;

  Future<void> addadminuser(BuildContext context, String addedBy) async {
    addAdminLoader = true;
    notifyListeners();
    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    Map<String, dynamic> dataMap = HashMap();
    dataMap["NAME"] = nameController.text;
    dataMap["PHONE_NUMBER"] = '+91${mobileController.text}';
    dataMap["PLACE"] = placeController.text;
    dataMap["HOUSE_NAME"] = addressController.text;
    dataMap["USER_ID"] = id;
    dataMap["ADDED_TIME"] = DateTime.now();
    dataMap["STATUS"] = "APPROVED";
    dataMap["ADDED_BY"] = addedBy;
    dataMap["APPROVED_BY"] = addedBy;
    dataMap["APPROVED_TIME"] = DateTime.now();
    for (var element in categoryList) {
      if (element.selection) {
        dataMap['CATEGORY'] = element.category;
        selectedCategory = element.category;
        if (element.category == "500") {
          dataMap['TOKEN_ID'] = "P100${generateRandomString(3)}" + lastNumber;
        } else {
          dataMap['TOKEN_ID'] = "F100${generateRandomString(3)}" + lastNumber;
        }
      }
    }

    if (memberFileImg != null) {
      String photoId = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(memberFileImg!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          dataMap["IMAGE"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      dataMap['IMAGE'] = images;
    }

    await db.collection("USERS").doc(id).set(dataMap);
    db
        .collection("LASTNUMBER")
        .doc("LASTNUMBER")
        .set({"NUMBER": FieldValue.increment(1)}, SetOptions(merge: true));
    notifyListeners();

    addAdminLoader = false;
    notifyListeners();
    getUserData(id);
    callNextReplacement(
        CouponScreen(
          category: selectedCategory,
        ),
        context);
  }

  String userName = '';
  String userPhone = '';
  String? userImage;
  String userPlace = '';
  String ticketNo = '';
  String userID = '';
  bool userLoader = false;

  getUserData(String id) {
    userLoader = true;
    notifyListeners();
    userName = '';
    userPhone = '';
    userImage = '';
    userPlace = '';
    ticketNo = '';
    db.collection("USERS").doc(id).get().then((value) {
      if (value.exists) {
        userLoader = false;
        notifyListeners();
        userName = value.get("NAME").toString();
        userPhone = value.get("PHONE_NUMBER").toString();
        userImage = value.get("IMAGE").toString();
        userPlace = value.get("PLACE").toString();
        ticketNo = value.get("TOKEN_ID").toString();
        userID = value.get("USER_ID").toString();
        notifyListeners();
      }
    });
  }

  void setImage(File image) {
    memberFileImg = image;
    notifyListeners();
  }

  Future getImggallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      cropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future getImgcamera() async {
    final imgPicker = ImagePicker();
    final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      cropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      memberFileImg = File(croppedFile.path);
      // print(Registerfileimg.toString() + "fofiifi");
      notifyListeners();
    }
  }

  Future<void> _cropImage(String path, BuildContext context) async {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    int widthh = queryData.orientation == Orientation.portrait
        ? int.parse((width / 2.5).toStringAsFixed(0))
        : 300;
    final croppedFile = await ImageCropper().cropImage(
      maxHeight: 300,
      maxWidth: 300,
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
          boundary: CroppieBoundary(width: widthh, height: widthh),
          enableZoom: true,
          mouseWheelZoom: false,
          //enableResize: true,
          // enforceBoundary: true,
          //  mouseWheelZoom: true,
          //  enableOrientation:true,
          enableExif: true,
          enforceBoundary: true,
          //enableOrientation: true,
          // viewPort: const CroppieViewPort(height: 50,width: 50,),
          viewPort:
          const CroppieViewPort(width: 180, height: 180, type: 'Square'),

          // enableExif: true,
          //  enableZoom: true,
          // showZoomer: true,,
        ),
      ],
    );
    if (croppedFile != null) {
      userfileBytes = await croppedFile.readAsBytes();
      print(userfileBytes.toString() + "sdnsahdbsah");

      notifyListeners();
    }
    notifyListeners();
  }

  void showBottomSheet(BuildContext context) {
    MainProvider donationProvider =
    Provider.of<MainProvider>(context, listen: false);

    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.camera_enhance_sharp,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () =>
                  {
                    donationProvider.getImgcamera(),
                    Navigator.pop(context)
                  }),
              ListTile(
                  leading: const Icon(Icons.photo, color: Colors.black),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () =>
                  {
                    donationProvider.getImggallery(),
                    Navigator.pop(context)
                  }),
            ],
          );
        });
    // ImageSource
  }

  List<CategoryModel> categoryList = [];

  void addCategory() {
    categoryList.clear();
    categoryList.add(CategoryModel('300', false));
    categoryList.add(CategoryModel('500', false));
    categoryList.add(CategoryModel('Free', false));
    notifyListeners();
  }

  String selectedCategory = '';

  void selectCategory(int index, String name) {
    if (categoryList[index].selection) {
      categoryList[index].selection = false;
    } else {
      categoryList[index].selection = true;
      selectedCategory = categoryList[index].category;
    }

    for (var element in categoryList) {
      if (element.category != name) {
        element.selection = false;
      }
    }
    notifyListeners();
  }

  bool approveLoader = false;

  Future<void> approveRequests(String id, BuildContext context, String uId,
      String photo) async {
    approveLoader = true;
    notifyListeners();

    Map<String, dynamic> dataMap = HashMap();
    dataMap["STATUS"] = "APPROVED";
    dataMap["APPROVED_BY"] = uId;
    dataMap["APPROVED_TIME"] = DateTime.now();
    dataMap["STATUS"] = "APPROVED";
    for (var element in categoryList) {
      if (element.selection) {
        dataMap['CATEGORY'] = element.category;
        selectedCategory = element.category;
        if (element.category == "500") {
          dataMap['TOKEN_ID'] = "P500" + generateRandomString(3) + lastNumber;
        } else {
          dataMap['TOKEN_ID'] = "F300" + generateRandomString(3) + lastNumber;
        }
      }
    }
    if (memberFileImg != null) {
      String photoId = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(memberFileImg!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          dataMap["IMAGE"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      dataMap['IMAGE'] = photo;
    }
    db.collection("USERS").doc(id).set(dataMap, SetOptions(merge: true));
    approveLoader = false;
    notifyListeners();
    print("jhhhhkj");
    getUserData(id);
    print("jhhhhkj");
  }

  Future<bool> showExitPopup(BuildContext contxt) async {
    return await showDialog(
        context: contxt,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: SizedBox(
              height: 95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit ?",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey)),
                  const SizedBox(height: 19),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              exit(0);
                            },
                            style: ElevatedButton.styleFrom(primary: btncolor1),
                            child: const Center(
                                child: Text("yes",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700)))),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Center(
                                child: Text("No",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700))),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> shareImageStatus(
      ScreenshotController screenshotControllerStatus) async {
    print("HHHHHHHHHHHHHH" + screenshotControllerStatus.toString());

    await screenshotControllerStatus.capture().then((Uint8List? image) async {
      print("HHHHHHHHHHHHHH555" + image.toString());

      if (image != null) {
        if (!kIsWeb) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          print("sfwsdfgfdsg" + imagePath.toString());

          /// Share Plugin
          await Share.shareFiles([imagePath.path]);
        } else {
          // ByteData bytes=ByteData.view(image.buffer);
          //
          // var blob = web_file.Blob([bytes], 'image/png', 'native');
          //
          // var anchorElement = web_file.AnchorElement(
          //   href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          // )..setAttribute("download", "data.png")..click();
        }
      }

      // Handle captured image
    });
  }

  void delete(String id) {
    db.collection("USERS").doc(id).delete();
    db
        .collection("LASTNUMBER")
        .doc("LASTNUMBER")
        .set({"NUMBER": FieldValue.increment(-1)}, SetOptions(merge: true));

    notifyListeners();
  }

  String lastNumber = '';

  void getLastNumber() {
    db.collection("LASTNUMBER").doc("LASTNUMBER").snapshots().listen((event) {
      if (event.exists) {
        lastNumber = event.get("NUMBER").toString();
        notifyListeners();
      }
    });
  }

  void getDetailsOfScanned(BuildContext context, String code,String addedBy,String userTYpe) {
    print("aaaaaaaaaaa$code");
    String name = "";
    String image = "";
    String tocken = "";
    String? scannedTime;
    DateTime todayTime = DateTime.now();
    db.collection('USERS').doc(code).get().then((DocumentSnapshot ds) {
      if (ds.exists) {
        Map<dynamic, dynamic> map = ds.data() as Map;
        if (!map.containsKey('ScanStatus')) {
          name = map["NAME"].toString();
          image = map["IMAGE"].toString();
          tocken = map["TOKEN_ID"].toString();
          qrAlert(context, name, code, "FIRST", image, tocken,addedBy,userTYpe);
          notifyListeners();
        } else {
          ///Condition pending ----fotball app(irshad)
          String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

          Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
          List<dynamic> currentList = data['InTime'];

          if (!currentList.contains(currentDate)) {
            name = map["NAME"].toString();
            image = map["IMAGE"].toString();
            tocken = map["TOKEN_ID"].toString();
            qrAlert(context, name, code, "NEXT", image, tocken,addedBy,userTYpe);
            notifyListeners();
          } else {
            const snackBar = SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(milliseconds: 3000),
                content: Text(
                  "Already One entry allowed per QrCode",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: Colors.white),
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            callNextReplacement(ScanRejection(addedBy: addedBy,from: userTYpe), context);
          }
        }
      } else {
        const snackBar = SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 3000),
            content: Text(
              "Ticket is Invalid",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(color: Colors.white),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  qrAlert(BuildContext context, String name, String code, String from,
      String image, String token,String addedBy,String userType) {
    print("111111");
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      titlePadding: EdgeInsets.zero,
      content: SizedBox(
        // height: 200,
        // width: 330,
        child: Column(
          children: [
            Container(width: 300,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15)),
              child: Image.network(image, fit: BoxFit.fill),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text("Ticket No: $token ",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        InkWell(
            onTap: () {
              finish(context);
            },
            child: floatingActnBtn("CANCEL",Icons.playlist_add_check_outlined)),
        InkWell(
            onTap: () {
              finish(context);
              inQrScanned(context, code, from, name,addedBy);
              callNext(context,QrcodeHomeScreen(addedBy: addedBy,from: userType,));
            },
            child: floatingActnBtn("OK", Icons.playlist_add_check_outlined)),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 40),
        //   child: TextButton(
        //     onPressed: () {
        //
        //     },
        //     style: TextButton.styleFrom(
        //         primary: Colors.white,
        //         elevation: 2,
        //         backgroundColor: Colors.blue),
        //     child: const Text(
        //       'OK',
        //       style: TextStyle(fontSize: 25),
        //     ),
        //   ),
        // ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  FlutterTts flutterTts = FlutterTts();

  Future<void> speakText(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    notifyListeners();
  }


  Future<void> inQrScanned(BuildContext context, String code, String from,
      String name,String addedBy) async {
    print("helllllo2" + code.toString());

    if (from == "FIRST") {
      String strDeviceID = await DeviceInfo().fun_initPlatformState();
      Map<String, Object> map = HashMap();
      map["Intime"] = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      map["InTime"] = [DateFormat('yyyy-MM-dd').format(DateTime.now())];
      map["InTimeDetailed"] = [DateTime.now()];
      map["ScanStatus"] = "SCANNED";
      map["Scanned_Device"] = strDeviceID;

      Map<Object, String> scanmap = HashMap();
      scanmap[DateTime.now().toString()] = addedBy;

      map["Scanned_By"] = scanmap;
      print(scanmap);

      db.collection("USERS").doc(code).set(map, SetOptions(merge: true));
      notifyListeners();
      speakText("$name Welcome to 7's Football tournament Anakkayam");

      const snackBar = SnackBar(
        content: Text("Scanned Successfully"),
        backgroundColor: Colors.blue,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      DocumentSnapshot document = await db.collection('USERS').doc(code).get();
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      List<dynamic> currentList = data['InTime'];
      List<dynamic> currentListDetailed = data['InTimeDetailed'];
      currentList.add(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      currentListDetailed.add(DateTime.now());
      String strDeviceID = await DeviceInfo().fun_initPlatformState();
      Map<String, Object> map = HashMap();
      map["InTime"] = currentList;
      map["InTimeDetailed"] = currentListDetailed;
      map["Scanned_Device"] = strDeviceID;
      map["Scanned_By"] = addedBy;

      Map<Object, String> scanmap = HashMap();
      scanmap[DateTime.now().toString()] = addedBy;

      map["Scanned_By"] = scanmap;

      db.collection("USERS").doc(code).set(map, SetOptions(merge: true));
      notifyListeners();
      speakText("$name Welcome to 7's Football tournament Anakkayam");


      const snackBar = SnackBar(
        content: Text("Scanned Successfully"),
        backgroundColor: Colors.blue,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void makingPhoneCall(String Phone) async {
    String url = "";
    url = 'tel:$Phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void whatsappLaunch({@required number, @required message}) async {
    if (number
        .toString()
        .length == 10) {
      number = "+91$number";
    }
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunchUrl(Uri.parse(url))
        ? launchUrl(Uri.parse(url))
        : print("can't open whatsapp");
  }

  void searchMember(item) {
    print(item + "fghjk");
    usersList = filterUsersList.where((a) =>
        a.username.toLowerCase().contains(item.toLowerCase())||
        a.mobile.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void searchApprovedmemeber(item) {
    print(item + "fghjk");
    approvedUsersList = filterapprovedUsersList.where((a) =>
    a.username.toLowerCase().contains(item.toLowerCase())||
        a.mobile.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }


  void searchScannedTickets(item) {
    print(item + "fghjk");
    searchqrScannedModelList = qrScannedModelList.where((a) =>
        a.phone.substring(3,13).contains(item.toLowerCase()) ||
        a.name.toLowerCase().contains(item.toLowerCase())
    )
        .toList();
    notifyListeners();

  }

  void showBottomSheetApprovedData(BuildContext context, String userId) {
    MainProvider donationProvider =
    Provider.of<MainProvider>(context, listen: false);

    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.camera_enhance_sharp,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () =>
                  {
                    donationProvider.getApprovedImgCamera(userId),
                    Navigator.pop(context)
                  }),
              ListTile(
                  leading: const Icon(Icons.photo, color: Colors.black),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () =>
                  {
                    donationProvider.getApprovedImgGallery(userId),
                    Navigator.pop(context)
                  }),
            ],
          );
        });
    // ImageSource
  }

  Future getApprovedImgGallery(String userId) async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      approvedCropImage(pickedImage.path, userId);
    } else {
      print('No image selected.');
    }
  }

  Future getApprovedImgCamera(String userId) async {
    final imgPicker = ImagePicker();
    final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      approvedCropImage(pickedImage.path, userId);
    } else {
      print('No image selected.');
    }
  }

  bool loader = false;

  Future<void> approvedCropImage(String path, String userId) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      approvedFileImg = File(croppedFile.path);

      addApprovedImage(userId, approvedFileImg);
      notifyListeners();
    }
  }

  addApprovedImage(String id, File? fileimage) async {
    Map<String, Object> dataMap = HashMap();

    if (fileimage != null) {
      String time = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      ref = FirebaseStorage.instance.ref().child(time);
      await ref.putFile(fileimage).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          dataMap['IMAGE'] = value;
        });
      });
    }
    db.collection('USERS').doc(id).set(dataMap, SetOptions(merge: true));
  }


  void getScannedQrDetails() async {
    print("functionwork");
    String scannedName = "";
    String scannedImage = "";
    String phone = "";
    String scannedPlace = "";
    List scannedTime=[];
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    String strDeviceID = await DeviceInfo().fun_initPlatformState();

    qrScannedModelList.clear();


    db.collection("USERS").where("ScanStatus", isEqualTo: "SCANNED").where(
        "Scanned_Device", isEqualTo: strDeviceID).where(
        "InTime", arrayContains: currentDate)
        .snapshots().listen((inEvent) {
      qrScannedModelList.clear();

      for (var element in inEvent.docs) {
        Map<dynamic, dynamic> map = element.data();
        print(map["NAME"].toString() + "cccccccccc");
        scannedName = map["NAME"].toString();
        scannedImage = map["IMAGE"].toString();
        phone = map["PHONE_NUMBER"].toString();
        scannedPlace = map["PLACE"].toString();
        scannedTime = map["InTimeDetailed"];


        qrScannedModelList.add(
            QrScannedModel(
                element.id.toString(),
                scannedName,
                scannedImage,
                phone,
                scannedPlace,
                scannedTime.last
            ));
        searchqrScannedModelList = qrScannedModelList;

        notifyListeners();
      }

      notifyListeners();
    });
  }

  void getAllScannedQrDetails() async {
    print("functionwork");
    String scannedName = "";
    String scannedImage = "";
    String phone = "";
    String scannedPlace = "";
    List scannedTime=[];
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    String strDeviceID = await DeviceInfo().fun_initPlatformState();

    qrScannedModelList.clear();


    db.collection("USERS").where("ScanStatus", isEqualTo: "SCANNED").where("InTime", arrayContains: currentDate)
        .snapshots().listen((inEvent) { 
      qrScannedModelList.clear();

      for (var element in inEvent.docs) {
        Map<dynamic, dynamic> map = element.data();
        print(map["NAME"].toString() + "cccccccccc");
        scannedName = map["NAME"].toString();
        scannedImage = map["IMAGE"].toString();
        phone = map["PHONE_NUMBER"].toString();
        scannedPlace = map["PLACE"].toString();
        scannedTime = map["InTimeDetailed"];

        qrScannedModelList.add(
            QrScannedModel(
                element.id.toString(),
                scannedName,
                scannedImage,
                phone,
                scannedPlace,
                scannedTime.last
            ));
        searchqrScannedModelList = qrScannedModelList;
        searchqrScannedModelList.sort((a, b) => b.milliTme.compareTo(a.milliTme));

        notifyListeners();
      }

      notifyListeners();
    });
  }

  // List<String> selectedDateList=[];
  // void showCalendarDialog(BuildContext context) {
  //   Widget calendarWidget() {
  //     return SizedBox(
  //       width: 300,
  //       height: 300,
  //       child: SfDateRangePicker(
  //         selectionMode: DateRangePickerSelectionMode.range,
  //         controller: dateRangePickerController,
  //         initialSelectedRange: PickerDateRange(_startDate, _endDate),
  //         allowViewNavigation: true,
  //         headerHeight: 20.0,
  //         showTodayButton: true,
  //         headerStyle: const DateRangePickerHeaderStyle(
  //           textAlign: TextAlign.center,
  //         ),
  //         initialSelectedDate: DateTime.now(),
  //         navigationMode: DateRangePickerNavigationMode.snap,
  //         monthCellStyle: const DateRangePickerMonthCellStyle(
  //             todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
  //         showActionButtons: true,
  //         onSubmit: (Object? val) {
  //           dateRangePickerController.selectedRange = val as PickerDateRange?;
  //
  //           if (dateRangePickerController.selectedRange!.endDate == null) {
  //             DateTime endDate = dateRangePickerController.selectedRange!.startDate!;
  //             endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 59, 59);
  //
  //             // getScanningReport(context,
  //             //     dateRangePickerController.selectedRange!.startDate!
  //             //         .millisecondsSinceEpoch, endDate.millisecondsSinceEpoch);
  //
  //
  //             notifyListeners();
  //           } else {
  //             // getScanningReport(context,
  //             //     dateRangePickerController.selectedRange!.startDate!
  //             //         .millisecondsSinceEpoch,
  //             //     dateRangePickerController.selectedRange!.endDate!
  //             //         .millisecondsSinceEpoch);
  //
  //
  //             notifyListeners();
  //           }
  //           finish(context);
  //         },
  //         onCancel: () {
  //           dateRangePickerController.selectedDate = null;
  //           finish(context);
  //         },
  //       ),
  //     );
  //   }
  //
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(12.0))),
  //           contentPadding: const EdgeInsets.only(
  //             top: 10.0,
  //           ),
  //           // title: Container(
  //           //     child: Text('Printers', style: TextStyle(color: my_white))),
  //           content: calendarWidget(),
  //         );
  //       });
  //   notifyListeners();
  // }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != firstDate) {
      firstDate = pickedDate;
      getScanningReport(firstDate);
    }
  }


  List scannedTime=[];
  bool searchData=true;
  void getScanningReport(DateTime firstDate) {
    isDateSelected  =true;
    notifyListeners();

   String firstDate1= DateFormat('yyyy-MM-dd').format(firstDate);
    db.collection('USERS').where("InTime", arrayContains: firstDate1).get().then((value) {
        scanningReportList.clear();
        isDateSelected= false;
        notifyListeners();
      if (value.docs.isNotEmpty) {
        searchData =true;
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          scanningReportList.add(
              ScanningReportModel(
                  element.id.toString(),
                  map["NAME"].toString(),
                  map["IMAGE"].toString(),
                  map["PHONE_NUMBER"].toString(),
                  map["PLACE"].toString(),
                  DateFormat("dd-MM-yyyy").format(firstDate).toString()
              ));
          notifyListeners();
        }
      }else{
        searchData =false;
        notifyListeners();
      }

    });
  }

  bool qrLoader = false;
  void addQrAdmin(BuildContext context){
    qrLoader = true;
    notifyListeners();
    String id= DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> dataMap = HashMap();

    dataMap["NAME"]=qrAdminName.text.toString();
    dataMap["PHONE"]="+91"+qrAdminPhone.text.toString();
    dataMap["TYPE"]="SCANNER";
    db.collection("ADMIN").doc(id).set(dataMap);

    qrLoader = false;
    notifyListeners();
    getQrAdmins();
    finish(context);

  }

  void qrClear() {
    qrAdminName.clear();
    qrAdminPhone.clear();
    notifyListeners();
  }

  List<QrAdminsModel> qrAdminsList=[];
  bool qrAdminsLoader=false;
  void getQrAdmins(){
    qrAdminsLoader=true;
    notifyListeners();
    db.collection("ADMIN").where("TYPE",isEqualTo: "SCANNER").get().then((value){
      if(value.docs.isNotEmpty){
        qrAdminsList.clear();
        qrAdminsLoader=false;
        notifyListeners();
        for(var e in value.docs){
          qrAdminsList.add(QrAdminsModel(e.get("NAME").toString(), e.get("PHONE").toString()));
          notifyListeners();
        }
      }
    });
  }

  void shareImageToWhatsApp(ScreenshotController screenshotControllerStatus, String phoneNumber) async {

    await screenshotControllerStatus.capture().then((Uint8List? image) async {
      if (image != null) {
        if (!kIsWeb) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          print("qqqqqqqqqq" + imagePath.path);
          String url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent("Anakkayam 7's Football Tournament Season Ticket")}&media=${Uri.encodeComponent(poster1)}";

          /// Share Plugin
          await launch(url);
        } else {
        }
      }
    });

    // String whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=Check%20out%20this%20image:%20";
    // String imageUrl = 'https://example.com/image.png'; // Replace with your image URL
    // await launch("$whatsappUrl$imageUrl");

  }
}
