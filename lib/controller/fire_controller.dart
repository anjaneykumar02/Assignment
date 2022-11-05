import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FireController extends GetxController {
  String tempUrl = "";
  String imgUrl = "";

  late File ufile;
  String uname = "";
  String upath = "";

  bool isSelected = false;
  bool isUploading = false;

  Future<void> selectImage() async {
    var result;
    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);
      if (result != null) {
        uname = result.files.first.name;
        ufile = File(result.files.first.path);
        upath = result.files.first.path;
        isSelected = true;
      } else {
        print("User canceled the picker");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    update();
  }

  Future<void> saveData(name, phone, age, department) async {
    isUploading = true;

    ///file upload start
    File file = File(upath);
    try {
      var ref = await FirebaseStorage.instance.ref();

      const destination = "users/";
      await ref
          .child('$destination/$uname')
          .putFile(
            file,
          )
          .whenComplete(() {});

      await ref.child('$destination/$uname').getDownloadURL().then((value) {
        imgUrl = value;

        var req = {
          "name": name,
          "phone": phone,
          "age": age,
          "department": department,
          "image": imgUrl,
        };
        FirebaseFirestore.instance.collection('users').add(req);
        print("data added successfully");
      });
    } catch (e) {
      print('error occured');
    }

    ///file upload end
    ///
    await Future.delayed(const Duration(seconds: 1));
    isUploading = false;
    update();
  }
}
