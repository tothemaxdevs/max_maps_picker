import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'southwest.g.dart';

@JsonSerializable()
class Southwest extends Equatable {
  final double? lat;
  final double? lng;

  const Southwest({this.lat, this.lng});

  factory Southwest.fromJson(Map<String, dynamic> json) {
    return _$SouthwestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SouthwestToJson(this);

  Southwest copyWith({
    double? lat,
    double? lng,
  }) {
    return Southwest(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}
