import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:max_maps_picker/constants/dimens.constant.dart';
import 'package:max_maps_picker/constants/divider.constant.dart';
import 'package:max_maps_picker/module/maps/models/maps_result.dart';
import 'package:max_maps_picker/module/maps/screen/map_autocomplete_widget.dart';
import 'package:max_maps_picker/utils/view_utils.dart';
import 'package:max_maps_picker/widget/button/rounded_button.dart';
import 'package:max_maps_picker/widget/text/text_widget.dart';

class MapsPicker extends StatefulWidget {
  String apiKey, api;
  MapResult? mapData;
  Widget? marker;
  MapsPicker(
      {Key? key,
      required this.apiKey,
      required this.api,
      this.mapData,
      this.marker})
      : super(key: key);

  @override
  State<MapsPicker> createState() => _MapsPickerState();
}

class _MapsPickerState extends State<MapsPicker> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  String _draggedAddress = "";

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    //set default latlng for camera position
    if (widget.mapData != null) {
      _defaultLatLng = LatLng(widget.mapData!.lat!, widget.mapData!.lng!);
    } else {
      _defaultLatLng = const LatLng(-6.902322378022154, 107.61872325317161);
    }

    _draggedLatlng = _defaultLatLng;
    _cameraPosition =
        CameraPosition(target: _defaultLatLng, zoom: 17.5 // number of map view
            );

    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),

      //get a float button to click and go to current location
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _gotoUserCurrentPosition();
      //   },
      //   child: const Icon(Icons.location_on),
      // ),
    );
  }

  Widget _buildBody() {
    return Stack(children: [
      _getMap(),
      _getCustomPin(),
      Positioned(bottom: 0, child: _showDraggedAddress()),
      Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: MapAutocompleteWidget(
            apiKey: widget.apiKey,
            api: widget.api,
            onClicked: (value) {
              print('Called click');
              _gotoSpecificPosition(value);
            },
          ))
    ]);
  }

  Widget _showDraggedAddress() {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height * 0.28,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _myLocationButton(),
            Container(
              padding: const EdgeInsets.only(
                  top: Dimens.size8,
                  bottom: Dimens.size16,
                  right: Dimens.size16,
                  left: Dimens.size16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimens.size16),
                      topRight: Radius.circular(Dimens.size16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  indicatorModal(),
                  TextWidget(
                    'Cari Lokasimu',
                    size: TextWidgetSize.h3,
                    weight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  divideThick(),
                  const SizedBox(
                    height: 16,
                  ),
                  TextWidget(
                    'Lokasimu',
                    size: TextWidgetSize.h7,
                    textColor: const Color(0xff4C4E5A),
                  ),
                  _draggedAddress != null
                      ? TextWidget(
                          _draggedAddress,
                          size: TextWidgetSize.h6,
                          weight: FontWeight.w500,
                        )
                      : loading(),
                  divide24,
                  RoundedButton(
                    width: double.infinity,
                    text: 'Pilih',
                    press: _draggedLatlng != null
                        ? () {
                            Navigator.pop(
                                context,
                                MapResult(
                                    address: _draggedAddress,
                                    lat: _draggedLatlng.latitude,
                                    lng: _draggedLatlng.longitude));
                          }
                        : null,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition:
          _cameraPosition!, //initialize camera position for map
      mapType: MapType.terrain,
      onCameraIdle: () {
        //this function will trigger when user stop dragging on map
        //every time user drag and stop it will display address
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        //this function will trigger when user keep dragging on map
        //every time user drag this will get value of latlng
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        //this function will trigger when map is fully loaded
        if (!_googleMapController.isCompleted) {
          //set controller to google map when it is fully loaded
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: widget.marker ??
          SizedBox(
            width: 70,
            child: Lottie.asset(
              "assets/pin.json",
              package: 'max_maps_picker',
            ),
            // child: TextWidget('Test'),
          ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    setState(() {
      _draggedAddress = addresStr;
    });
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      log("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        log("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      log("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  _myLocationButton() {
    return Container(
      margin: const EdgeInsets.all(Dimens.size16),
      height: Dimens.size56,
      width: Dimens.size56,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200, // Shadow color
            blurRadius: 4, // Spread of the shadow
            offset: const Offset(0, 4), // Offset of the shadow (x, y)
          ),
        ],
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        onTap: () {
          _gotoUserCurrentPosition();
        },
        child: const Material(
          color: Colors.transparent,
          child: Icon(
            Icons.my_location_rounded,
            size: Dimens.size20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
