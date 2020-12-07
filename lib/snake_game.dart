import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:snake_game/inicio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Jogo extends StatelessWidget {
  static String id = 'jogo';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JogoPage(),
    );
  }
}

class JogoPage extends StatefulWidget {
  @override
  _JogoPageState createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  int numberOfSquares = 640;
  //Box box; //AQUI
  bool jogando = false;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(640);
  void generateNewFood() {
    food = randomNumber.nextInt(580);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int dado = prefs.getInt('hs') ?? 0;
    //int dado = box.get('score');
    //if (dado is int) {
    //print('Retornou dado');
    //print('Dado é = $dado');
    return dado;
  }

  void atualizaData() async {
    int recorde = await getData();
    //print('recorde = $recorde');
    int pontoAtual = snakePosition.length - 5;
    if (recorde < pontoAtual) {
      //print('chamou putData 1');
      SharedPreferences prefs = await SharedPreferences.getInstance(); //SP
      prefs.remove('hs');
      prefs.setInt('hs', pontoAtual); //SP
    }
  }

  void startGame() {
    jogando = true;
    snakePosition = [45, 65, 85, 105, 125];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
      }
    });
  }

  var direction = 'down';
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last > 620) {
            snakePosition.add(snakePosition.last + 20 - 640);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }

          break;

        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last - 20 + 640);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }

          break;

        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }

          break;

        case 'right':
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;

        default:
      }

      if (snakePosition.last == food) {
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          atualizaData();
          return true;
        }
      }
    }
    return false;
  }

  void _showGameOverScreen() async {
    int recorde;
    int pontoAtual = snakePosition.length - 5; //AQUI
    var data = await getData(); //AQUI
    //int hive = 10;
    jogando = false;
    //print('teste = $data');
    //recorde = 10;
    recorde = max(pontoAtual, data); //AQUI
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(
              'GAME OVER',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pontuação: $pontoAtual\n',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Sua pontuação máxima é: $recorde',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Inicio.id);
                },
                child: Text(
                  'Ir ao Menu',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  direction = 'down';
                  if (jogando == false) {
                    Navigator.of(context).pop();
                    return startGame();
                  }
                },
                child: Text(
                  'Jogar Novamente',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  Color getColor() {
    if (jogando == true) {
      return Colors.grey;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                } else if (direction != 'rigth' && details.delta.dx < 0) {
                  direction = 'left';
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 20),
                    itemBuilder: (BuildContext context, int index) {
                      if (snakePosition.contains(index)) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: Colors.green[500],
                              ),
                            ),
                          ),
                        );
                      }
                      if (index == food) {
                        return Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(color: Colors.red)),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(color: Colors.grey[800])),
                        );
                      }
                    }),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (jogando == false) ? startGame : null,
                  child: Text(
                    'c o m e ç a r',
                    style: TextStyle(color: getColor(), fontSize: 25),
                  ),
                ),
                Text(
                  'Pontuação: ${snakePosition.length - 5}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
