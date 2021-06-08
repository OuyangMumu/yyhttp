## Http

### 安装

```yaml
dependencies:
  yyhttp:
    git:
      url: https://github.com/OuyangMumu/yyhttp.git
      
dev_dependencies:
  build_runner: ^1.10.0
```

### 可以直接使用`Http()`获取网络请求对象，该对象是个单例
```dart
/// 直接获取请求数据
var data = await Http().get<String>("http://******.com")
pritln(data)
```

### 转换成Modell，可以添加数据转换器转换成Model，可以继承DataParse实现字符串到Model的转换，默认已经实现了json到Model的转换可以参照JsonParse

```dart
/// 可以在类或者方法上添加@HttpParse()注解
@HttpJsonParse()
main(Widget widget)  {
  runApp(widget);
}

/// 在model上添加@HttpModel()，注意要实现toJson和fromJson方法
/// 可以在这个网页上通过json生成model[Link](https://javiercbk.github.io/json_to_dart/)自动带有toJson和fromJson方法

@HttpModel()
class TestModel {
  String s;

  TestModel({this.s});

  TestModel.fromJson(Map<String, dynamic> json) {
    s = json['s'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s'] = this.s;
    return data;
  }
}

/// example路径下 执行shell命令 flutter packages pub run build_runner build --delete-conflicting-outputs
///在目录下生成*.json.g.dart文件


/// 添加json解析器
Http().addParse(JsonParse());

/// 发起请求即可解析成对应Model, 对于数据路径解析问题,  可根据具体项目/接口 修改代码生成器
TestModel model = await Http().get<TestModel>("http://******.com")
```
### 也可以在回调中获取请求的数据
```dart
/// onSuccess 成功回调
/// onError 错误回调
 Http().get<TestData>("http://******.com",onError: (stsatusCode, data, errorMsg, e) {},onSuccess: (res) {})
```

### 设置BaseUrl
```dart
Http().addClientUrl("http://***.com");
/// 如果又多个服务器可以添加多个，用tag来区分
Http().addClientUrl("http://***.com",tag:"client1");
Http().addClientUrl("http://***.com",tag:"client2");
Http().addClient(Dio(),tag: "client3");

/// 添加client后可以通过Dio对象
Dio dio= Http().getClient(tag:"client1");

/// 请求可以通过指定tag请求不同的服务器,不传递为默认
var res1=await Http().get("login",tag:"client1")
var res2=await Http().get("exit",tag:"client2")
```

### 添加全局拦截器
```dart
/// 每个client的请求都拦截，需要单独对某个client进行设置的话，可以通过`Http().getClient()`获取客户端设置
Http().addGlobalInterceptor(interceptor)
```
### 可以通过字符串扩展方法直接请求

```dart
/// 导入
import 'package:mobile_base/http/extension/http_extension.dart';

var url="http://baidu.com";
var data=await url.get();

```
