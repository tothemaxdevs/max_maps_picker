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
                apiKey: '0f99beea-bfbf-11ec-9708-ef87d9a9c4d9',
                api: 'https://customer.backend.dev.orderia.id/api/v1/',
                bearerToken:
                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImMwNWRiZWRiLTdhYzAtNGYwMC1hNGMxLTQyMDRlYzViMzY4MSIsImlhdCI6MTcwNjI1NjY4MH0.9s_gUeF0x0_KPFR3XG7G-SrFr5fpYyMMt_hW5V1f01c',
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
