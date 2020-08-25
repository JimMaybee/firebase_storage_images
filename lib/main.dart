import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:storage_path/storage_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

FirebaseStorage firebaseStorage = FirebaseStorage();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImageCapture(),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _image;
  final picker = ImagePicker();

  Future<String> getImageURL() async {
    var imageRef = firebaseStorage.ref().child('CS009203.jpg');
    var imageUrl = await imageRef.getDownloadURL();
    return imageUrl;
  }

  Future<File> gallerySource() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    StorageReference reference = firebaseStorage.ref().child('Dog/');
    reference.putFile(File(pickedFile.path));

    setState(() {
      _image = File(pickedFile.path);
    });
    return _image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder<String>(
            future: getImageURL(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Image(image: NetworkImage(snapshot.data)),
                      Image(
                        image: NetworkImage(snapshot.data),
                        height: 250,
                        filterQuality: FilterQuality.low,
                        isAntiAlias: true,
                      ),
                      Image(image: NetworkImage(snapshot.data), height: 200),
                    ],
                  ),
                );
              } else {
                return Text('Please wait for image');
              }
            }),
        FloatingActionButton(
          child: Icon(Icons.update),
          onPressed: () {
            setState(() {
              gallerySource();
            });
          },
        ),
      ]),
    );
  }
}
