import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo extends Equatable {
  final int? height;
  @JsonKey(name: 'html_attributions')
  final List<String>? htmlAttributions;
  @JsonKey(name: 'photo_reference')
  final String? photoReference;
  final int? width;

  const Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  Photo copyWith({
    int? height,
    List<String>? htmlAttributions,
    String? photoReference,
    int? width,
  }) {
    return Photo(
      height: height ?? this.height,
      htmlAttributions: htmlAttributions ?? this.htmlAttributions,
      photoReference: photoReference ?? this.photoReference,
      width: width ?? this.width,
    );
  }

  @override
  List<Object?> get props {
    return [
      height,
      htmlAttributions,
      photoReference,
      width,
    ];
  }
}
