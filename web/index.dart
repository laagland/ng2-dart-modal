import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/bootstrap.dart';
import 'package:ng2_dart_modal/app.dart';
import 'package:ng2_dart_modal/src/ng2_dart_modal.dart';

void main() {
  var app = DemoApp;
  var bindings = [injectables,
    ROUTER_PROVIDERS,
    provide(ModalConfig, useValue: new ModalConfig(size: 'lg', isBlocking: true, keyboard: 81)),
    bind(APP_BASE_HREF).toValue('/'),
    bind(LocationStrategy).toClass(HashLocationStrategy)
  ];

  bootstrap(app, bindings);
}

//document.addEventListener('DOMContentLoaded', main);
