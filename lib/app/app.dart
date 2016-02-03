library start;

import 'dart:async';
import 'dart:html';

//angular2
import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:angular2/router.dart';

//data
import 'package:ng2-dart-start/shared/schemas.dart';

//components
part 'main.component.dart';
part 'components/home.dart';

//services
part 'services/query_service.dart';

//pipes

//injectables
const List<Type> injectables = const [MainComponent, QueryService];
