import 'package:shop/src/db/auth.dart';
import 'package:shop/src/models/product.dart';

class BookmarksController {
  final _auth = AuthService();
  // check if product exists in user bookmarks
  bool isBookmarked(List<Product> bookmarks, Product product) {
    return bookmarks.any((bookmark) => bookmark.id == product.id);
  }

  // add product to user bookmarks
  Future<void> addBookmark(List<Product> bookmarks, Product product) async {
    if (!isBookmarked(bookmarks, product)) {
      bookmarks.add(product);
      await _auth.updateUserBookmarks(bookmarks);
    }
  }

  // remove product from user bookmarks
  Future<void> removeBookmark(List<Product> bookmarks, Product product) async {
    if (isBookmarked(bookmarks, product)) {
      bookmarks.remove(product);
      await _auth.updateUserBookmarks(bookmarks);
    }
  }
}
