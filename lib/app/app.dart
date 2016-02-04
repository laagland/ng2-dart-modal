library ng_dart_modal;

import 'dart:async';
import 'dart:html';

//angular2
import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:angular2/router.dart';

//data
import 'package:ng2_dart_modal/shared/schemas.dart';

//components
part 'main.component.dart';
part 'components/home.dart';

part 'components/modalbackdrop.dart';
part 'components/bootstrapmodalcontainer.dart';

//providers
part 'providers/modal.dart';

//common
part 'common/yesnomodal.dart';
part 'common/okonlymodal.dart';

//pipes

//injectables
const List<Type> injectables = const [MainComponent];
