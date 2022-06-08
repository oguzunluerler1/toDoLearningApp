import 'package:flutter/material.dart';
import 'package:todo/screens/to_do.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedManager.SharedPreferencesInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: ToDo(),
      );
  }
}