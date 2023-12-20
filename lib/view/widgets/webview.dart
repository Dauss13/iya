import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookController extends GetxController {
  final RxString url = ''.obs;

  void setUrl(String newUrl) {
    url.value = newUrl;
  }
}

class BookWebView extends StatefulWidget {
  final String url;

  BookWebView(this.url);

  @override
  _BookWebViewState createState() => _BookWebViewState();
}

class _BookWebViewState extends State<BookWebView> {
  late WebViewController _controller;
  final BookController bookController = Get.put(BookController());

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(bookController.url.value)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    // Set the URL in the controller
    bookController.setUrl(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
