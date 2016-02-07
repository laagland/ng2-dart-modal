library ng2_dart_modal_demo;

//dart
import 'dart:async';

//angular2
import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

//src
import 'src/ng2_dart_modal.dart';

//components
part 'demo/demo-app.dart';
part 'demo/demoPage/demoPage.dart';
part 'demo/sampleElement/sampleElement.dart';
part 'demo/customModalDemo/customModal.dart';

//injectables
const List<Type> injectables = const [Modal];
