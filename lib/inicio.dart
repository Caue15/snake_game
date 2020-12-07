import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:snake_game/snake_game.dart';

class Inicio extends StatefulWidget {
  static String id = 'inicio';

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Tween<double> _scaleTween = Tween<double>(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222222),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            tween: _scaleTween,
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 2000),
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: Text(
              'S n a k e  G a m e',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          TweenAnimationBuilder(
            tween: _scaleTween,
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 2500),
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: Container(
              width: 350,
              height: 300,
              child: Image(
                image: AssetImage('images/logo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          TweenAnimationBuilder(
            tween: _scaleTween,
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 2000),
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: Center(
                child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, Jogo.id),
              child: Container(
                height: 90,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[850],
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(3.0, 3.0),
                    )
                  ],
                ),
                child: Center(
                    child: Text(
                  'J O G A R',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
