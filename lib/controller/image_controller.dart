import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class ImageController extends GetxController {
  var image = File("").obs;
  var memoryImage = Uint8List.fromList([]).obs;
  final _picker = ImagePicker();
  void pickImage(
      {required isFromGallery, required BuildContext context}) async {
    if (kIsWeb) {
      ///app is running on web so get images in bytes4
      var pickedImage = await _picker.pickImage(
          source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
      if (pickedImage != null) {
        memoryImage.value = await pickedImage.readAsBytes();
        memoryImage.refresh();
      } else {
        print('No image found');
      }
    } else {
      ///app is running on android/ios/desktip so get image in direct file
      final permissionResult = await Permission.storage.request();
      if (permissionResult.isGranted) {
        final pickedImage = await _picker.pickImage(
            source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
        if (pickedImage != null) {
          image.value = File(pickedImage.path);
        } else {
          print('Image not found');
        }
      } else {
        showDialog(
            context: context,
            builder: (dialogcontex) => AlertDialog(
                  icon: const Icon(Icons.warning),
                  title: const Text('Permission status'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(dialogcontex);
                        },
                        child: const Text('Ok'))
                  ],
                  content: const Text(
                      'Permission has been denied ,Please go to setting and enable it'),
                ));
      }
    }
  }
  ///function to display bottomsheet options
  showImagePickerOptions({required BuildContext context})
  {
    showModalBottomSheet(context: context, builder: (bottomsheetContex)=> Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Camera'),
          onTap: (){
            pickImage(isFromGallery: false, context: context);
            Navigator.of(bottomsheetContex).pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.picture_in_picture_rounded),
          title: const Text('Gallery'),
          onTap: (){
            pickImage(isFromGallery: true, context: context);
            Navigator.of(bottomsheetContex).pop();
          },
        )
      ],
    ));

  }
}
