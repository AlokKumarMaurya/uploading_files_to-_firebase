// //import 'dart:html';
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart' as fStorage;
//
// class UploadPhoto extends StatefulWidget {
//   const UploadPhoto({Key? key}) : super(key: key);
//
//   @override
//   State<UploadPhoto> createState() => _UploadPhotoState();
// }
//
// class _UploadPhotoState extends State<UploadPhoto> {
//
//   List<XFile>? _image;
//   final imagePicker = ImagePicker();
//   List<String> downloadURL = [];
//   List<String> urls=[];
//   var isLoading = false;
//   int uploadIteam = 0;
//   UploadTask ? uploadTask;
//
//
//
//
//
//
//   var galleryFile;
//   var aaa="assets/121.jpeg";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Upload Media",)
//       ),
//       body: Column(
//         children: [
//           InkWell(
//             child: Container(
//               decoration: BoxDecoration(image: DecorationImage(
//                   image: AssetImage(aaa)
//               )
//               ),
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width,
//               height: 200,
//             ),
//             onTap:(){}
//             //imagePickerMethod(),
//           ),
//
//
//
//
//
//
//
//           TextField(decoration: InputDecoration(hintText: "Court Name"),),
//           TextField(decoration: InputDecoration(hintText: "Descripition"),),
//           ElevatedButton(onPressed: (){}, child: Text("Submit"))
//         ],
//       ),
//     );
//   }
//
//  Future  imagePickerMethod() async
//   {
//     final pick = await imagePicker.pickMultiImage();
//     setState(()
//     {
//       if(pick!= null)
//         {
//           _image=pick;
//         }
//       else
//         {
//           showSnackBar("No File Selected",const Duration(
//             microseconds: 400
//           ));
//
//         }
//     }
//     );
//
//
//   }
//
//
//
//
//   }
//
//
//
//
//
//
//
//
//
//   showSnackBar(String snacknbartext, Duration d) {
//     final snackBar = SnackBar(content: Text(snacknbartext),duration: d,);
//     // Scaffold.of(Context).ShowSnackBar(snackBar);
//
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// //
//   // uploadImage() async {
//   //   final _firebaseStorage = FirebaseStorage.instance;
//   //   final _imagePicker = ImagePicker();
//   //   var file;
//   //   var imageUrl;
//   //   PickedFile image;
//   //   //Check Permissions
//   //   await Permission.photos.request();
//   //
//   //   var permissionStatus = await Permission.photos.status;
//   //
//   //   if (permissionStatus.isGranted){
//   //     //Select Image
//   //     image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
//   //     file = File(image.path);
//   //
//   //     if (image != null){
//   //       //Upload to Firebase
//   //       var snapshot = await _firebaseStorage.ref()
//   //           .child('images/imageName')
//   //           .putFile(file).storage;
//   //       var downloadUrl = await snapshot.ref.toString();
//   //       setState(() {
//   //         imageUrl = downloadUrl;
//   //        });
//   //     } else {
//   //       print('No Image Path Received');
//   //     }
//   //   } else {
//   //     print('Permission not granted. Try Again with permission access');
//   //   }
//
// //
// //   uploadImage() async {
// //     final _storage = FirebaseStorage.instance;
// //     final _picker = ImagePicker();
// //     PickedFile image;
// //     var imageUrl;
// //
// //
// //     //Check Permissions
// //     await Permission.photos.request();
// //
// //     var permissionStatus = await Permission.photos.status;
// //
// //     if (permissionStatus.isGranted) {
// //       //Select Image
// //       image = (await _picker.getImage(source: ImageSource.gallery))!;
// //       var file = File(image.path);
// //
// //       if (image != null) {
// //         //Upload to Firebase
// //         var snapshot = await _storage.ref()
// //             .child('folderName/imageName')
// //             .putFile(file);
// //         // .onComplete;
// //
// //         var downloadUrl = await snapshot.ref.getDownloadURL();
// //
// //         setState(() {
// //           imageUrl = downloadUrl;
// //         });
// //       } else {
// //         print('No Path Received');
// //       }
// //     } else {
// //       print('Grant Permissions and try again');
// //     }
// //   }
// //
// //
// //   imageSelectorGallery() async {
// //     galleryFile = await ImagePicker.platform.getImage(
// //       source: ImageSource.gallery,
// //       // maxHeight: 50.0,
// //       // maxWidth: 50.0,
// //     );
//     // setState(() {
//     //   setState(()
//     //   {
//     //     aaa=galleryFile;
//     //   }
//     //   );
//     //
//     // }
//     // );
































import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work121/pages/ProgreeBar.dart';
var aa;
var _image;
var imageURL;

//import 'ProgressBar.dart';

class Storage {

  final picker = ImagePicker();

  Future getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);



    aa=pickedFile!.path;


    if (pickedFile != null) {
      return pickedFile;
    } else {
      return null;
    }
  }

  Future uploadFile(File file, context) async {
    if (file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No file was selected")));
      return null;
    }

    //show Progress bar

    showDialog(context: context, builder: (context) => ProgressBar());

    firebase_storage.UploadTask uploadTask;
    Random rand = new Random();

    _image = File(file.uri.toString());
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('photos')
        .child('/${DateTime.now().toIso8601String()}');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }
    uploadTask.snapshotEvents.listen((event) {
      progress.value =
          (100 * (event.bytesTransferred / event.totalBytes)).round();
      print('${(100 * (event.bytesTransferred / event.totalBytes)).round()}');
    });

    await ref.putFile(File(aa));
    imageURL = await ref.getDownloadURL();

    await uploadTask.whenComplete(() {
      Navigator.pop(context);
      print('finished upload');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image uploaded successfully")));
      progress.value = 0;
    });
    return await ref.getDownloadURL();
  }
}
