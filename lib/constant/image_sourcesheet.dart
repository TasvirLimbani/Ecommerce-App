import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Svg_Icon.dart';
import 'package:plant_app/utils/Text_utils.dart';
import 'package:uuid/uuid.dart';

class ImageSourceSheet extends StatefulWidget {
  // Constructor
  ImageSourceSheet({Key? key, required this.onImageSelected , this.name = 'Profile'}) : super(key: key);
  final Function(String?) onImageSelected;
  String name;

  @override
  State<ImageSourceSheet> createState() => _ImageSourceSheetState();
}

class _ImageSourceSheetState extends State<ImageSourceSheet> {
  final picker = ImagePicker();

  TextUtils _textUtils = TextUtils();

  File? imagefile;
  bool postUpload = false;

  Future getImageGallery() async {
    ImagePicker _picker = ImagePicker();
    await _picker
        .pickImage(source: ImageSource.gallery, imageQuality: 20)
        .then((xFile) {
      if (xFile != null) {
        imagefile = File(xFile.path);
        uploadImage();
        Navigator.of(context).pop();
        setState(() {
          postUpload = true;
        });
      }
    });
  }

  Future getImageCamera() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.camera).then((xFile) {
      if (xFile != null) {
        imagefile = File(xFile.path);
      }
    });
  }

  Future uploadImage() async {
    String filename = const Uuid().v1();
    // String userId = FirebaseAuth.instance.currentUser!.uid;
    int status = 1;
    var ref =
        FirebaseStorage.instance.ref().child(widget.name).child("$filename.jpg");
    var uploadTask = await ref.putFile(imagefile!).catchError((error) async {
      if (mounted)
        setState(() {
          postUpload = false;
        });
      status = 0;
    });
    if (status == 1) {
      String ImageUrl = await uploadTask.ref.getDownloadURL();
      log(ImageUrl.toString());
      // FirebaseQuery.firebaseQuery.insertuser(userId,{
      //   "profile_pic": ImageUrl,
      // });
      widget.onImageSelected(ImageUrl);
      log(imagefile.toString());
      log(ImageUrl);
      if (mounted)
        setState(() {
          postUpload = false;
        });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        border: Border.all(width: 1.0, color: const Color(0xff707070)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: _textUtils.bold20("Photo", Colors.black)),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey))
            ],
          ),

          const Divider(height: 5, thickness: 1),

          /// Select image from gallery
          ListTile(
            contentPadding: EdgeInsets.only(left: 15),
            minLeadingWidth: 20,
            leading:
                const Icon(Icons.photo_library, color: Colors.grey, size: 27),
            title: _textUtils.bold16("gallery", primaryColor),
            onTap: () async {
              getImageGallery();
              //     final pickedFile = await picker.pickImage(
              //   source: ImageSource.gallery,
              // );
              // if (pickedFile == null) return;
              // selectedImage(context, File(pickedFile.path));
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: TextButton.icon(
          //     icon:
          //         const Icon(Icons.photo_library, color: Colors.grey, size: 27),
          //     label: Text("gallery",
          //         style: const TextStyle(fontSize: 16)),
          //     onPressed: () async {
          //       // Get image from device gallery
          //     }
          //   ),
          // ),

          /// Capture image from camera
          ListTile(
            contentPadding: EdgeInsets.only(left: 15),
            minLeadingWidth: 20,
            leading:
                SvgIcon("assets/icons/camera_icon.svg", width: 20, height: 20),
            title: _textUtils.bold16("camera", primaryColor),
            onTap: () async {
              getImageCamera();
              // );
              // if (pickedFile == null) return;
              // selectedImage(context, File(pickedFile.path));
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: TextButton.icon(
          //     icon:  SvgIcon("assets/icons/camera_icon.svg",
          //         width: 20, height: 20),
          //     label: Text("camera",
          //         style: const TextStyle(fontSize: 16)),
          //     onPressed: () async {
          //       // Capture image from camera
          //       final pickedFile = await picker.pickImage(
          //         source: ImageSource.camera,
          //       );
          //       if (pickedFile == null) return;
          //       selectedImage(context, File(pickedFile.path));
          //     },
          //   ),
          // ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
