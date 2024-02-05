// ignore_for_file: must_be_immutable
part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class GetAutoCompleteLoadingState extends LocationState {
  GetAutoCompleteLoadingState();
}

class GetAutoCompleteInitialState extends LocationState {
  GetAutoCompleteInitialState();
}

class GetAutoCompleteLoadedState extends LocationState {
  List<Prediction> places;
  GetAutoCompleteLoadedState(this.places);
}

class GetAutoCompleteEmptyState extends LocationState {
  String message;
  GetAutoCompleteEmptyState(this.message);
}

class GetAutoCompleteErrorState extends LocationState {
  String message;
  GetAutoCompleteErrorState(this.message);
}

class GetPlaceDetailLoadingState extends LocationState {
  GetPlaceDetailLoadingState();
}

class GetPlaceDetailInitialState extends LocationState {
  GetPlaceDetailInitialState();
}

class GetPlaceDetailLoadedState extends LocationState {
  MapsPlaceDetailResult data;
  GetPlaceDetailLoadedState(this.data);
}

class GetPlaceDetailFailedState extends LocationState {
  String message;
  GetPlaceDetailFailedState(this.message);
}

class GetPlaceDetailErrorState extends LocationState {
  String message;
  GetPlaceDetailErrorState(this.message);
}
