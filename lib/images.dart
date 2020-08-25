import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:storage_path/storage_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class TestImages {
  FirebaseStorage firebaseStorage;

  static Future<String> get getFilePath async {
    final directory = await getDownloadsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/myfile.txt');
  }

  // static Future<File> get getImages async {
  //   //final directory = await getExternalStorageDirectories();
  //   String imagesDirectory = "D:/FlutterDev/flutter/firebase_storage/TestPhotos";
  //   final myDir = new Directory(imagesDirectory);
  //   List<FileSystemEntity> _images;
  //   _images = myDir.listSync(recursive: true, followLinks: false);
  //   print(_images);
  // }
  // List<TestImages> buildFileOptions() {
  //   Directory.current.listSync().where((entity) {
  //     print(entity);
  //     return FileSystemEntity.isFileSync(entity.path) &&
  //         entity.path.contains(RegExp(r'\.(png|jpg|jpeg)'));
  //   });
  //   return [];
  // }
}
