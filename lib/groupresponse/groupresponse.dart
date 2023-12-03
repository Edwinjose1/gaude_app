import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'groupresponse.g.dart';

@JsonSerializable()
class Groupresponse {
  List<Result>? result;
  bool? status;
  String? message;

  Groupresponse({this.result, this.status, this.message});

  factory Groupresponse.fromJson(Map<String, dynamic> json) {
    return _$GroupresponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GroupresponseToJson(this);
}
