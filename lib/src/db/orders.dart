import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/src/models/order.dart';

class Orders {
  final _collectionReference = FirebaseFirestore.instance.collection('orders');

  Future<void> addOrder(Order order) async {
    try {
      await _collectionReference.doc(order.id).set(order.toJson());
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Stream<List<Order>> getOrders() {
    return _collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Order.fromJson(doc.data());
      }).toList();
    });
  }

  Future<void> updateOrder(Order order) async {
    try {
      await _collectionReference.doc(order.id).update(order.toJson());
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> deleteOrder(Order order) async {
    try {
      await _collectionReference.doc(order.id).delete();
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> deleteAllOrders() async {
    try {
      await _collectionReference.get().then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> deleteAllOrdersByUserId(String userId) async {
    try {
      await _collectionReference
          .where('userId', isEqualTo: userId)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }
}
