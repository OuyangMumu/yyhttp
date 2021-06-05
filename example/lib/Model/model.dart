import 'package:yyhttp/http/annotation/http_annotation.dart';

@HttpModel()
class TestModel {
  String name;
  String from;

  TestModel({this.name, this.from});

  TestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    from = json['from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['from'] = this.from;
    return data;
  }
}
