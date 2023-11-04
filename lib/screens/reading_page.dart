import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/utils/url_extention.dart';
import 'package:books_app/widgets/buttons/button_favorites/button_favorites.dart';
import 'package:books_app/widgets/buttons/button_navigation_bar/button_navgation_bar_addedroutes.dart';
import 'package:books_app/widgets/no_internet_connection_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Widget has the purpose to open the book to read the previewLink if available;
/// To do it, uses WebView package. As the ReadingPage has access from the bottom
/// navigationbar from other pages and also through the LibraryPage once a book on
/// the ToRead row is selected, the ReadingPage has a check call option to retrieve
/// the link of the widget which can be reading at this time using IF widget.link is null
///
class ReadingPage extends StatefulWidget {
  final String? link;
  final String? title, cover;
  const ReadingPage({super.key, this.link, this.cover, this.title});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  int loadingPercentage = 0;
  late final WebViewController controller;
  bool isConnected = false;
  late String title, cover, previewLink;
  late dynamic bookPreview;
  ReadingPage urlRenameExtention = const ReadingPage();

  @override
  Widget build(BuildContext context) {
    ScreenSize myscreen = ScreenSize(context);
    final apiState = context.watch<ApiConnectionCubit>().state;

    if (apiState == ApiConnectionState.connected) {
      isConnected = true;
      if (widget.link == null || widget.link!.isEmpty) {
        title = UrlLinkExtention.title;
        cover = UrlLinkExtention.cover;
        const previewLink = UrlLinkExtention.previewLink;
        bookPreview = Uri.parse(previewLink);
      } else {
        final correctedUrl =
            urlRenameExtention.convertHttpToHttps(widget.link!);
        bookPreview = Uri.parse(correctedUrl);
      }
      controller = WebViewController()
        ..loadRequest(
          bookPreview,
        );
    } else {
      isConnected = false;
    }

    return Scaffold(
      body: SafeArea(
        top: true,
        left: true,
        right: true,
        bottom: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              isConnected
                  ? Center(
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                            width: 90,
                            height: 90,
                            child: CachedNetworkImage(imageUrl: cover)),
                        const ButtonFavorites(),
                      ]),
                    )
                  : const SizedBox.shrink(),
              isConnected
                  ? Text('Title: $title').pageTitleStyle()
                  : const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: NoInternetConnectionMessage()),
              isConnected
                  ? SizedBox(
                      width: myscreen.screenWidth,
                      height: myscreen.screenHeight * 0.8,
                      child: WebViewWidget(controller: controller))
                  : const Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Center(child: NoInternetConnectionBox())),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ButtonNavigationBarAddedRoutes(
        type: 'reading',
      ),
    );
  }
}
