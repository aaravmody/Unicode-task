import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/cityname.dart';
import 'package:weather/contact_2.dart';
import 'package:weather/contacts.dart';
import 'package:weather/login.dart';
import 'package:weather/qr.dart';
import 'package:weather/tictac.dart';
import 'package:weather/weather.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Icon(Icons.home),
        splashIconSize: 200,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.blue,
        nextScreen: MyDashboard(),
      ),
    );
  }
}

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
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
                Icons.home,
                color: Colors.white,
              ),
              Text(" Home",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 72, 129),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Wrap(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "Welcome to my app, $username",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Wrap(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        logindata.setBool('login', true);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => city()));
                      },
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.cloud, color: Colors.black),
                            Text('  Weather',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black,
                                )),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green)),
                      onPressed: () {
                        logindata.setBool('Login', true);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.person),
                            Text('  Contacts',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                )),
                          ]),
                    ),
                  ),
                ],
              ),
              Wrap(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.lightBlue)),
                      onPressed: () {
                        logindata.setBool('Login', true);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => tictac()));
                      },
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.grid_3x3, color: Colors.white),
                            Text('  Tic Tac Toe',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                )),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.brown)),
                      onPressed: () {
                        logindata.setBool('Login', true);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => QrCode()));
                      },
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.qr_code, color: Colors.white),
                            Text('  QR Code Generator',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                )),
                          ]),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    logindata.setBool('login', true);
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
