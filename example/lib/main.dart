import 'package:flutter/material.dart';
import 'package:yyhttp/http/annotation/http_annotation.dart';
import 'package:yyhttp/http/net/http.dart';
import 'package:yyhttp_example/shttpDemoPage.dart';
import 'package:yyhttp_example/main.json.g.dart';

@HttpJsonParse()
void main() {
  httpInit();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: yyhttpDemoPage(),
    );
  }
}

void httpInit() {
  /// json解析器
  Http().addParse(JsonParse());

  /// 添加鉴权拦截器
  // Http().addGlobalInterceptor(AuthInter());
  // Http().addGlobalInterceptor(HttpLogInterceptor());

  /// 添加主域名
  // Http().addClientUrl("http://poetry.apiopen.top/");
  Http().addClientUrl("http://poetry.apiopen.top/", tag: "default");
}
