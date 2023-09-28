import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plus_code.g.dart';

@JsonSerializable()
class PlusCode extends Equatable {
  @JsonKey(name: 'compound_code')
  final String? compoundCode;
  @JsonKey(name: 'global_code')
  final String? globalCode;

  const PlusCode({this.compoundCode, this.globalCode});

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return _$PlusCodeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PlusCodeToJson(this);

  PlusCode copyWith({
    String? compoundCode,
    String? globalCode,
  }) {
    return PlusCode(
      compoundCode: compoundCode ?? this.compoundCode,
      globalCode: globalCode ?? this.globalCode,
    );
  }

  @override
  List<Object?> get props => [compoundCode, globalCode];
}
