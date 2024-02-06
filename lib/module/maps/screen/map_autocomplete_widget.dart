import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:max_maps_picker/config/colors/pallete.config.dart';
import 'package:max_maps_picker/constants/dimens.constant.dart';
import 'package:max_maps_picker/constants/divider.constant.dart';
import 'package:max_maps_picker/module/maps/bloc/location_bloc.dart';
import 'package:max_maps_picker/widget/text/text_widget.dart';

import '../../../utils/view_utils.dart';

class MapAutocompleteWidget extends StatefulWidget {
  Function(LatLng)? onClicked;
  String apiKey, api;
  MapAutocompleteWidget(
      {Key? key, this.onClicked, required this.apiKey, required this.api})
      : super(key: key);

  static const String path = '/base';
  static const String title = 'base';

  @override
  _MapAutocompleteWidgetState createState() => _MapAutocompleteWidgetState();
}

class _MapAutocompleteWidgetState extends State<MapAutocompleteWidget> {
  String? title;
  late LocationBloc _searchLocationBloc;
  TextEditingController locationController = TextEditingController();
  bool? hideList = false;
  @override
  void initState() {
    _searchLocationBloc = LocationBloc()..add(SearchLocationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 48,
                width: 48,
                margin: const EdgeInsets.only(left: Dimens.size16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100, // Shadow color
                      blurRadius: 4, // Spread of the shadow
                      offset: const Offset(0, 4), // Offset of the shadow (x, y)
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            Flexible(
              child: MaxSearchBar(
                autoFocus: false,
                controller: locationController,
                hintText: 'Cari lokasi',
                onChanged: (query) {
                  Map<String, dynamic> params = {};
                  params['input'] = query;
                  _searchLocationBloc.add(
                    GetAutoCompleteEvent(
                        apiKey: widget.apiKey, params: params, api: widget.api),
                  );
                },
              ),
            ),
            divideW14,
          ],
        ),
        BlocConsumer<LocationBloc, LocationState>(
          bloc: _searchLocationBloc,
          listener: (context, state) {
            if (state is GetAutoCompleteLoadedState) {
              hideList = false;
            } else if (state is GetPlaceDetailLoadedState) {
              widget.onClicked!(LatLng(
                  state.data.data!.placeDetail!.geometry!.location!.lat!,
                  state.data.data!.placeDetail!.geometry!.location!.lng!));

              FocusManager.instance.primaryFocus!.unfocus();
            } else if (state is GetPlaceDetailFailedState) {
              showToastError(state.message);
            }
          },
          builder: (context, state) {
            if (state is GetAutoCompleteInitialState) {
              return Container();
            } else {
              return _buildSearchLocationView(state);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSearchLocationView(Object? state) {
    return Builder(
      builder: (context) {
        if (state is GetAutoCompleteLoadedState) {
          return hideList == false
              ? Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: Dimens.size16, vertical: Dimens.size6),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100, // Shadow color
                          blurRadius: 4, // Spread of the shadow
                          offset:
                              const Offset(0, 4), // Offset of the shadow (x, y)
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimens.size16)),
                      color: Colors.white),
                  child: Column(
                      children: List.generate(
                          state.places.length > 5 ? 5 : state.places.length,
                          (index) => listSearch(
                              onTap: () {
                                Map<String, dynamic> params = {};
                                params['place_id'] =
                                    state.places[index].placeId;
                                _searchLocationBloc.add(
                                  GetPlaceDetailEvent(
                                      apiKey: widget.apiKey,
                                      params: params,
                                      api: widget.api),
                                );

                                setState(() {
                                  locationController.text =
                                      '${state.places[index].mainText ?? ''}, ${state.places[index].secondaryText ?? ''}';
                                  hideList = true;
                                });
                              },
                              placeName: state.places[index].mainText,
                              placeAddress:
                                  state.places[index].secondaryText))),
                )
              : const SizedBox(width: 0.0, height: 0.0);
        } else if (state is GetAutoCompleteEmptyState) {
          return Center(
            child: TextWidget(
              'Tidak ditemukan',
              size: TextWidgetSize.h6,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  listSearch({Function()? onTap, String? placeName, String? placeAddress}) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.size16, vertical: Dimens.size10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.map_outlined,
                          size: 16,
                        ),
                        divideW16,
                        Expanded(
                          child: TextWidget(
                            '${placeName ?? ''}, ${placeAddress ?? ''}',
                            size: TextWidgetSize.h7,
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}

class MaxSearchBar extends StatelessWidget {
  String? hintText;
  final TextEditingController? controller;
  bool readOnly, withPaddingHorizontal, autoFocus;
  final Function(String)? onChanged;
  final Function()? onClick;
  MaxSearchBar(
      {Key? key,
      this.hintText,
      this.controller,
      this.onChanged,
      this.readOnly = false,
      this.withPaddingHorizontal = true,
      this.autoFocus = false,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.size10),
        padding: EdgeInsets.symmetric(
            horizontal: withPaddingHorizontal ? Dimens.size16 : 0.0),
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100, // Shadow color
                blurRadius: 4, // Spread of the shadow
                offset: const Offset(0, 4), // Offset of the shadow (x, y)
              ),
            ],
          ),
          child: TextField(
            readOnly: readOnly,
            controller: controller,
            autofocus: autoFocus,
            style: const TextStyle(
              fontSize: Dimens.size16,
              fontStyle: FontStyle.normal,
            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: ('$hintText'),
              hintStyle: const TextStyle(
                color: Pallete.textPlaceholder,
                fontSize: Dimens.size16,
              ),
              prefixIcon:
                  const Icon(Icons.search, color: Colors.black, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}
