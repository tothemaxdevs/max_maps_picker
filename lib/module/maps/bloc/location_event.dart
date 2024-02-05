// ignore_for_file: must_be_immutable
part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class SearchLocationInitialEvent extends LocationEvent {}

class GetAutoCompleteEvent extends LocationEvent {
  String? api, apiKey, bearerToken;
  Map<String, dynamic> params;
  GetAutoCompleteEvent(
      {required this.params, this.api, this.bearerToken, this.apiKey});
}

class GetPlaceDetailEvent extends LocationEvent {
  String? api, apiKey, bearerToken;
  Map<String, dynamic> params;
  GetPlaceDetailEvent(
      {required this.params, this.api, this.bearerToken, this.apiKey});
}
