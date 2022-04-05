import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:edsa/screens/RmAndProd.dart';
import 'package:edsa/screens/centrestage.dart';
import 'package:edsa/screens/navigation.dart';

import 'objectbox.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edsa Feeds',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Store _store;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        // This method is from the generated file
        getObjectBoxModel(),
        directory: join(dir.path, 'edsadb2'),
      );
    }).then((_value) {
      setState(() {
        initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initialized
          ? Row(
              children: [
                Expanded(flex: 1, child: RMandProductScreen(store: _store)),
                Expanded(flex: 3, child: CentrePiece(store: _store)),
                Expanded(flex: 1, child: NavigationScreen(store: _store)),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
