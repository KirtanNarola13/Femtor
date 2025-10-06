import 'dart:io';

import 'package:femtor/app/routes/app_pages.dart';
import 'package:femtor/app/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/user_model.dart';

class CreateProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  var selectedGender = ''.obs;
  var mobileNumber = ''.obs;

  var profileImagePath = ''.obs;
  var profileImage = Rx<File?>(null);

  var isButtonEnabled = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    mobileNumber.value = Get.arguments['contact'] ?? '';
    mobileController.text = mobileNumber.value;

    nameController.addListener(_validateFields);
    emailController.addListener(_validateFields);
    selectedGender.listen((_) => _validateFields());
    profileImage.listen((_) => _validateFields());
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void _validateFields() {
    isButtonEnabled.value =
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        GetUtils.isEmail(emailController.text) &&
        selectedGender.value.isNotEmpty &&
        profileImage.value != null;
  }

  Future<void> pickProfileImage() async {
    var status = await Permission.photos.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      await DialogHelper.showInfoDialog(
        title: 'Photo Access',
        message:
            'To select a profile picture from your gallery, Femtor requires access to your photos.',
        buttonText: 'Allow Access',
        onConfirm: () async {
          Get.back(); // Close the info dialog
          status = await Permission.photos.request();
          _handlePermissionStatus(status);
        },
      );
    } else {
      _handlePermissionStatus(status);
    }
  }

  Future<void> _handlePermissionStatus(PermissionStatus status) async {
    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        profileImagePath.value = pickedFile.path;
      }
    } else if (status.isPermanentlyDenied) {
      await DialogHelper.showInfoDialog(
        title: 'Permission Denied',
        message:
            'You have permanently denied photo access. To enable it, please go to your device settings.',
        buttonText: 'Open Settings',
        onConfirm: () {
          Get.back();
          openAppSettings();
        },
      );
    } else {
      Get.snackbar(
        "Permission Denied",
        "Photo access is required to select a profile picture.",
      );
    }
  }

  Future<void> createProfile() async {
    // Final validation check before proceeding
    if (nameController.text.isEmpty) {
      Get.snackbar("Incomplete Profile", "Please enter your name.");
      return;
    }
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Incomplete Profile", "Please enter a valid email address.");
      return;
    }
    if (selectedGender.value.isEmpty) {
      Get.snackbar("Incomplete Profile", "Please select your gender.");
      return;
    }
    if (profileImage.value == null) {
      Get.snackbar("Incomplete Profile", "Please select a profile picture.");
      return;
    }

    final confirmed = await DialogHelper.showConfirmationDialog(
      title: 'Create Profile',
      message: 'Are you sure you want to create your profile?',
    );

    if (confirmed) {
      DialogHelper.showLoading('Creating Profile...');

      // Simulate API call
      await Future.delayed(const Duration(seconds: 3));

      final user = UserModel(
        name: nameController.text,
        mobileNumber: mobileNumber.value,
        emailAddress: emailController.text,
        gender: selectedGender.value,
        profilePicture: profileImagePath.value,
      );

      // TODO: Call real API here
      print("Creating profile: ${user.toJson()}");

      DialogHelper.hideLoading();

      // For now, navigate to home
      Get.offAllNamed(Routes.HOME);
    }
  }
}
