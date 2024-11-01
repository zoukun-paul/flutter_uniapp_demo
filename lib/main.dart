import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UniAPP Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              TextButton(onPressed: () async {
                const channel = MethodChannel('UniMP_mini_apps');
                channel.invokeMethod("open",{'AppID': "__UNI__3BC70CE"});
              }, child: Text("local-uniAPP-1")),
            TextButton(onPressed: () async {
              const channel = MethodChannel('UniMP_mini_apps');
              channel.invokeMethod("open",{'AppID': "__UNI__7AEA00D", "remote":true});
            }, child: Text("remote-uniAPP-1"))

          ],
        ),
      ),
    );
  }
}
