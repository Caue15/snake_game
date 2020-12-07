import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/inicio.dart';
import 'package:snake_game/snake_game.dart';
import 'package:snake_game/splash_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
//    @override
//    void initState() {
//      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//      super.initState();
//    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.id,
      routes: {
        Splash.id: (context) => Splash(),
        Inicio.id: (context) => Inicio(),
        Jogo.id: (context) => Jogo(),
      },
    );
  }
}

// TODO: 7 - Publicar o app na google play!
// TODO: 8 - Aprender a colocar sons
// TODO: 9 - Aprender a colocar anúncios
