import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/bookmark_provider.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/auth/guest_user.dart';
import 'package:jobhubv2_0/views/screens/bookmarks/widgets/bookmark_tile.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/uploaded_tile.dart';
import 'package:provider/provider.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  Future<List<AllBookmarks>>? bookmarks;

  @override
  void initState() {
    super.initState();
    bookmarks =
        Provider.of<BookmarkNotifier>(context, listen: false).getAllBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    var login = Provider.of<LoginNotifier>(context);
    return Scaffold(
        backgroundColor: Color(0xFF3281E3),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
                text: login.loggedIn == false ? "" : "Bookmarks",
                color: const Color(0xFF3281E3),
                titlecolor: Colors.white.value,
                child: Padding(
                  padding: EdgeInsets.all(10.0.h),
                  child: DrawerWidget(color: Color(kDark.value)),
                ))),
        body: login.getloggedIn == false
            ? const GuestUser()
            : Consumer<BookmarkNotifier>(
                builder: (context, bookmarknotifier, child) {
                return Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.w),
                                  topLeft: Radius.circular(20.w)),
                              color: const Color(0xFFEFFFFC)),
                          child: buildStyleContainer(
                              context,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: FutureBuilder<List<AllBookmarks>>(
                                    future: bookmarks,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: PageLoader());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                snapshot.error.toString()));
                                      } else if (snapshot.data!.isEmpty) {
                                        return const Center(
                                            child: Text("No Jobs Found"));
                                      } else {
                                        final bookmarks = snapshot.data;
                                        return ListView.builder(
                                            itemCount: bookmarks!.length,
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var bookmark = bookmarks[index];
                                              return BookmarkTile(
                                                  bookmark: bookmark);
                                            });
                                      }
                                    }),
                              )),
                        ))
                  ],
                );
              }));
  }
}
