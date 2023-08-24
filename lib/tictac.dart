import 'package:flutter/material.dart';

class tictac extends StatefulWidget {
  @override
  State<tictac> createState() => _tictacState();
}

class _tictacState extends State<tictac> {
  var grid = ['', '', '', '', '', '', '', '', ''];

  var winner = '';

  var currentplayer = 'X';
  void drawxo(i) {
    if (grid[i] == '') {
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
      });

      findWinner(grid[i]);
    }
  }

  void reset() {
    setState(() {
      winner = '';
      grid = ['', '', '', '', '', '', '', '', ''];
    });
  }

  bool checkMove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    } else {
      return false;
    }
  }

  void findWinner(currentsign) {
    if (checkMove(0, 1, 2, currentsign) ||
        checkMove(3, 4, 5, currentsign) ||
        checkMove(6, 7, 8, currentsign) ||
        checkMove(0, 4, 8, currentsign) ||
        checkMove(2, 4, 6, currentsign) ||
        checkMove(0, 3, 6, currentsign) ||
        checkMove(1, 4, 7, currentsign) ||
        checkMove(2, 5, 8, currentsign)) {
      setState(() {
        winner = currentsign;
        show(winner);
        currentplayer = 'X';
        reset();
      });
    } else {
      if (grid[0] != '' &&
          grid[1] != '' &&
          grid[2] != '' &&
          grid[3] != '' &&
          grid[4] != '' &&
          grid[5] != '' &&
          grid[6] != '' &&
          grid[7] != '' &&
          grid[8] != '') {
        setState(() {
          winner = currentsign;
          showDraw();
          currentplayer = 'X';
          reset();
        });
      }
    }
  }

  void show(winner) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Column(
                children: [
                  Text(
                    '$winner has won',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showDraw() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Column(
                children: [
                  Text(
                    'Game is a draw',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.grid_3x3_outlined,
                color: Colors.white,
              ),
              Text(" Tic Tac Toe",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 72, 129),
      ),
      body: Center(
        child: Column(
          children: [
            // if (winner != "")
            // Text(
            //   '$winner has won',
            //   style: TextStyle(fontSize: 20, color: Colors.black),
            // ),
            Container(
              constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
              margin: EdgeInsets.all(20),
              color: Colors.black,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: grid.length,
                  itemBuilder: (context, index) => Material(
                        color: Color.fromARGB(255, 2, 72, 129),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 2, 72, 129),
                          onTap: () => drawxo(index),
                          child: Center(
                              child: Text(
                            grid[index],
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          )),
                        ),
                      )),
            ),
            Column(
              children: [
                ElevatedButton.icon(
                    onPressed: reset,
                    icon: Icon(Icons.refresh),
                    label: Text(
                      "Play again",
                      style: TextStyle(fontSize: 25),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text(
                        "Go back",
                        style: TextStyle(fontSize: 25),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
