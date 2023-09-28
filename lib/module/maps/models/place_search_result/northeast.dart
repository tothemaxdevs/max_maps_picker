import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'northeast.g.dart';

@JsonSerializable()
class Northeast extends Equatable {
  final double? lat;
  final double? lng;

  const Northeast({this.lat, this.lng});

  factory Northeast.fromJson(Map<String, dynamic> json) {
    return _$NortheastFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NortheastToJson(this);

  Northeast copyWith({
    double? lat,
    double? lng,
  }) {
    return Northeast(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}
