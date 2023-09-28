import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'northeast.dart';
import 'southwest.dart';

part 'viewport.g.dart';

@JsonSerializable()
class Viewport extends Equatable {
  final Northeast? northeast;
  final Southwest? southwest;

  const Viewport({this.northeast, this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return _$ViewportFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ViewportToJson(this);

  Viewport copyWith({
    Northeast? northeast,
    Southwest? southwest,
  }) {
    return Viewport(
      northeast: northeast ?? this.northeast,
      southwest: southwest ?? this.southwest,
    );
  }

  @override
  List<Object?> get props => [northeast, southwest];
}
