// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: JsonParseBuild
// **************************************************************************

import 'dart:convert';
import 'package:yyhttp/http/net/http.dart';
import 'package:yyhttp_example/Model/model.dart';

/*
  @HttpModel()
  class STest {
    String name;

    STest({this.name});
    
    // 要实现fromJson方法
    STest.fromJson(Map<String, dynamic> json) {
      name = json['name'];
    }

    // 要实现toJson方法
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['name'] = this.name;
      return data;
    }
  }
  */

/// 使用Http().addParse(JsonParse()) ，添加到Http解析中配合使用
/// 也可以Test bean= JsonParse().parse<Test>(json) 直接使用
class JsonParse implements DataParse {
  var modelDataMap = <Object, _JsonParseModelCall>{};

  JsonParse() {
    init();
  }

  @override
  T parse<T>(String data) {
    try {
      var map = json.decode(data)["result"];
      var type = T.toString();
      for (var key in modelDataMap.keys) {
        if (key == type) {
          return modelDataMap[key](map);
        }
      }
    } catch (e) {
      print("parse json error:$data");
    }
    return null;
  }

  init() {
    modelDataMap['TestModel'] = (json) {
      return TestModel.fromJson(json);
    };
  }
}

typedef _JsonParseModelCall = dynamic Function(Map<String, dynamic> data);
