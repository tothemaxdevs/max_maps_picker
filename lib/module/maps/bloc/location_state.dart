// ignore_for_file: must_be_immutable
part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class SearchLocationLoadingState extends LocationState {
  SearchLocationLoadingState();
}

class SearchLocationInitialState extends LocationState {
  SearchLocationInitialState();
}

class SearchLocationLoadedState extends LocationState {
  List<PlaceSearchResult> places;
  SearchLocationLoadedState(this.places);
}

class SearchLocationEmptyState extends LocationState {
  String message;
  SearchLocationEmptyState(this.message);
}

class SearchLocationErrorState extends LocationState {
  String message;
  SearchLocationErrorState(this.message);
}
