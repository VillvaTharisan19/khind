import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khind/screens/signin.dart';
import 'package:khind/themes/app_colors.dart';
import 'package:khind/util/api.dart';
import 'package:khind/util/helpers.dart';
import 'package:khind/util/key.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final storage = new FlutterSecureStorage();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      _validateToken();
    });
  }

  _redirect() async {
    String? isAuth = await storage.read(key: IS_AUTH);

    if (isAuth != null && isAuth == '1') {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      Navigator.pushReplacementNamed(context, 'signin');
    }
  }

  _fetchOauth() async {
    final response = await Api.basicPost('oauth2/token/client_credentials');

    if (response['access_token'] != null) {
      await storage.write(key: TOKEN, value: response['access_token']);

      if (response['expires_in'] != null) {
        var curDate = new DateTime.now();
        var expDate = curDate.add(Duration(milliseconds: response['expires_in']));

        await storage.write(key: TOKEN_EXPIRY, value: (expDate.millisecondsSinceEpoch).toString());
      }
    }
  }

  _validateToken() async {
    // String? tokenExp = await storage.read(key: TOKEN_EXPIRY);

    // if (tokenExp != null) {
    //   var expDate = DateTime.fromMillisecondsSinceEpoch(int.parse(tokenExp));

    //   if (expDate.difference(DateTime.now()).inMinutes <= 0) {
    //     print("Token Expired: $expDate");
    //     _fetchOauth();
    //   } else {
    //     print("Token Not Expired");
    //   }
    // } else {
    //   _fetchOauth();
    // }
    _fetchOauth();
    _redirect();
  }

  Widget _renderHeader() {
    return Container(
        alignment: Alignment.center,
        child: Image(
            image: AssetImage('assets/images/logo_text.png'),
            height: MediaQuery.of(context).size.width * 0.2));
  }

  Widget _renderLoading() {
    return CircularProgressIndicator(color: AppColors.primary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_renderHeader(), SizedBox(height: 50), _renderLoading()])),
    );
  }
}

class SignInPageRoute extends CupertinoPageRoute {
  SignInPageRoute() : super(builder: (BuildContext context) => new SignIn());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return new ScaleTransition(scale: animation, child: new SignIn());
    // return new FadeTransition(opacity: animation, child: new SignIn());
  }
}
