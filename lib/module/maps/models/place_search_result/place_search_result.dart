import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'geometry.dart';
import 'opening_hours.dart';
import 'photo.dart';
import 'plus_code.dart';

part 'place_search_result.g.dart';

@JsonSerializable()
class PlaceSearchResult extends Equatable {
  @JsonKey(name: 'business_status')
  final String? businessStatus;
  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;
  final Geometry? geometry;
  final String? icon;
  @JsonKey(name: 'icon_background_color')
  final String? iconBackgroundColor;
  @JsonKey(name: 'icon_mask_base_uri')
  final String? iconMaskBaseUri;
  final String? name;
  @JsonKey(name: 'opening_hours')
  final OpeningHours? openingHours;
  final List<Photo>? photos;
  @JsonKey(name: 'place_id')
  final String? placeId;
  @JsonKey(name: 'plus_code')
  final PlusCode? plusCode;
  final double? rating;
  final String? reference;
  final List<String>? types;
  @JsonKey(name: 'user_ratings_total')
  final int? userRatingsTotal;

  const PlaceSearchResult({
    this.businessStatus,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.types,
    this.userRatingsTotal,
  });

  factory PlaceSearchResult.fromJson(Map<String, dynamic> json) {
    return _$PlaceSearchResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PlaceSearchResultToJson(this);

  PlaceSearchResult copyWith({
    String? businessStatus,
    String? formattedAddress,
    Geometry? geometry,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    String? name,
    OpeningHours? openingHours,
    List<Photo>? photos,
    String? placeId,
    PlusCode? plusCode,
    double? rating,
    String? reference,
    List<String>? types,
    int? userRatingsTotal,
  }) {
    return PlaceSearchResult(
      businessStatus: businessStatus ?? this.businessStatus,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      geometry: geometry ?? this.geometry,
      icon: icon ?? this.icon,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      iconMaskBaseUri: iconMaskBaseUri ?? this.iconMaskBaseUri,
      name: name ?? this.name,
      openingHours: openingHours ?? this.openingHours,
      photos: photos ?? this.photos,
      placeId: placeId ?? this.placeId,
      plusCode: plusCode ?? this.plusCode,
      rating: rating ?? this.rating,
      reference: reference ?? this.reference,
      types: types ?? this.types,
      userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
    );
  }

  @override
  List<Object?> get props {
    return [
      businessStatus,
      formattedAddress,
      geometry,
      icon,
      iconBackgroundColor,
      iconMaskBaseUri,
      name,
      openingHours,
      photos,
      placeId,
      plusCode,
      rating,
      reference,
      types,
      userRatingsTotal,
    ];
  }
}
