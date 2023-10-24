import 'package:financialweb/controllers/events_controller.dart';
import 'package:financialweb/models/bill.dart';
import 'package:financialweb/models/event.dart';
import 'package:financialweb/models/person.dart';
import 'package:financialweb/repositories/events_repository.dart';
import 'package:financialweb/repositories/person_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'controllers/person_controller.dart';
import 'router.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EventAdapter());
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(BillAdapter());

  runApp(MultiProvider(
    providers: [
      Provider<EventsRepository>(
        create: (_) => EventsRepository(),
      ),
      Provider<PersonRepository>(
        create: (_) => PersonRepository(),
      ),
      ChangeNotifierProvider<EventsController>(
          create: (context) =>
              EventsController(context.read<EventsRepository>())),
      ChangeNotifierProvider<PersonController>(
          create: (context) =>
              PersonController(context.read<PersonRepository>()))
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Events App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
