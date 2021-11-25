import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  bool status;
  String message;
  String api;

  Message(this.status, this.message, this.api);

  //from json to dart obj (using json_annotation pkgs)
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  //and then  => flutter pub run build_runner watch (in terminal)  with 2 dart file (insert _.g.dart)
}
