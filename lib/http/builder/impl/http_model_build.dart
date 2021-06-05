import 'package:analyzer/dart/element/element.dart';
import 'package:yyhttp/http/annotation/http_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

/// 获取解析需要解析json的model
class HttpModelBuild extends GeneratorForAnnotation<HttpModel> {
  static var models = <ModelData>[];

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      throw "@HttpModel It only applies to classes";
    }
    var clsPath = element.librarySource.fullName;
    var libIndex = clsPath.indexOf("lib") + 3;
    clsPath = clsPath.substring(libIndex, clsPath.length);
    var pkg = "${buildStep.inputId.package}$clsPath";

    var modelInfo = ModelData(element.displayName, pkg);
    models.add(modelInfo);
    print("modelBean:${modelInfo.toString()}");
  }
}

class ModelData {
  ModelData(this.clsName, this.clsPath);
  final String clsName;
  final String clsPath;
  @override
  String toString() {
    return "clsName:$clsName clsPath:$clsPath";
  }
}
