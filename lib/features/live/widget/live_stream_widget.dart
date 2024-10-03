import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveStreamWidget extends StatefulWidget {
  const LiveStreamWidget({super.key});

  @override
  _LiveStreamWidgetState createState() => _LiveStreamWidgetState();
}

class _LiveStreamWidgetState extends State<LiveStreamWidget> {
  late WebViewController _controller1;
  late WebViewController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = WebViewController()
      ..loadRequest(Uri.parse(
          'https://video.gjirafa.com/embed/ktv-live?autoplay=true&am=true&c=1&ts=true'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    _controller2 = WebViewController()
      ..loadRequest(Uri.parse(
          'https://video.gjirafa.com/embed/arta-news?autoplay=true&am=true&c=1&ts=true'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(controller: _controller1),
            ),
            const SizedBox(height: 1),
            Expanded(
              child: WebViewWidget(controller: _controller2),
            ),
          ],
        ),
      ),
    );
  }
}
