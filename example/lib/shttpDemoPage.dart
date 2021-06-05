import 'package:flutter/material.dart';
import 'package:yyhttp/http/net/http.dart';
import 'package:yyhttp_example/Model/model.dart';
import 'package:yyhttp/http/extension/http_extension.dart';

class yyhttpDemoPage extends StatefulWidget {
  @override
  _yyhttpDemoPageState createState() => _yyhttpDemoPageState();
}

class _yyhttpDemoPageState extends State<yyhttpDemoPage> {
  var msg = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  // http://poetry.apiopen.top/sentences
                  TestModel model = await Http().get<TestModel>("sentences");
                  print(model.name + model.from);
                  setState(() {
                    msg = model.toJson().toString();
                  });
                },
                child: Text(
                  'get',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                )),
            ElevatedButton(
                onPressed: () async {
                  await "getTime".get(
                      onSuccess: (res) {
                        setState(() {
                          msg = res.toString();
                        });
                      },
                      onError: (code, error1, error2, xx) {});
                },
                child: Text(
                  'string get',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                )),
            Text(
              msg,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            )
          ],
        ));
  }
}
