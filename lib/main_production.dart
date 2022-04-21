import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'app/app.dart';
import 'bootstrap.dart';
import 'core/lactor/service_locator.dart' as lacator;
import 'features/number_trivia/data/models/number_trivia_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await lacator.appInit();
  final appDocumentDir = await path.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox<NumberTriviaModel>('NumberTrivia');
  await bootstrap(() => const App());
}
