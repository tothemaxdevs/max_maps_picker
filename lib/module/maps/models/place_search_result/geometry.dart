import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location.dart';
import 'viewport.dart';

part 'geometry.g.dart';

@JsonSerializable()
class Geometry extends Equatable {
  final Location? location;
  final Viewport? viewport;

  const Geometry({this.location, this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return _$GeometryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GeometryToJson(this);

  Geometry copyWith({
    Location? location,
    Viewport? viewport,
  }) {
    return Geometry(
      location: location ?? this.location,
      viewport: viewport ?? this.viewport,
    );
  }

  @override
  List<Object?> get props => [location, viewport];
}
