import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:max_maps_picker/module/maps/api/place_api_repository.dart';
import 'package:max_maps_picker/module/maps/models/place_search_result/place_search_result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PlaceApiRepository _placeApiProvider =
      PlaceApiRepository(const Uuid().v4());

  LocationBloc() : super(LocationInitial()) {
    on<SearchLocationInitialEvent>((event, emit) async {
      emit(SearchLocationInitialState());
    });
    on<SearchLocationEvent>(searchLocationEventHandler,
        transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
    return (events, mapper) {
      return events.debounceTime(duration).switchMap(mapper);
    };
  }

// Kepake
  searchLocationEventHandler(
      SearchLocationEvent event, Emitter<LocationState> emit) async {
    emit(SearchLocationLoadingState());

    if (event.query == '' || event.query == 'null') {
      emit(SearchLocationInitialState());
    } else {
      await _placeApiProvider
          .fetchSuggestions(event.query, event.localization,
              apiKey: event.apiKey)
          .then((value) {
        if (value.isNotEmpty) {
          emit(SearchLocationLoadedState(value));
        } else {
          emit(SearchLocationEmptyState('Search location empty'));
        }
      }, onError: (error) {
        emit(SearchLocationErrorState(error.toString()));
      });
    }
  }
}
