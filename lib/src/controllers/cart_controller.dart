import 'package:flutter/material.dart';
import 'package:shop/src/db/auth.dart';
import 'package:shop/src/models/cart.dart';

class CartController extends ChangeNotifier {
  List<Cart> _carts = [];
  List<Cart> get carts => _carts;
  final _auth = AuthService();

  CartController() {
    _auth.streamFirestoreUser()?.listen((user) {
      if (user != null) {
        _carts = user.carts ?? [];
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void addToCart(Cart cart) async {
    _carts.add(cart);
    notifyListeners();
    await _auth.addUserCart(_carts, cart);
  }

  void removeFromCart(Cart cart) {
    _carts.remove(cart);
    notifyListeners();
    _auth.updateUserCart(_carts);
  }

  void clearCart() async {
    _carts.clear();
    notifyListeners();
    await _auth.clearUserCart();
  }

  int get cartCount => _carts.length;

  double get cartTotal => _carts.fold(0, (t, c) => t + c.total);

  int get cartQuantity => _carts.fold(0, (t, c) => t + c.quantity);

  void updateCartById(Cart cart, String id) {
    for (var c in _carts) {
      if (c.id == id) {
        c.quantity = cart.quantity;
        c.total = cart.total;
        notifyListeners();
      }
    }
  }

  void updateCartQuantity(Cart cart, int quantity) {
    for (var c in _carts) {
      if (c.id == cart.id) {
        c.quantity = quantity;
        c.total = cart.price * quantity;
        notifyListeners();
      }
    }
  }

  void updateCartTotal(Cart cart, double total) {
    for (var c in _carts) {
      if (c.id == cart.id) {
        c.total = total;
        notifyListeners();
      }
    }
  }

  void addQuantity(Cart cart) {
    for (var c in _carts) {
      if (c.id == cart.id) {
        c.quantity++;
        c.total = cart.price * c.quantity;
        notifyListeners();
      }
    }
  }

  void subQuantity(Cart cart) {
    for (var c in _carts) {
      if (c.id == cart.id) {
        if (c.quantity > 1) {
          c.quantity--;
          c.total = cart.price * c.quantity;
          notifyListeners();
        }
      }
    }
  }
}
