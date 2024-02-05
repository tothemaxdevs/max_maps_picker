class MapsPlaceDetailResult {
  bool? success;
  String? message;
  PlaceDetail? data;

  MapsPlaceDetailResult({
    this.success,
    this.message,
    this.data,
  });

  factory MapsPlaceDetailResult.fromJson(Map<String, dynamic> json) {
    return MapsPlaceDetailResult(
      success: json['success'],
      message: json['message'],
      data: PlaceDetail.fromJson(json['data']),
    );
  }
}

class PlaceDetail {
  String? formattedAddress;
  Geometry? geometry;
  String? name;

  PlaceDetail({
    this.formattedAddress,
    this.geometry,
    this.name,
  });

  factory PlaceDetail.fromJson(Map<String, dynamic> json) {
    return PlaceDetail(
      formattedAddress: json['formatted_address'],
      geometry: Geometry.fromJson(json['geometry']),
      name: json['name'],
    );
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({
    this.location,
    this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
      viewport: Viewport.fromJson(json['viewport']),
    );
  }
}

class Location {
  double? lat;
  double? lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: Location.fromJson(json['northeast']),
      southwest: Location.fromJson(json['southwest']),
    );
  }
}
