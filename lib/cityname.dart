import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class city extends StatefulWidget {
  const city({super.key});

  @override
  State<city> createState() => cityState();
}

class cityState extends State<city> {
  final citycontroller = TextEditingController();
  static late String cityname;

  @override
  void dispose() {
    citycontroller.dispose();
    // TODO: implement dispose
    super.dispose();
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
                Icons.location_city_outlined,
                color: Colors.white,
              ),
              Text(" City Name",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 72, 129),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: citycontroller,
              decoration: InputDecoration(
                  label: Text("Enter your city"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Icon(Icons.location_city)),
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    cityname = citycontroller.text.toString();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => WeatherScreen()));
                  },
                  child: Text(
                    'Enter',
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
    );
  }
}
