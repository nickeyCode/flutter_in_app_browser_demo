import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTPpage extends StatelessWidget {
  static String routerName = "/OTPpage";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("OTP Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("otp verify result is : data~~~"),
            TextButton(
                onPressed: () {
                  print("return web page");
                  Navigator.pop(context, "data~~~");
                },
                child: Text("Verify done"))
          ],
        ),
      ),
    );
  }
}
