import 'package:flutter/material.dart';
import 'package:max_maps_picker/module/maps/models/maps_result/maps_result.dart';
import 'package:max_maps_picker/module/maps/screen/map_screen.dart';

class MaxMapsPicker extends StatefulWidget {
  String apiKey;
  MapResult? initialData;
  Function(MapResult)? onResult;
  Widget child;
  Widget? marker;
  MaxMapsPicker(
      {Key? key,
      required this.child,
      required this.apiKey,
      this.onResult,
      this.marker,
      this.initialData})
      : super(key: key);

  @override
  State<MaxMapsPicker> createState() => _MaxMapsPickerState();
}

class _MaxMapsPickerState extends State<MaxMapsPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var maps = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapsPicker(
                      apiKey: widget.apiKey,
                      mapData: widget.initialData,
                      marker: widget.marker,
                    )));
        if (maps != null) {
          widget.onResult!(maps);
        }
      },
      child: widget.child,
    );
  }
}
