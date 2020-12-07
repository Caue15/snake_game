import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/inicio.dart';

class Splash extends StatefulWidget {
  static String id = 'splash';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 1)).then((_) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Inicio())); //Inicio()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xff222222),
        child: Center(
          child: Text(
            'S n a k e  G a m e',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ));
  }
}
