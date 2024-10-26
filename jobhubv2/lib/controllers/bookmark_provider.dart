import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhubv2_0/models/response/bookmarks/bookmark.dart';
import 'package:jobhubv2_0/services/helpers/book_helper.dart';

class BookmarkNotifier extends ChangeNotifier {
  bool _bookmark = false;
  bool get getbookmark => _bookmark;
  late Future<List<AllBookmarks>> bookmarks;
  late Future<BookMark?> bookmark;
  set isbookmark(bool value) {
    if (_bookmark != value) {
      _bookmark = value;
      notifyListeners();
    }
  }

  String _bookmarkId = "";
  String get bookmarkId => _bookmarkId;
  set isbookmarkId(String value) {
    if (_bookmarkId != value) {
      _bookmarkId = value;
      notifyListeners();
    }
  }

  addBookMark(String model) {
    BookMarkHelper.addBookmark(model).then((bookmark) {
      isbookmark = true;
      isbookmarkId = bookmark.bookmarkId;
      notifyListeners();
    });
  }

  getBookMark(String id) {
    bookmark = BookMarkHelper.getBookmark(id);

    bookmark.then((value) {
      if (value == null) {
        isbookmark = false;
        isbookmarkId = '';

        notifyListeners();
      } else {
        print("inside else statement");
        isbookmark = true;
        isbookmarkId = value.bookmark.id;
        notifyListeners();
      }
    });
  }

  deleteBookMark(String id) {
    BookMarkHelper.deleteBookmark(id).then((bookmark) {
      if (bookmark) {
        Get.snackbar("Bookmark Successfully Deleted",
            "Visit the Bookmark page to see the changes",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.bookmark_remove_outlined));
        isbookmark = false;
        notifyListeners();
      }
    });
  }

  Future<List<AllBookmarks>> getAllBookmarks() {
    bookmarks = BookMarkHelper.getAllBookmark();
    bookmarks.then((value) {
      print(value);
    });
    notifyListeners();
    return bookmarks;
  }
}
