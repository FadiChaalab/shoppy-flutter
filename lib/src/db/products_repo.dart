import 'package:shop/src/db/auth.dart';
import 'package:shop/src/db/storage.dart';
import 'package:shop/src/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/src/models/review.dart';

class ProductRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('products');
  final auth = AuthService();
  final storage = StorageRepo();

  Stream<List<Product>> getProducts() {
    return _collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get popular products
  Stream<List<Product>> getPopularProducts() {
    return _collectionReference
        .where('popular', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get flash sales products
  Stream<List<Product>> getFlashSalesProducts() {
    return _collectionReference
        .where('flashSales', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get new products
  Stream<List<Product>> getNewProducts() {
    return _collectionReference
        .where('newProduct', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get best seller products
  Stream<List<Product>> getBestSellerProducts() {
    return _collectionReference
        .where('bestSeller', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get black market products
  Stream<List<Product>> getBlackMarketProducts() {
    return _collectionReference
        .where('blackMarket', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get summer sales products
  Stream<List<Product>> getSummerSalesProducts() {
    return _collectionReference
        .where('summerSales', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //add product to user bookmarks
  Future<void> addProductToBookmarks(Product product) async {
    final user = await auth.getUser();
    final bookmarks = user.bookmarks;
    if (bookmarks != null) {
      if (!bookmarks.contains(product)) {
        bookmarks.add(product);
        await auth.updateUserBookmarks(bookmarks);
      }
    } else {
      final bookmarks = [product];
      await auth.updateUserBookmarks(bookmarks);
    }
  }

  //remove product from user bookmarks
  Future<void> removeProductFromBookmarks(Product product) async {
    final user = await auth.getUser();
    final bookmarks = user.bookmarks;
    if (bookmarks != null) {
      if (bookmarks.contains(product)) {
        bookmarks.remove(product);
        await auth.updateUserBookmarks(bookmarks);
      }
    }
  }

  //add review to product
  Future<void> addReview(Product product, Review review) async {
    final reviews = product.reviews;
    if (reviews.isNotEmpty) {
      if (!reviews.any((r) => r.productId == review.productId)) {
        reviews.add(review);
        await _collectionReference
            .doc(product.id)
            .update({'reviews': reviews.map((e) => e.toJson()).toList()});
      }
    } else {
      final reviews = [review];
      await _collectionReference
          .doc(product.id)
          .update({'reviews': reviews.map((e) => e.toJson()).toList()});
    }
  }

  //update product quantity
  Future<void> updateProductQuantity(Product product, int quantity) async {
    await _collectionReference.doc(product.id).update({'quantity': quantity});
  }

  // get product by id
  Stream<Product> getProductById(String id) {
    return _collectionReference.doc(id).snapshots().map((snapshot) {
      return Product.fromJson(snapshot.data() as Map<String, dynamic>);
    });
  }
}
