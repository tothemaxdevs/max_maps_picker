import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:max_maps_picker/module/maps/api/place_api_repository.dart';
import 'package:max_maps_picker/module/maps/models/maps_autocomplete_result.dart';
import 'package:max_maps_picker/module/maps/models/maps_place_detail_result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PlaceApiRepository _placeApiProvider = PlaceApiRepository();

  LocationBloc() : super(LocationInitial()) {
    on<SearchLocationInitialEvent>((event, emit) async {
      emit(GetAutoCompleteInitialState());
    });
    on<GetAutoCompleteEvent>(_searchLocationEventHandler,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<GetPlaceDetailEvent>(_getPlaceDetail);
  }

  EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
    return (events, mapper) {
      return events.debounceTime(duration).switchMap(mapper);
    };
  }

  _searchLocationEventHandler(
      GetAutoCompleteEvent event, Emitter<LocationState> emit) async {
    emit(GetAutoCompleteLoadingState());

    try {
      emit(GetAutoCompleteLoadingState());
      final data = await _placeApiProvider.getAutoComplete(
          apiKey: event.apiKey,
          api: event.api!,
          bearerToken: event.bearerToken,
          params: event.params);
      if (data.statusCode == 200) {
        MapsAutocompleteResult result =
            MapsAutocompleteResult.fromJson(data.data);
        if (result.data!.predictions!.isNotEmpty) {
          emit(GetAutoCompleteLoadedState(result.data!.predictions!));
        } else {
          emit(GetAutoCompleteEmptyState('Search location empty'));
        }
      }
    } catch (e) {
      emit(GetAutoCompleteErrorState(e.toString()));
    }
  }

  _getPlaceDetail(
      GetPlaceDetailEvent event, Emitter<LocationState> emit) async {
    emit(GetPlaceDetailLoadingState());

    try {
      emit(GetPlaceDetailLoadingState());
      final data = await _placeApiProvider.getPlaceDetail(
          apiKey: event.apiKey,
          api: event.api!,
          bearerToken: event.bearerToken,
          params: event.params);
      if (data.statusCode == 200) {
        MapsPlaceDetailResult result =
            MapsPlaceDetailResult.fromJson(data.data);

        emit(GetPlaceDetailLoadedState(result));
      } else {
        emit(GetPlaceDetailFailedState('Search location empty'));
      }
    } catch (e) {
      emit(GetPlaceDetailErrorState(e.toString()));
    }
  }
}
