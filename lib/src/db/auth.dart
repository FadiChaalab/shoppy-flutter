import 'package:shop/src/models/cart.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  UserModel? userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            email: user.email,
            avatarUrl: user.photoURL,
          )
        : null;
  }

  Stream<UserModel?>? streamFirestoreUser() async* {
    var uid = await getCurrentUserUid();
    if (uid != null) {
      yield* _collectionReference.doc(uid).snapshots().map((snapshot) {
        if (snapshot.exists) {
          return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        }
        return null;
      });
    }
  }

  Future<bool> createUser(UserModel user) async {
    try {
      await _collectionReference.doc(user.uid).set(user.toJson());
      streamFirestoreUser();
      return true;
    } catch (e) {
      debugPrint('error ' + e.toString());
      return false;
    }
  }

  Future getUser() async {
    try {
      var uid = await getCurrentUserUid();
      var userData = await _collectionReference.doc(uid).get();
      return UserModel.fromJson(userData.data() as Map<String, dynamic>);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future updateUserProfilePic(String image) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'avatarUrl': image,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserInformation(String first, String last, String address,
      String phone, String age) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'firstName': first,
        'lastName': last,
        'addrese': address,
        'phone': int.parse(phone),
        'age': int.parse(age),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserFirstName(String first) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'firstName': first,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserLastName(String last) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'lastName': last,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserAddrese(String addrese) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'addrese': addrese,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserPhone(String phone) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'phone': int.parse(phone),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserAge(String age) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'age': int.parse(age),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserBookmarks(List<Product> bookmarks) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'bookmarks': bookmarks.map((e) => e.toJson()).toList(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future addUserCart(List<Cart> carts, Cart cart) async {
    try {
      var uid = await getCurrentUserUid();
      if (!carts.any((e) => e.id == cart.id)) {
        carts.add(cart);
      }
      await _collectionReference.doc(uid).update({
        'carts': carts.map((e) => e.toJson()).toList(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUserCart(List<Cart> carts) async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'carts': carts.map((e) => e.toJson()).toList(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future clearUserCart() async {
    try {
      var uid = await getCurrentUserUid();
      await _collectionReference.doc(uid).update({
        'carts': [],
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      User? currentUser;
      currentUser = _auth.currentUser;
      return currentUser;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<UserModel?> getCurrentUserModel() async {
    try {
      var user = _auth.currentUser;
      return UserModel(uid: user?.uid, email: user?.email);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String?> getCurrentUserUid() async {
    try {
      User? currentUser;
      currentUser = _auth.currentUser;
      return currentUser?.uid;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future signInEmailAndPass(String email, String password) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "operation-not-allowed":
          errorMessage = "Operation with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      await user!.sendEmailVerification();
      return userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "email-already-in-use":
          errorMessage = "Email already has been used.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "operation-not-allowed":
          errorMessage = "Operation with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "email-already-in-use":
          errorMessage = "Email already has been used.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "operation-not-allowed":
          errorMessage = "Operation with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return null;
    }
  }
}
