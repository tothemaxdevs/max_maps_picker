import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'opening_hours.g.dart';

@JsonSerializable()
class OpeningHours extends Equatable {
  @JsonKey(name: 'open_now')
  final bool? openNow;

  const OpeningHours({this.openNow});

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return _$OpeningHoursFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OpeningHoursToJson(this);

  OpeningHours copyWith({
    bool? openNow,
  }) {
    return OpeningHours(
      openNow: openNow ?? this.openNow,
    );
  }

  @override
  List<Object?> get props => [openNow];
}
