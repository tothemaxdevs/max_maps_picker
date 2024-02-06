class MapsPlaceDetailResult {
  final bool? success;
  final String? message;
  final PlaceData? data;

  MapsPlaceDetailResult({this.success, this.message, this.data});

  factory MapsPlaceDetailResult.fromJson(Map<String, dynamic> json) {
    return MapsPlaceDetailResult(
      success: json['success'],
      message: json['message'],
      data: PlaceData.fromJson(json['data']),
    );
  }
}

class PlaceData {
  final Place? placeDetail;

  PlaceData({this.placeDetail});

  factory PlaceData.fromJson(Map<String, dynamic> json) {
    return PlaceData(
      placeDetail: Place.fromJson(json['place_detail']),
    );
  }
}

class Place {
  final String? formattedAddress;
  final PlaceGeometry? geometry;
  final String? name;

  Place({this.formattedAddress, this.geometry, this.name});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      formattedAddress: json['formatted_address'],
      geometry: PlaceGeometry.fromJson(json['geometry']),
      name: json['name'],
    );
  }
}

class PlaceGeometry {
  final PlaceLocation? location;
  final PlaceViewport? viewport;

  PlaceGeometry({this.location, this.viewport});

  factory PlaceGeometry.fromJson(Map<String, dynamic> json) {
    return PlaceGeometry(
      location: PlaceLocation.fromJson(json['location']),
      viewport: PlaceViewport.fromJson(json['viewport']),
    );
  }
}

class PlaceLocation {
  final double? lat;
  final double? lng;

  PlaceLocation({this.lat, this.lng});

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class PlaceViewport {
  final PlaceLocation? northeast;
  final PlaceLocation? southwest;

  PlaceViewport({this.northeast, this.southwest});

  factory PlaceViewport.fromJson(Map<String, dynamic> json) {
    return PlaceViewport(
      northeast: PlaceLocation.fromJson(json['northeast']),
      southwest: PlaceLocation.fromJson(json['southwest']),
    );
  }
}
