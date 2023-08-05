import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tiktok/models/user.dart' as model;
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;
}
