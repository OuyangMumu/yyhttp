import 'package:yyhttp/http/annotation/http_annotation.dart';
import 'package:yyhttp/http/builder/impl/http_model_build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

/// 生成json解析类
class JsonParseBuild extends GeneratorForAnnotation<HttpJsonParse> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var clsPaths = <String>[];
    var addModelMethodSB = StringBuffer();
    var importModelSb = StringBuffer();
    HttpModelBuild.models.forEach((element) {
      addModelMethodSB.write("""
      modelDataMap['${element.clsName}']=(json){
        return ${element.clsName}.fromJson(json);
      };
      \n
      """);
      if (!clsPaths.contains(element.clsPath)) {
        clsPaths.add(element.clsPath);
        importModelSb.write("import 'package:${element.clsPath}';\n");
      }
    });
    String str = "$classStr";

    str = str.replaceFirst("[-import-]", importModelSb.toString());
    str = str.replaceFirst("[-init-]", addModelMethodSB.toString());
    return str;
  }
}

String classStr = """
  import 'dart:convert';
  import 'package:yyhttp/http/net/http.dart';
  [-import-]

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

  JsonParse(){
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
      print("parse json error:\$data");
    }
    return null;
  }
  init(){
    [-init-]
  }

}

typedef _JsonParseModelCall =dynamic Function(Map<String, dynamic> data);
  """;
