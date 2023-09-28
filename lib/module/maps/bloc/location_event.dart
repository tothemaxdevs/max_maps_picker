// ignore_for_file: must_be_immutable
part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetUserCurrentLocationEvent extends LocationEvent {}

class SetUserCurrentLocationEvent extends LocationEvent {
  // LatLng latlong;
  double lat;
  double long;
  String location;
  SetUserCurrentLocationEvent(
      {required this.lat, required this.long, required this.location});
}

class SearchLocationInitialEvent extends LocationEvent {}

class SearchLocationEvent extends LocationEvent {
  String query;
  String localization;
  String apiKey;
  SearchLocationEvent(this.query, this.localization, {required this.apiKey});
}

class SetDetailLocationEvent extends LocationEvent {
  String place_id;
  LatLng latLang;
  SetDetailLocationEvent(this.place_id, this.latLang);
}

class GetLocationHistoryEvent extends LocationEvent {
  GetLocationHistoryEvent();
}

class DeleteLocationHistoryEvent extends LocationEvent {
  String id;
  DeleteLocationHistoryEvent(this.id);
}
