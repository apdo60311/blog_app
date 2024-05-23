import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaPickerHandler {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickOneImageFromGallery() async {
    _handlePermissions();
    XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> pickOneImageFromCamera() async {
    _handlePermissions();
    XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<List<File>> pickImages() async {
    _handlePermissions();

    List<File> images = [];
    List<XFile> pickedImages = await _imagePicker.pickMultiImage();

    for (var image in pickedImages) {
      images.add(File(image.path));
    }
    return images;
  }

  void _handlePermissions() async {
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
  }
}
