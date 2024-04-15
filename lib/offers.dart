import 'package:classwork/controller/image_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Offers extends StatelessWidget {
  const Offers({super.key});
  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.put(ImageController());
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        return Column(
          children: <Widget>[
           const  SizedBox(
              height: 32,
            ),
            kIsWeb
                ? Image.memory(
                    imageController.memoryImage.value,
                    width: 100,
                    height: 100,
                  )
                : Image.file(
                    imageController.image.value,
                    width: 100,
                    height: 100,
                  ),
           const SizedBox(
              height: 32,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () =>
                    imageController.showImagePickerOptions(context: context),
                child: Text('Select Image'),
              ),
            ),
          ],
        );
      }),
    );
  }
}