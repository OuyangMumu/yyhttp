import 'package:build/build.dart';
import 'package:yyhttp/http/builder/impl/http_model_build.dart';
import 'package:source_gen/source_gen.dart';
import 'impl/json_parse_build.dart';

Builder buildModel(BuilderOptions options) {
  return LibraryBuilder(HttpModelBuild(), generatedExtension: ".model.g.dart");
}

Builder buildJson(BuilderOptions options) {
  return LibraryBuilder(JsonParseBuild(), generatedExtension: ".json.g.dart");
}
