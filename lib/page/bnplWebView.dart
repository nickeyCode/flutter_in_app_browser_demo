import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inappweb_demo/page/otpPage.dart';

class BNPLwebView extends StatefulWidget {
  static String routerName = "/Browser";
  BNPLwebView({Key? key}) : super(key: key);

  @override
  State<BNPLwebView> createState() => _BrowserState();
}

class _BrowserState extends State<BNPLwebView> {
  late InAppWebViewController webView;
  String url = "";
  double progress = 0;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),

    /// android 支持HybridComposition
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("bnpl web"),
      ),
      body: InAppWebView(
          key: webViewKey,
          initialUrlRequest:
              URLRequest(url: Uri.parse("http://114.132.160.224/cv/test.html")),
          initialOptions: options,
          onWebViewCreated: (controller) {
            webView = controller;
            controller.addJavaScriptHandler(
                handlerName: "verifyUser",
                callback: (args) async {
                  print("verify call back");
                  print(args);
                  var result = await _inputPIN(context);
                  return result;
                });
          },
          onLoadStart: (controller, url) {
            setState(() {
              this.url = url.toString();
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          }),
    );
  }

  Future<String?> _inputPIN(context) {
    return showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(),
            elevation: 0,
            title: const Text("Input PIN"),
            content: const Text("PIN"),
            actions: [
              TextButton(
                  onPressed: () async {
                    var result =
                        await Navigator.pushNamed(context, OTPpage.routerName);
                    Navigator.pop(context, result);
                  },
                  child: Text("Confirm")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, "cancel");
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }
}
