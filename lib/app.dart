import 'package:flutter/material.dart';

import 'view/counter_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive DB Tutorials',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CounterView(),
    );
  }
}
