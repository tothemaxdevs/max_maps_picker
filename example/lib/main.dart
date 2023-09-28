import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:max_maps_picker/constants/dimens.constant.dart';
import 'package:max_maps_picker/max_map_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? address;
  double? lat, lng;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.map_outlined),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Address : $address'),
              Text('Latitude : $lat'),
              Text('Longitude : $lng'),
              const SizedBox(
                height: 100,
              ),
              MaxMapsPicker(
                apiKey: '',
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.size10, horizontal: Dimens.size32),
                  child: const Text('Pick Map'),
                ),
                onResult: (value) {
                  setState(() {
                    address = value.address;
                    lat = value.lat;
                    lng = value.lng;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
