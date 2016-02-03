import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:angular2/router.dart';
import 'package:ng2-dart-start/app/app.dart';

void main() {
  var app = MainComponent;
  var bindings = [ROUTER_BINDINGS, injectables,
  bind(APP_BASE_HREF).toValue('/'),
  bind(LocationStrategy).toClass(HashLocationStrategy)];

  bootstrap(app, bindings);
}