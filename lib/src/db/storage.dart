import 'dart:io';
import 'package:shop/src/db/auth.dart';
import 'package:shop/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageRepo {
  final _storage = firebase_storage.FirebaseStorage.instance;
  final _authService = AuthService();

  Future<String?> uploadFile(File file, String path) async {
    try {
      UserModel? user = await _authService.getUser();
      var userId = user!.uid;

      var storageRef = _storage.ref().child("$path/$userId");
      var uploadTask = storageRef.putFile(file);
      var completedTask = await uploadTask;
      String downloadUrl = await completedTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> uploadProfilePicture(File image) async {
    try {
      final photoUrl = await uploadFile(image, 'user/profile');
      await _authService.updateUserProfilePic(photoUrl!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
